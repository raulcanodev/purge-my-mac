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

## What it cleans

Regenerable caches and unused resources are removed automatically. History and workspace state always require explicit confirmation.

| Tool | Cleaned automatically | With confirmation | Preserved |
| --- | --- | --- | --- |
| Docker | Build cache and unused images | — | Containers, volumes, and images attached to containers |
| pnpm | Store and Library caches | — | Configuration and project files |
| npm / npx | npm cache, npx temporary files, and logs | — | Global packages, configuration, and project files |
| Yarn | Yarn and Library caches | — | Global installs, configuration, and project files |
| Homebrew | Old versions and cached downloads | — | Current formulae and casks |
| pip | Download and wheel caches | — | Environments and installed packages |
| TypeScript | Library cache | — | Projects and configuration |
| Cypress | Downloaded binary cache | — | Projects and configuration |
| Playwright | Downloaded browser caches | — | Projects and configuration |
| Electron | Download cache | — | Installed applications and projects |
| CocoaPods | Library cache | — | Pods installed inside projects |
| Xcode | `DerivedData` | — | Projects, archives, simulators, and settings |
| VS Code | Cache, GPU cache, logs, crash data, and Service Worker cache | Chat and workspace state in `workspaceStorage` | Settings, keybindings, extensions, and the shared global state database |
| Cursor | Cache, GPU cache, logs, crash data, and Service Worker cache | Chat databases, workspace state, and agent transcripts | Settings, keybindings, and extensions |
| Codex | `~/.codex/.tmp` and `~/.codex/cache` | All local chat/session history in `~/.codex/sessions` and `~/.codex/archived_sessions` | Plugins, logs, configuration, authentication, attachments, generated images, skills, and Application Support |

Xcode, VS Code, Cursor, and Codex are stopped with `pkill` before their files are cleaned. The script sends `TERM` first and falls back to `KILL` only when a process does not stop. If it still cannot stop, that cleanup is skipped.

Run `purge-my-mac` from Terminal, not from inside Codex or another app it may stop.

Failures do not hide successful work: the failing step and its last output are shown immediately, along with the space reclaimed so far. A final warning summary lists every failed step and the total space still recovered. `--dry-run` never prompts, stops applications, or removes files.

If `CODEX_HOME` is set, it is used instead of `~/.codex`. ChatGPT Atlas browser data is not managed because it may contain history, cookies, settings, and site storage—not just cache.

## Update or uninstall

Run the installation command again to update. To uninstall:

```bash
rm ~/.local/bin/purge-my-mac
```

## Compatibility and safety

- Built for macOS and compatible with the system Bash.
- Automatically removes only regenerable caches and unused Docker resources.
- Requires explicit confirmation before removing chat history, Codex sessions, or workspace state.
- Keeps going when a tool fails and displays the error instead of hiding it.
- Respects [`NO_COLOR`](https://no-color.org/) and disables animations when output is redirected.

The reported savings compare free disk space before and after the run. Other processes may slightly affect the result.

## Development

```bash
bash -n purge-my-mac install.sh
./purge-my-mac --dry-run --no-color
```

MIT
