#!/usr/bin/env bash

set -eu

REPOSITORY="${DEV_CLEAN_REPOSITORY:-raulcanodev/purge-my-mac}"
BRANCH="${DEV_CLEAN_BRANCH:-main}"
INSTALL_DIR="${DEV_CLEAN_INSTALL_DIR:-$HOME/.local/bin}"
SOURCE_URL="https://raw.githubusercontent.com/${REPOSITORY}/${BRANCH}/dev-clean"
TARGET="$INSTALL_DIR/dev-clean"
TEMP_FILE=$(mktemp "${TMPDIR:-/tmp}/dev-clean-install.XXXXXX")

cleanup() {
  rm -f "$TEMP_FILE"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

if [[ "$(uname -s)" != "Darwin" ]]; then
  printf 'dev-clean está diseñado para macOS.\n' >&2
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  printf 'Se necesita curl para instalar dev-clean.\n' >&2
  exit 1
fi

printf '\n  Instalando dev-clean…\n'
curl -fsSL "$SOURCE_URL" -o "$TEMP_FILE"
mkdir -p "$INSTALL_DIR"
install -m 0755 "$TEMP_FILE" "$TARGET"

printf '  ✓ Instalado en %s\n' "$TARGET"

case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *)
    printf '\n  Añade esta línea a tu ~/.zshrc y abre una terminal nueva:\n\n'
    printf '    export PATH="%s:$PATH"\n' "$INSTALL_DIR"
    ;;
esac

printf '\n  Ejecuta: dev-clean --dry-run\n\n'
