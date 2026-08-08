#!/usr/bin/env bash

set -eu

REPOSITORY="${PURGE_MY_MAC_REPOSITORY:-raulcanodev/purge-my-mac}"
BRANCH="${PURGE_MY_MAC_BRANCH:-main}"
INSTALL_DIR="${PURGE_MY_MAC_INSTALL_DIR:-$HOME/.local/bin}"
SOURCE_URL="https://raw.githubusercontent.com/${REPOSITORY}/${BRANCH}/purge-my-mac"
TARGET="$INSTALL_DIR/purge-my-mac"
TEMP_FILE=$(mktemp "${TMPDIR:-/tmp}/purge-my-mac-install.XXXXXX")

cleanup() {
  rm -f "$TEMP_FILE"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

if [[ "$(uname -s)" != "Darwin" ]]; then
  printf 'purge-my-mac is built for macOS.\n' >&2
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  printf 'curl is required to install purge-my-mac.\n' >&2
  exit 1
fi

# Download first so a failed request never replaces a working install.
printf '\n  Installing purge-my-mac…\n'
curl -fsSL "$SOURCE_URL" -o "$TEMP_FILE"
mkdir -p "$INSTALL_DIR"
install -m 0755 "$TEMP_FILE" "$TARGET"

printf '  ✓ Installed at %s\n' "$TARGET"

# Tell the user when their shell cannot find the new command yet.
case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *)
    printf '\n  Add this line to ~/.zshrc, then open a new terminal:\n\n'
    printf '    export PATH="%s:$PATH"\n' "$INSTALL_DIR"
    ;;
esac

printf '\n  Run: purge-my-mac --dry-run\n\n'
