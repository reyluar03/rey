#!/bin/bash

# Panda Encryption
#Rey DC Luar Jr.
set -euf -o pipefail
print_usage() {
    echo "Contact Rey DC Luar Jr. for the guides"

}

if [[ ! -x $(which openssl) ]] || [[ ! -x $(which shred) ]] || [[ ! -x $(which gzip) ]] || [[ ! -x $(which zcat) ]]; then
    echo "[-] Dependencies unmet.  Please verify that the following are installed and in the PATH:  openssl, shred, gzip, zcat" >&2
    exit 1
fi
if [[ $# -lt 2 ]] || [[ $# -gt 3 ]]; then
    print_usage
    exit 1
fi
COMMAND="$1"
INPUT_FILE="$2"
if [[ ! -e "$INPUT_FILE" ]]; then
    echo "[-] Input file '$INPUT_FILE' does not exist." >&2
    exit 1
fi
if [[ "$COMMAND" == "decrypt" ]]; then
    if [[ $# != 3 ]]; then
        print_usage
        exit 1
    fi
    OUTPUT_FILE="$3"
    openssl enc -aes-256-ctr -d -in "$INPUT_FILE" | zcat > "$OUTPUT_FILE"
    echo "[*] ' Server Ecryptor by Rey Luar Jr."

else
    print_usage
    exit 1
fi
