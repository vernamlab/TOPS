"""ASCII-protocol AES verification helper for an OpenTitan UART image."""

from __future__ import annotations

import argparse

from Chypnosis.Attack.Opentitan.uart_aes import (
    AsciiAesClient,
    SerialConfig,
    parse_hex_block,
    reference_aes_ecb_encrypt,
)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Verify AES encryption over the ASCII line-based UART protocol."
    )
    parser.add_argument("--port", required=True, help="Serial port name, for example COM5 or /dev/ttyUSB0.")
    parser.add_argument("--baudrate", type=int, default=115200)
    parser.add_argument("--timeout", type=float, default=1.0)
    parser.add_argument(
        "--key",
        default="811E3731B0120A7842781E22B25CDDF9",
        help="AES-128 key in hex.",
    )
    parser.add_argument(
        "--plaintext",
        default="AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
        help="Plaintext block in hex.",
    )
    return parser


def main() -> None:
    args = build_parser().parse_args()
    config = SerialConfig(port=args.port, baudrate=args.baudrate, timeout=args.timeout)
    key = parse_hex_block(args.key, "key")
    plaintext = parse_hex_block(args.plaintext, "plaintext")

    with AsciiAesClient(config) as client:
        key_response = client.set_key(key)
        if key_response:
            print(f"Key response: {key_response!r}")
        ciphertext = client.encrypt(plaintext)

    expected = reference_aes_ecb_encrypt(key, plaintext)
    print(f"Key       : {key.hex()}")
    print(f"Plaintext : {plaintext.hex()}")
    print(f"Expected  : {expected.hex()}")
    print(f"Observed  : {ciphertext.hex()}")

    if ciphertext == expected:
        print("AES verification succeeded.")
        return

    print("AES verification failed.")
    raise SystemExit(1)


if __name__ == "__main__":
    main()
