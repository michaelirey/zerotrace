#!/bin/bash
set -e
set -o pipefail

# Function to generate a secure password without newlines
generate_password() {
    openssl rand -base64 64 | tr -d '\n'
}

# Function to encrypt the file
encrypt_file() {
    PASSWORD1=$(generate_password)
    PASSWORD2=$(generate_password)
    PASSWORD3=$(generate_password)

    OUTPUT_FILE="${INPUT_FILE}.locked"
    KEY_FILE="${INPUT_FILE}.key"

    # Perform encryption using the generated passwords
    # First encryption with AES-256-CBC
    openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 -pass pass:"$PASSWORD1" -in "$INPUT_FILE" -out /dev/stdout | \
    # Second encryption with Camellia-256-CBC
    openssl enc -camellia-256-cbc -salt -pbkdf2 -iter 100000 -pass pass:"$PASSWORD2" -in /dev/stdin -out /dev/stdout | \
    # Third encryption with ChaCha20
    openssl enc -chacha20 -salt -pbkdf2 -iter 100000 -pass pass:"$PASSWORD3" -in /dev/stdin -out "$OUTPUT_FILE"

    # Create JSON content with passwords
    json_content=$(jq -n --arg p1 "$PASSWORD1" --arg p2 "$PASSWORD2" --arg p3 "$PASSWORD3" \
        '{password1: $p1, password2: $p2, password3: $p3}')

    # Base64 encode and save to key file
    echo "$json_content" | base64 > "$KEY_FILE"

    echo "Encryption complete. Key file has been saved as: $KEY_FILE"
    echo "File encrypted successfully: $OUTPUT_FILE"
}

# Function to decrypt the file
decrypt_file() {
    OUTPUT_FILE="${INPUT_FILE%.locked}.unlocked"

    # Check if key file exists
    if [ ! -f "$KEY_FILE" ]; then
        echo "Error: Key file '$KEY_FILE' does not exist."
        exit 1
    fi

    # Read and decode the key file
    json_content=$(base64 -d "$KEY_FILE")

    # Extract passwords using jq
    PASSWORD1=$(echo "$json_content" | jq -r '.password1')
    PASSWORD2=$(echo "$json_content" | jq -r '.password2')
    PASSWORD3=$(echo "$json_content" | jq -r '.password3')

    if [ -z "$PASSWORD1" ] || [ -z "$PASSWORD2" ] || [ -z "$PASSWORD3" ]; then
        echo "Error: Passwords could not be extracted from key file."
        exit 1
    fi

    # Perform decryption in reverse order
    # First decryption with ChaCha20
    openssl enc -d -chacha20 -pbkdf2 -iter 100000 -pass pass:"$PASSWORD3" -in "$INPUT_FILE" -out /dev/stdout | \
    # Second decryption with Camellia-256-CBC
    openssl enc -d -camellia-256-cbc -pbkdf2 -iter 100000 -pass pass:"$PASSWORD2" -in /dev/stdin -out /dev/stdout | \
    # Third decryption with AES-256-CBC
    openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 -pass pass:"$PASSWORD1" -in /dev/stdin -out "$OUTPUT_FILE"

    echo "Decryption complete. File saved as: $OUTPUT_FILE"
}

# Main script logic
if [ "$1" == "encrypt" ]; then
    if [ "$#" -ne 2 ]; then
        echo "Usage: entrypoint.sh encrypt <input_file>"
        exit 1
    fi
    INPUT_FILE="$2"

    if [ ! -f "$INPUT_FILE" ]; then
        echo "Error: Input file '$INPUT_FILE' does not exist."
        exit 1
    fi

    encrypt_file

elif [ "$1" == "decrypt" ]; then
    if [ "$#" -ne 3 ]; then
        echo "Usage: entrypoint.sh decrypt <encrypted_file> <key_file>"
        exit 1
    fi
    INPUT_FILE="$2"
    KEY_FILE="$3"

    if [ ! -f "$INPUT_FILE" ]; then
        echo "Error: Encrypted file '$INPUT_FILE' does not exist."
        exit 1
    fi

    if [ ! -f "$KEY_FILE" ]; then
        echo "Error: Key file '$KEY_FILE' does not exist."
        exit 1
    fi

    decrypt_file

else
    echo "Usage: entrypoint.sh <encrypt|decrypt> <input_file> [key_file]"
    exit 1
fi
