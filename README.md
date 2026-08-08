![purge-my-mac — Spring cleaning for your macOS development environment](./purge-my-mac.png)

# purge-my-mac

A little spring cleaning for your macOS development environment. Reclaim space from Docker, package managers, Xcode, VS Code, and more with clear, animated output and zero dependencies.

## Install

Copy and paste this into Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/raulcanodev/purge-my-mac/main/install.sh | bash
```

Then run:

```bash
purge-my-mac
```

![purge-my-mac in action](./purgue-my-mac.gif)

> Want to look before touching anything? Run `purge-my-mac --dry-run`.

## Usage

```bash
purge-my-mac             # run the full cleanup
purge-my-mac --dry-run   # preview without deleting anything
purge-my-mac --help      # show all options
```

The cleanup removes unused Docker resources and regenerable caches from pnpm, npm/npx, Yarn, Homebrew, pip, Playwright, Cypress, Electron, CocoaPods, TypeScript, Xcode, VS Code, and Cursor.

Chat history, archived sessions, and workspace state are treated differently: they are never removed automatically. When local Codex, Cursor, or VS Code workspace history is found, `purge-my-mac` explains what will be deleted and asks for confirmation. The app is closed cleanly before its data is touched; if it cannot close, that cleanup is skipped.

VS Code's global state database is always preserved because it can contain unrelated extension and interface data alongside chat metadata.

Settings, keybindings, and extensions are always preserved. `--dry-run` never prompts or closes applications.

## Codex data

`purge-my-mac` treats Codex data conservatively:

| Data | Treatment |
| --- | --- |
| `~/.codex/.tmp` and `~/.codex/cache` | Removed automatically when Codex is not running |
| `~/.codex/archived_sessions` | Removed only after explicit confirmation |
| `~/.codex/sessions` | Always preserved |
| `~/.codex/plugins` | Always preserved; it contains installed components and binaries |
| `~/.codex/logs_*.sqlite` | Preserved because these databases may contain more than disposable logs |
| `~/Library/Application Support/Codex` | Preserved |

Configuration, authentication, active sessions, attachments, generated images, skills, and other Codex data are not touched. If `CODEX_HOME` is set, its value is used instead of `~/.codex`.

ChatGPT Atlas data is not managed. In particular, `browser-data` is a browser profile that may contain history, cookies, settings, and site storage—not just cache.

## Update or uninstall

Run the installation command again to update. To uninstall:

```bash
rm ~/.local/bin/purge-my-mac
```

## Compatibility and safety

- Built for macOS and compatible with the system Bash.
- Automatically removes only regenerable caches and unused Docker resources.
- Requires explicit confirmation before removing chat history, archived sessions, or workspace state.
- Keeps going when a tool fails and displays the error instead of hiding it.
- Respects [`NO_COLOR`](https://no-color.org/) and disables animations when output is redirected.

The reported savings compare free disk space before and after the run. Other processes may slightly affect the result.

## Development

```bash
bash -n purge-my-mac install.sh
./purge-my-mac --dry-run --no-color
```

MIT
