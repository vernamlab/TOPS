"""Set an AES key on the OpenTitan UART test image."""

from __future__ import annotations

import argparse

from Chypnosis.Attack.Opentitan.uart_aes import AsciiAesClient, BinaryAesClient, SerialConfig, parse_hex_block


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Send a 16-byte AES key to an OpenTitan UART target."
    )
    parser.add_argument("--port", required=True, help="Serial port name, for example COM5 or /dev/ttyUSB0.")
    parser.add_argument(
        "--key",
        default="00112233445566778899aabbccddeeff",
        help="32 hex characters representing the AES-128 key.",
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
    key = parse_hex_block(args.key, "key")
    config = SerialConfig(port=args.port, baudrate=args.baudrate, timeout=args.timeout)

    if args.protocol == "ascii":
        with AsciiAesClient(config) as client:
            response = client.set_key(key)
    else:
        with BinaryAesClient(config) as client:
            response = client.set_key(key)

    print(f"Sent AES key: {key.hex()}")
    if response:
        print(f"Device response: {response!r}")
    else:
        print("No response received after key write.")


if __name__ == "__main__":
    main()
