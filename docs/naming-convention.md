# Naming Convention

Format:
```
<Category> - <Descriptive Title>.<ext>
```

## Categories & Emojis
| Prefix | Emoji | Purpose |
|--------|-------|---------|
| Check | ✅ | Simple status / point-in-time health check |
| Monitor | 📡 | Ongoing or resource utilization metrics |
| Audit | 🔍 | Configuration / security/inventory diff |
| Collect | 📥 | Data gathering for reporting |
| Security | 🛡 | Hardening / defensive actions |
| Network | 🌐 | Network configuration & connectivity |
| Agent | 🤖 | External agent management (TRMM, Wazuh, etc.) |
| Maintain | 🧹 | Cleanup / maintenance tasks |
| Software Management | 🛠 | Install / update software tooling |
| Cron | ⚙️ | Scheduled task integrity or management |
| Customize | 🎨 | UI / shell / environment customization |
| Image | 🖼️ | Container image or VM image tasks |

## Guidelines
- Use Title Case.
- Avoid abbreviations unless standard (CPU, RAM, DNS).
- Keep titles under ~50 chars.
- Scripts must be idempotent where possible.

