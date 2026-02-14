# Security in Mobile Apps

## Common Mobile App Security Threats

- **Social Engineering**: Manipulation tactics exploiting human error for unauthorized access
- **Malware**: Trojans, spyware, adware, ransomware, banking malware, keyloggers, rootkits, worms, backdoors
- **Phishing**: Fraudulent attempts to trick users into revealing sensitive information
- **Man in the Middle (MitM)**: Intercepting communication between mobile apps and servers
- **Data Breaches**: Unauthorized access exposing sensitive user data
- **Authentication Attacks**: Credential stuffing, brute force, session hijacking, OAuth token attacks
- **Code Tampering**: Unauthorized modification of app code
- **Reverse Engineering**: Extraction of source code or sensitive information
- **Insufficient API Security**: Inadequate API protection
- **Insecure Data Storage**: Weak encryption or improper storage
- **Supply Chain Attacks**: Compromising security through third-party vulnerabilities

## OWASP Mobile Top 10 (2024)

### 1. Improper Credential Usage

Never include sensitive API keys in the frontend of your app. Compiled code is subject to reverse engineering.

**Tips:**
- Use Android Keystore or iOS Keychain for sensitive user information
- Use strong encryption and hashing during credential storage and transmission
- Avoid weak authentication mechanisms
- Create a backend microservice to store API keys securely

**Packages:** [dart-crypt](https://github.com/hoylen/dart-crypt), [Firebase Authentication](https://firebase.google.com/docs/auth)

### 2. Inadequate Supply Chain Security

**Tips:**
- Leverage human-led code review with automated checks
- Ensure secure app signing and distribution (use [Codemagic](https://codemagic.io/))
- Use trusted, validated third-party libraries
- Require human + automated vulnerability checker for package updates
- Follow the [SLSA security framework](https://slsa.dev/)

### 3. Insecure Authentication/Authorization

**Tips:**
- Use server-side authentication
- Encrypt local data
- Use device-specific tokens instead of storing passwords
- Make persistent authentication opt-in
- Use biometrics (FaceID, TouchID) via [local_auth](https://pub.dev/packages/local_auth)
- Enforce all controls server-side

### 4. Insufficient Input/Output Validation

**Tips:**
- Use strict input validation, set length limits
- Sanitize output to prevent XSS
- Use parameterized queries to block SQL injection
- Use [Formz](https://pub.dev/packages/formz) for form validation

### 5. Insecure Communication

**Tips:**
- Use SSL/TLS for all data transmissions
- Only accept certificates from trusted CAs
- Use AES-128+ encryption algorithms
- Pin certificates and require SSL chain verification
- Never transmit sensitive data via SMS or push notifications
- Use [Firebase App Check](https://firebase.google.com/docs/app-check)

### 6. Inadequate Privacy Controls

**Tips:**
- Minimize collection and processing of PII
- Allow users to consent to optional PII usage
- Store/transfer PII only when absolutely necessary
- Use threat modeling to identify privacy risks

### 7. Insufficient Binary Protection

**Tips:**
- Access only minimal information needed to function
- Use obfuscation tools ([Obfuscating Dart Code](https://flutter.dev/docs/deployment/obfuscate))
- Implement integrity checks to detect code tampering
- Use [FreeRASP](https://pub.dev/packages/freerasp) or [Approov](https://approov.io/)
- Implement a backend middleware for sensitive APIs

### 8. Security Misconfiguration

**Tips:**
- Ensure defaults don't expose sensitive data
- No hardcoded credentials
- Request only necessary permissions (principle of least privilege)
- Turn off debugging in production
- Prevent app data from being included in device backups

### 9. Insecure Data Storage

**Tips:**
- Use AES-256 encryption for data at rest
- Use HTTPS/SSL/TLS for data in transit
- Store sensitive data in Keychain (iOS) or Keystore (Android)
- Use [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- Configure [Firestore Security Rules](https://firebase.google.com/docs/firestore/security/get-started) if using Firestore

### 10. Insufficient Cryptography

**Tips:**
- Use AES-256, RSA, or ECC with industry-standard key lengths
- Follow secure key management practices
- Use established, peer-reviewed crypto libraries
- Store encryption keys via OS-provided mechanisms
- Use SHA-256 or bcrypt for hashing, apply salting
- Use PBKDF2 or scrypt for password-based cryptography

**Packages:** [crypto](https://pub.dev/packages/crypto)

## OWASP Resources

- [OWASP MAS Checklist](https://mas.owasp.org/checklists/)
- [OWASP MASTG](https://mas.owasp.org/MASTG/)
- [OWASP MASVS](https://mas.owasp.org/MASVS/)
- [OWASP MASWE](https://mas.owasp.org/MASWE/)
