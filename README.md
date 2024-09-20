# ZeroTrace

**ZeroTrace: Simple Military-Grade Encryption**

ZeroTrace is a robust encryption tool that offers military-grade security with ease of use. It leverages industry-standard algorithms to ensure your data remains confidential and protected.

<p align="center">
  <img src="img/lock.jpeg" alt="ZeroTrace Lock" width="300">
</p>

## Quick Start

### Prerequisites

- **Docker**: [Install Docker](https://www.docker.com/get-started)

### Installation

Pull the ZeroTrace Docker image:

```bash
docker pull michaelirey/zerotrace
```

### Usage

#### Encrypt a File

1. **Create a secrets file:**

    ```bash
    echo "my secrets" > secrets.txt
    ```

2. **Encrypt the file:**

    ```bash
    docker run --rm -v "$(pwd)":/workspace michaelirey/zerotrace encrypt secrets.txt
    ```

    **Output:**
    ```
    Encryption complete. Key file has been saved as: secrets.txt.key
    File encrypted successfully: secrets.txt.locked
    ```

3. **Verify the encrypted files:**

    ```bash
    ls -l
    ```

    **Sample Output:**
    ```
    total 24
    drwxr-xr-x   5 user  staff   160 Sep 19 23:08 .
    drwxr-x---+ 55 user  staff  1760 Sep 19 23:07 ..
    -rw-r--r--   1 user  staff    11 Sep 19 23:08 secrets.txt
    -rw-r--r--   1 user  staff   438 Sep 19 23:08 secrets.txt.key
    -rw-r--r--   1 user  staff    80 Sep 19 23:08 secrets.txt.locked
    ```

#### Decrypt a File

1. **Decrypt the file:**

    ```bash
    docker run --rm -v "$(pwd)":/workspace michaelirey/zerotrace decrypt secrets.txt.locked secrets.txt.key
    ```

    **Output:**
    ```
    Decryption complete. File saved as: secrets.txt.unlocked
    ```

2. **Verify the decrypted file:**

    ```bash
    ls -l
    cat secrets.txt.unlocked
    ```

    **Sample Output:**
    ```
    total 32
    drwxr-xr-x   6 user  staff   192 Sep 19 23:09 .
    drwxr-x---+ 55 user  staff  1760 Sep 19 23:07 ..
    -rw-r--r--   1 user  staff    11 Sep 19 23:08 secrets.txt
    -rw-r--r--   1 user  staff   438 Sep 19 23:08 secrets.txt.key
    -rw-r--r--   1 user  staff    80 Sep 19 23:08 secrets.txt.locked
    -rw-r--r--   1 user  staff    11 Sep 19 23:09 secrets.txt.unlocked
    my secrets
    ```

## Features

- **Strong Encryption**: Utilizes AES-256-CBC, Camellia-256-CBC, and ChaCha20 algorithms.
- **Automatic Key Management**: Securely generates and handles encryption keys.
- **Dockerized**: Easy setup and cross-platform compatibility.
- **Open Source**: Transparent development on [GitHub](https://github.com/michaelirey/zerotrace).
- **No Backdoors**: Your data remains secure without any hidden access points.

## How It Works

1. **Encryption:**
   - Generates high-entropy passwords.
   - Applies triple-layer encryption using AES-256-CBC, Camellia-256-CBC, and ChaCha20.
   - Saves the encrypted keys in a `.key` file.

2. **Decryption:**
   - Uses the `.key` file to retrieve encryption keys.
   - Reverses the encryption layers to restore the original file.

## Security Considerations

- **Key File**: Store `.key` files securely. Loss or compromise can lead to data loss or breaches.
- **Backup**: Regularly back up your encrypted files and key files in secure locations.
- **No Master Password**: ZeroTrace uses key files for encryption and decryption without requiring a separate master password.

## License

Released under the **MIT License**. [View License](LICENSE)

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](https://github.com/michaelirey/zerotrace/blob/main/CONTRIBUTING.md) to get started.

## Contact

For support or inquiries, open an issue on [GitHub](https://github.com/michaelirey/zerotrace) or email us at [support@zerotraceproject.com](mailto:support@zerotraceproject.com).

---

**ZeroTrace: Protecting Your Data with Uncompromising Security**

## Additional Resources

- **Docker Hub**: [michaelirey/zerotrace](https://hub.docker.com/r/michaelirey/zerotrace)
- **GitHub Repository**: [michaelirey/zerotrace](https://github.com/michaelirey/zerotrace)

---

*ZeroTrace is provided "as is" without any warranties. Use responsibly and ensure compliance with local laws and regulations.*