# iOS Dev Agent

This repo contains a Claude Code skill for building, testing, and deploying iOS apps to the App Store.

## Structure

- `.claude/skills/ios-dev-agent.md` — The main skill definition
- `scripts/` — Helper scripts for App Store Connect, build number bumping, uploads
- `templates/` — ExportOptions.plist and GitHub Actions CI/CD workflow
- `SETUP.md` — Step-by-step setup guide for App Store Connect API keys

## Usage

After setup, invoke the skill in Claude Code by describing what you want:

- "Build my app for the simulator"
- "Run all tests"
- "Deploy the current build to TestFlight"
- "Submit version 2.1 to App Review with these release notes"
- "Create a PR for this feature branch"

## Requirements

- macOS with Xcode installed
- Apple Developer Program membership
- GitHub CLI (`gh`) authenticated
- App Store Connect API key (see SETUP.md)
