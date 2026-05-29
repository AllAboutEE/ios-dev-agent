# iOS Dev Agent

A standalone Claude Code agent for building, testing, and deploying iOS apps to the App Store. Works with any iOS app repo — just point it at your project.

## Structure

- `.claude/skills/ios-dev-agent.md` — The main skill definition
- `scripts/` — Helper scripts for App Store Connect, build number bumping, uploads
- `templates/` — ExportOptions.plist and GitHub Actions CI/CD workflow
- `SETUP.md` — Step-by-step setup guide for App Store Connect API keys

## Usage

Open Claude Code inside this repo, then tell it which app to work on:

- "Clone AllAboutEEOrg/PetHealthTrackerApp and build it"
- "Open ~/MyApp and run all tests"
- "Deploy the current build to TestFlight"
- "Submit version 2.1 to App Review with these release notes"
- "Create a PR for this feature branch"

The agent auto-discovers the Xcode project, scheme, and targets in whatever repo you point it at.

## Using with multiple apps

You run Claude Code from this repo. The agent clones or navigates to your app repo, discovers the Xcode project structure, and operates on it. Your app repos stay clean — no agent files needed in them.

```bash
cd ~/ios-dev-agent
claude
# Then: "Clone my-org/my-app and build it for the simulator"
```

## Requirements

- macOS with Xcode installed
- Apple Developer Program membership
- GitHub CLI (`gh`) authenticated
- App Store Connect API key (see SETUP.md)
