## Security Policy

### Supported Versions
We release script archives via tagged semantic versions (vMAJOR.MINOR.PATCH). Only the latest tag receives security fixes. Please upgrade to the newest version before reporting an issue.

### Reporting a Vulnerability
1. Create a private GitHub security advisory ("Report a vulnerability") on the repository.
2. Include:
   - Affected script path(s)
   - Reproduction steps
   - Impact assessment (privilege escalation, info disclosure, etc.)
   - Suggested remediation if known
3. Do NOT open a public issue for unpatched vulnerabilities.

### Disclosure Process
We target initial triage within 5 business days. Valid issues will be assigned a CVSS-like severity label. A fix and release will follow; you will be credited unless you request anonymity.

### Secure Development Practices
- Shell & PowerShell scripts strive to use explicit error handling and avoid unsafe patterns.
- GitHub Actions workflows validate semantic versions, restrict permissions, and use concurrency guards.
- Archives include SHA256 checksums for integrity verification.

### Hardening Roadmap
- Add automated linting for shell and PowerShell.
- Continuous secret scanning of repository history.
- Periodic dependency review for MkDocs build environment.

### Verifying Releases
After downloading a zip archive, verify its checksum:
```bash
sha256sum TRMM-Linux-Scripts.zip
```
Compare the output with the published `SHA256SUMS.txt` in the GitHub Release.

### Contact
For security questions that are not vulnerability reports, open a normal discussion thread tagged `security`.