# dev-clean

Una pequeña limpieza de primavera para tu entorno de desarrollo en macOS. Recupera espacio de Docker, npm, pnpm, Yarn, Homebrew y pip con una salida clara, animada y sin dependencias.

## Instalar

Copia y pega esto en Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/raulcanodev/purge-my-mac/main/install.sh | bash
```

Después ejecuta:

```bash
dev-clean
```

> ¿Prefieres mirar antes de tocar nada? Usa `dev-clean --dry-run`.

## Modos

```bash
dev-clean             # limpieza habitual
dev-clean --dry-run   # muestra qué limpiaría, sin borrar
dev-clean --deep      # añade cachés grandes de apps y herramientas
dev-clean --help      # todas las opciones
```

El modo normal limpia recursos no utilizados de Docker y las cachés de pnpm, npm/npx, Yarn, Homebrew y pip cuando esas herramientas están instaladas.

`--deep` también elimina stores y cachés regenerables de Playwright, Cypress, Electron, CocoaPods, TypeScript, Xcode y VS Code. En VS Code conserva ajustes, atajos y extensiones, pero elimina cachés y `workspaceStorage`; por eso pide confirmación.

Para automatizar la limpieza deep sin pregunta interactiva:

```bash
dev-clean --deep --yes
```

## Actualizar o desinstalar

Para actualizar, vuelve a ejecutar el comando de instalación. Para desinstalar:

```bash
rm ~/.local/bin/dev-clean
```

## Compatibilidad y seguridad

- Diseñado para macOS y compatible con el Bash incluido en el sistema.
- Solo actúa sobre cachés regenerables y recursos de Docker sin usar.
- Continúa si una herramienta falla y muestra el error sin ocultarlo.
- Respeta [`NO_COLOR`](https://no-color.org/) y desactiva animaciones al redirigir la salida.

El ahorro mostrado compara el espacio libre del disco antes y después de la ejecución; otros procesos pueden afectar ligeramente al resultado.

## Desarrollo

```bash
bash -n dev-clean install.sh
./dev-clean --dry-run --no-color
```

MIT
