#!/bin/bash

# Panda Encryption
#



# setup Bash environment
set -euf -o pipefail

#######################################
# Prints script usage to stderr
# Arguments:
#   None
# Returns:
#   None
#######################################
print_usage() {
  
    echo "       $0 decrypt <encryptedFile> <outputFile>" >&2
}

# ensure have all dependencies
if [[ ! -x $(which openssl) ]] || [[ ! -x $(which shred) ]] || [[ ! -x $(which gzip) ]] || [[ ! -x $(which zcat) ]]; then
    echo "[-] Dependencies unmet.  Please verify that the following are installed and in the PATH:  openssl, shred, gzip, zcat" >&2
    exit 1
fi

# check for number of arguments
if [[ $# -lt 2 ]] || [[ $# -gt 3 ]]; then
    print_usage
    exit 1
fi

# setup variables for arguments
COMMAND="$1"
INPUT_FILE="$2"

# test existence of input file
if [[ ! -e "$INPUT_FILE" ]]; then
    echo "[-] Input file '$INPUT_FILE' does not exist." >&2
    exit 1
fi

# switch on command
if [[ "$COMMAND" == "decrypt" ]]; then

    # decryption requires 3rd argument
    if [[ $# != 3 ]]; then
        print_usage
        exit 1
    fi

    # setup output filename
    OUTPUT_FILE="$3"

    # decrypt and decompress
    openssl enc -aes-256-ctr -d -in "$INPUT_FILE" | zcat > "$OUTPUT_FILE"
    # report success
    echo "[*] '$INPUT_FILE' has been decrypted.  Plaintext file exists at '$OUTPUT_FILE'."

else
    echo "[-] Unknown command '$COMMAND'." >&2
    print_usage
    exit 1
fi
