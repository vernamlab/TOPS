"""Send a plaintext block to the OpenTitan UART AES test image."""

from __future__ import annotations

import argparse

from Chypnosis.Attack.Opentitan.uart_aes import AsciiAesClient, BinaryAesClient, SerialConfig, parse_hex_block


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Send a plaintext block and print the returned ciphertext."
    )
    parser.add_argument("--port", required=True, help="Serial port name, for example COM5 or /dev/ttyUSB0.")
    parser.add_argument(
        "--plaintext",
        default="00112233445566778899aabbccddeeff",
        help="32 hex characters representing the AES plaintext block.",
    )
    parser.add_argument("--baudrate", type=int, default=115200)
    parser.add_argument("--timeout", type=float, default=1.0)
    parser.add_argument(
        "--protocol",
        choices=("binary", "ascii"),
        default="binary",
        help="Use 'ascii' for line-oriented firmware variants.",
    )
    return parser


def main() -> None:
    args = build_parser().parse_args()
    plaintext = parse_hex_block(args.plaintext, "plaintext")
    config = SerialConfig(port=args.port, baudrate=args.baudrate, timeout=args.timeout)

    if args.protocol == "ascii":
        with AsciiAesClient(config) as client:
            ciphertext = client.encrypt(plaintext)
    else:
        with BinaryAesClient(config) as client:
            ciphertext = client.encrypt(plaintext)

    print(f"Plaintext : {plaintext.hex()}")
    print(f"Ciphertext: {ciphertext.hex()}")


if __name__ == "__main__":
    main()
