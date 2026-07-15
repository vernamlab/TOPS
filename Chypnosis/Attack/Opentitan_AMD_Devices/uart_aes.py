"""Helpers for talking to an OpenTitan AES test image over UART.

The scripts in this folder intentionally stay small and readable.  The firmware
interface is not always identical across experiments, so this module supports
two common variants seen in this repo:

- a binary protocol using single-byte commands such as ``k`` and ``p``
- an ASCII protocol using lines like ``k0011...\\n`` and responses like ``r:...``
"""

from __future__ import annotations

import time
from dataclasses import dataclass

import serial

try:
    from Crypto.Cipher import AES
except ImportError:  # pragma: no cover - optional during simple UART use
    AES = None


AES_BLOCK_BYTES = 16


def parse_hex_block(value: str, name: str) -> bytes:
    """Parse a 16-byte AES block from hex."""
    data = bytes.fromhex(value)
    if len(data) != AES_BLOCK_BYTES:
        raise ValueError(f"{name} must be exactly 16 bytes (32 hex characters).")
    return data


def reference_aes_ecb_encrypt(key: bytes, plaintext: bytes) -> bytes:
    """Encrypt one block with PyCryptodome for verification."""
    if AES is None:
        raise RuntimeError(
            "PyCryptodome is required for verification. Install 'pycryptodome'."
        )
    return AES.new(key, AES.MODE_ECB).encrypt(plaintext)


@dataclass
class SerialConfig:
    port: str
    baudrate: int = 115200
    timeout: float = 1.0
    boot_delay: float = 0.2


class BinaryAesClient:
    """Client for binary UART commands.

    Supported command bytes:
    - ``k`` + 16-byte key
    - ``p`` + 16-byte plaintext
    - ``l`` + 16-byte seed/share payload for masking-related experiments
    """

    def __init__(self, config: SerialConfig) -> None:
        self.config = config
        self.serial_port = serial.Serial(
            port=config.port,
            baudrate=config.baudrate,
            timeout=config.timeout,
            bytesize=serial.EIGHTBITS,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            xonxoff=False,
        )
        time.sleep(config.boot_delay)

    def close(self) -> None:
        self.serial_port.close()

    def __enter__(self) -> "BinaryAesClient":
        return self

    def __exit__(self, exc_type, exc, tb) -> None:
        self.close()

    def send_command(self, command: str, payload: bytes = b"") -> None:
        if len(command) != 1:
            raise ValueError("command must be a single character.")
        self.serial_port.write(command.encode("ascii") + payload)

    def read_all_available(self) -> bytes:
        time.sleep(0.05)
        return self.serial_port.read_all()

    def read_ciphertext(self) -> bytes:
        """Read a ciphertext response.

        Some firmware builds respond with exactly 16 bytes.
        Others return ``b'r' + ciphertext``.
        """
        raw = self.serial_port.read(AES_BLOCK_BYTES + 1)
        if len(raw) >= AES_BLOCK_BYTES + 1 and raw[0:1] == b"r":
            return raw[1 : AES_BLOCK_BYTES + 1]
        if len(raw) >= AES_BLOCK_BYTES:
            return raw[:AES_BLOCK_BYTES]
        raise RuntimeError(
            f"Expected {AES_BLOCK_BYTES} or {AES_BLOCK_BYTES + 1} response bytes, got {len(raw)}."
        )

    def set_key(self, key: bytes) -> bytes:
        self.send_command("k", key)
        return self.read_all_available()

    def set_mask_seed(self, seed: bytes) -> bytes:
        self.send_command("l", seed)
        return self.read_all_available()

    def encrypt(self, plaintext: bytes) -> bytes:
        self.send_command("p", plaintext)
        time.sleep(0.05)
        return self.read_ciphertext()


class AsciiAesClient:
    """Client for ASCII UART commands like ``k0011...`` and ``r:...``."""

    def __init__(self, config: SerialConfig) -> None:
        self.config = config
        self.serial_port = serial.Serial(
            port=config.port,
            baudrate=config.baudrate,
            timeout=config.timeout,
            bytesize=serial.EIGHTBITS,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            xonxoff=False,
        )
        time.sleep(config.boot_delay)

    def close(self) -> None:
        self.serial_port.close()

    def __enter__(self) -> "AsciiAesClient":
        return self

    def __exit__(self, exc_type, exc, tb) -> None:
        self.close()

    def send_packet(self, command: str, payload: bytes) -> None:
        if len(command) != 1:
            raise ValueError("command must be a single character.")
        packet = command.encode("ascii") + payload.hex().encode("ascii") + b"\n"
        self.serial_port.write(packet)

    def read_line(self) -> bytes:
        return self.serial_port.readline()

    def read_prefixed_hex(self, prefix: bytes = b"r:") -> bytes:
        line = self.read_line()
        if not line.startswith(prefix):
            raise RuntimeError(f"Unexpected response line: {line!r}")
        return bytes.fromhex(line[len(prefix) :].strip().decode("ascii"))

    def set_key(self, key: bytes) -> bytes:
        self.send_packet("k", key)
        time.sleep(0.05)
        return self.read_line()

    def encrypt(self, plaintext: bytes) -> bytes:
        self.send_packet("p", plaintext)
        time.sleep(0.05)
        return self.read_prefixed_hex()

