
# ZeroTrace

**Ridiculously Strong Military-Grade Encryption Tool**

---

ZeroTrace is a powerful encryption tool that provides multi-layered, military-grade encryption using industry-standard algorithms. Designed for simplicity and security, it automates password generation and management, ensuring your data remains confidential and protected against unauthorized access.

---

**Introducing ZeroTrace: Ridiculously Strong Military-Grade Encryption Made Simple**

---

Are you concerned about the security of your sensitive data? Do you want a no-compromise solution that offers the highest level of encryption without the complexity? Look no further!

**ZeroTrace** is a cutting-edge encryption tool designed to provide **ridiculously strong military-grade encryption** in an easy-to-use package. With ZeroTrace, you get:

- **Triple-Layered Encryption**: Combines AES-256-CBC, Camellia-256-CBC, and ChaCha20 encryption algorithms for unparalleled security.
- **Automatic Password Generation**: Eliminates the need to create and remember complex passwords. ZeroTrace securely generates and manages them for you.
- **Simple Integration**: Dockerized solution ensures quick setup and compatibility across different systems.
- **Open Source**: Transparent and community-driven development on GitHub.
- **No Backdoors**: Your data remains yours—fully encrypted and inaccessible without the keys.

---

**Why Choose ZeroTrace?**

- **Maximum Security**: Uses industry-standard encryption algorithms trusted by governments and security agencies worldwide.
- **Ease of Use**: Straightforward commands for encryption and decryption—no cryptography expertise required.
- **Portability**: Works seamlessly with any file type, ensuring all your data can be securely encrypted.
- **Community Support**: Join a growing community of users and contributors dedicated to data security.

---


## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
  - [Encrypting a File](#encrypting-a-file)
  - [Decrypting a File](#decrypting-a-file)
- [How It Works](#how-it-works)
- [Security Considerations](#security-considerations)
- [License](#license)
- [Disclaimer](#disclaimer)
- [Contributing](#contributing)
- [Contact](#contact)

---

## Features

- **Triple-Layer Encryption**: Utilizes AES-256-CBC, Camellia-256-CBC, and ChaCha20 algorithms.
- **Automatic Password Generation**: Securely generates passwords using OpenSSL's cryptographically secure random number generator.
- **Key File Management**: Stores encryption keys in a secure, encrypted key file.
- **No Intermediate Files**: Uses in-memory streams to prevent leakage of sensitive data.
- **Dockerized Environment**: Ensures consistency and ease of deployment across different systems.
- **Open Source**: Transparent codebase available on GitHub.

---

## Prerequisites

- **Docker**: Ensure Docker is installed on your system. [Download Docker](https://www.docker.com/get-started)

---

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/zerotraceproject/zerotrace.git
   cd zerotrace
   ```

2. **Build the Docker Image**

   ```bash
   docker build -t zerotrace .
   ```

   Alternatively, pull the image from Docker Hub:

   ```bash
   docker pull zerotraceproject/zerotrace
   ```

---

## Usage

### Encrypting a File

1. **Run the Encryption Command**

   ```bash
   docker run --rm -v "$(pwd)":/workspace zerotrace encrypt <input_file>
   ```

   - Replace `<input_file>` with the path to your file.
   - You will be prompted to set a master password to encrypt the key file.

2. **Outputs**

   - `<input_file>.locked`: The encrypted file.
   - `<input_file>.key`: The encrypted key file containing the passwords.

3. **Example**

   ```bash
   docker run --rm -v "$(pwd)":/workspace zerotrace encrypt secrets.txt
   ```

   **Sample Output:**

   ```
   Enter a master password to encrypt the key file:
   Confirm the master password:
   Encryption complete. Key file has been saved as: secrets.txt.key
   File encrypted successfully: secrets.txt.locked
   ```

### Decrypting a File

1. **Run the Decryption Command**

   ```bash
   docker run --rm -v "$(pwd)":/workspace zerotrace decrypt <encrypted_file> <key_file>
   ```

   - Replace `<encrypted_file>` with the path to your `.locked` file.
   - Replace `<key_file>` with the path to your `.key` file.
   - You will be prompted to enter the master password to decrypt the key file.

2. **Example**

   ```bash
   docker run --rm -v "$(pwd)":/workspace zerotrace decrypt secrets.txt.locked secrets.txt.key
   ```

   **Sample Output:**

   ```
   Enter the master password to decrypt the key file:
   Decryption complete. File saved as: secrets.txt.unlocked
   ```

---

## How It Works

1. **Encryption Process**

   - **Password Generation**: Generates three high-entropy passwords using OpenSSL.
   - **Triple Encryption**:
     - **First Layer**: AES-256-CBC
     - **Second Layer**: Camellia-256-CBC
     - **Third Layer**: ChaCha20
   - **Key File Creation**: Stores the passwords in a JSON object, encrypts it with a master password, and saves it as `<input_file>.key`.

2. **Decryption Process**

   - **Key File Decryption**: Uses the master password to decrypt the key file and retrieve the passwords.
   - **Triple Decryption**:
     - **First Layer**: ChaCha20
     - **Second Layer**: Camellia-256-CBC
     - **Third Layer**: AES-256-CBC
   - **Output**: Saves the decrypted file as `<encrypted_file>.unlocked`.

---

## Security Considerations

- **Master Password**: Critical for decrypting the key file. **Do not lose or forget it**, as it cannot be recovered.
- **Key File Security**:
  - Contains the encryption keys. Store it securely.
  - If compromised, an attacker could decrypt your data if they also know the master password.
- **Data Backup**: Keep backups of your encrypted files and key files in secure locations.
- **No Backdoors**: ZeroTrace does not store any passwords or keys. Your data is secure as long as you protect your passwords and key files.

---

## License

ZeroTrace is released under the **MIT License**.

[View the Full License](LICENSE)

---

## Disclaimer

**ZeroTrace is provided "as is", without warranty of any kind, express or implied.**

- **No Liability**: In no event shall the authors be liable for any claim, damages, or other liability arising from the use of ZeroTrace.
- **Proper Use**: Users are responsible for ensuring that they comply with all applicable laws and regulations when using ZeroTrace.
- **No Support Obligations**: The authors are not obligated to provide maintenance, support, updates, enhancements, or modifications.

---

## Contributing

We welcome contributions from the community! Please read our [Contributing Guidelines](CONTRIBUTING.md) to get started.

---

## Contact

For inquiries, please open an issue on GitHub or contact us at [support@zerotraceproject.com](mailto:support@zerotraceproject.com).

---

**ZeroTrace: Protecting Your Data with Uncompromising Security**

# Additional Notes

- **Docker Hub Repository**: The Docker image is available at [docker.io/zerotraceproject/zerotrace](https://hub.docker.com/r/zerotraceproject/zerotrace).
- **GitHub Repository**: Source code and documentation are hosted on GitHub at [github.com/zerotraceproject/zerotrace](https://github.com/zerotraceproject/zerotrace).

---

**Disclaimer Reminder**

ZeroTrace is a tool intended to enhance data security. Users are responsible for understanding and complying with all applicable laws and regulations regarding encryption and data protection in their jurisdiction. The authors and contributors of ZeroTrace assume no liability for misuse or damages arising from the use of this software.

---

We hope ZeroTrace provides you with the security and peace of mind you need to protect your valuable data. If you have any questions or need assistance, feel free to reach out through our GitHub repository.

Happy encrypting!
