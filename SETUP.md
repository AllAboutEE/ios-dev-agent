# Setup Guide

## 1. Prerequisites

- **macOS** with full Xcode installed (not just Command Line Tools)
- **Apple Developer Program** membership ($99/year at developer.apple.com)
- **Homebrew** installed

## 2. Install Required Tools

```bash
# Point xcode-select to full Xcode
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Accept Xcode license
sudo xcodebuild -license accept

# Install GitHub CLI
brew install gh

# Authenticate with GitHub
gh auth login
```

## 3. Create an App Store Connect API Key

This is required for automated uploads and App Store submissions.

1. Go to [App Store Connect → Users and Access → Integrations → App Store Connect API](https://appstoreconnect.apple.com/access/integrations/api)
2. Click the **+** button to create a new key
3. Name it (e.g., "ios-dev-agent") and select **Admin** role
4. Click **Generate**
5. **Download the .p8 file** (you can only download it once!)
6. Note the **Key ID** and **Issuer ID** shown on the page

## 4. Configure Environment Variables

Add these to your shell profile (`~/.zshrc` or `~/.bashrc`):

```bash
export APP_STORE_CONNECT_KEY_ID="YOUR_KEY_ID"
export APP_STORE_CONNECT_ISSUER_ID="YOUR_ISSUER_ID"
export APP_STORE_CONNECT_KEY_PATH="$HOME/.appstoreconnect/AuthKey_YOUR_KEY_ID.p8"
```

Store the key file:

```bash
mkdir -p ~/.appstoreconnect
mv ~/Downloads/AuthKey_*.p8 ~/.appstoreconnect/
chmod 600 ~/.appstoreconnect/AuthKey_*.p8
```

## 5. Install the Skill in Claude Code

Link this repo's skill into your Claude Code configuration:

```bash
# Option A: Symlink the skill file
mkdir -p ~/.claude/skills
ln -s /path/to/ios-dev-agent/.claude/skills/ios-dev-agent.md ~/.claude/skills/

# Option B: Add to your project's .claude/skills/ directory
cp /path/to/ios-dev-agent/.claude/skills/ios-dev-agent.md /path/to/your-app/.claude/skills/
```

## 6. Set Up Code Signing

For automated builds, you need signing configured:

```bash
# List available signing identities
security find-identity -v -p codesigning

# If you don't see "Apple Distribution", open Xcode:
# → Settings → Accounts → Manage Certificates → + → Apple Distribution
```

Ensure your app's Xcode project uses **Automatic Signing** with the correct team selected.

## 7. GitHub Actions (Optional CI/CD)

To set up automated CI/CD:

1. Copy the workflow template to your app repo:
   ```bash
   mkdir -p /path/to/your-app/.github/workflows
   cp templates/github-actions-ci.yml /path/to/your-app/.github/workflows/ios-ci.yml
   ```

2. Add repository variables in GitHub (Settings → Variables):
   - `XCODE_SCHEME` — Your app's Xcode scheme name
   - `XCODE_PROJECT` — Your .xcodeproj filename

3. Add repository secrets in GitHub (Settings → Secrets):
   - `APP_STORE_CONNECT_KEY_ID` — The Key ID
   - `APP_STORE_CONNECT_ISSUER_ID` — The Issuer ID
   - `APP_STORE_CONNECT_KEY` — The contents of the .p8 file

## 8. Verify Setup

Run these commands to confirm everything works:

```bash
# Xcode
xcodebuild -version

# GitHub
gh auth status

# Code signing
security find-identity -v -p codesigning

# App Store Connect API (generates a JWT token)
./scripts/asc-token.sh
```

If all commands succeed, the agent is ready to use.
