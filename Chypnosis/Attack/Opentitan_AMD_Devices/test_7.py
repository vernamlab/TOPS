"""Binary-protocol AES verification helper for an OpenTitan UART image."""

from __future__ import annotations

import argparse

from Chypnosis.Attack.Opentitan.uart_aes import (
    BinaryAesClient,
    SerialConfig,
    parse_hex_block,
    reference_aes_ecb_encrypt,
)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Set key, optionally send a masking seed, encrypt one block, and verify the result."
    )
    parser.add_argument("--port", required=True, help="Serial port name, for example COM5 or /dev/ttyUSB0.")
    parser.add_argument("--baudrate", type=int, default=115200)
    parser.add_argument("--timeout", type=float, default=1.0)
    parser.add_argument(
        "--key",
        default="00112233445566778899aabbccddeeff",
        help="AES-128 key in hex.",
    )
    parser.add_argument(
        "--plaintext",
        default="112233445566778899aabbccddeeff00",
        help="Plaintext block in hex.",
    )
    parser.add_argument(
        "--mask-seed",
        default="112233445566778899aabbccddeeff00",
        help="16-byte payload for the 'l' command when the firmware supports it.",
    )
    parser.add_argument(
        "--send-mask-seed",
        action="store_true",
        help="Send the 'l' command before setting the key.",
    )
    return parser


def main() -> None:
    args = build_parser().parse_args()
    config = SerialConfig(port=args.port, baudrate=args.baudrate, timeout=args.timeout)
    key = parse_hex_block(args.key, "key")
    plaintext = parse_hex_block(args.plaintext, "plaintext")
    mask_seed = parse_hex_block(args.mask_seed, "mask-seed")

    with BinaryAesClient(config) as client:
        if args.send_mask_seed:
            response = client.set_mask_seed(mask_seed)
            print(f"Mask seed sent: {mask_seed.hex()}")
            if response:
                print(f"Masking response: {response!r}")

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
    for index, (got, ref) in enumerate(zip(ciphertext, expected)):
        status = "OK" if got == ref else "DIFF"
        print(f"Byte {index:02d}: got=0x{got:02x} expected=0x{ref:02x} {status}")
    raise SystemExit(1)


if __name__ == "__main__":
    main()
