![purge-my-mac — Spring cleaning for your macOS development environment](./purge-my-mac.png)

# purge-my-mac

Una pequeña limpieza de primavera para tu entorno de desarrollo en macOS. Recupera espacio de Docker, npm, pnpm, Yarn, Homebrew y pip con una salida clara, animada y sin dependencias.

## Instalar

Copia y pega esto en Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/raulcanodev/purge-my-mac/main/install.sh | bash
```

Después ejecuta:

```bash
purge-my-mac
```

> ¿Prefieres mirar antes de tocar nada? Usa `purge-my-mac --dry-run`.

## Modos

```bash
purge-my-mac             # limpieza habitual
purge-my-mac --dry-run   # muestra qué limpiaría, sin borrar
purge-my-mac --deep      # añade cachés grandes de apps y herramientas
purge-my-mac --help      # todas las opciones
```

El modo normal limpia recursos no utilizados de Docker y las cachés de pnpm, npm/npx, Yarn, Homebrew y pip cuando esas herramientas están instaladas.

`--deep` también elimina stores y cachés regenerables de Playwright, Cypress, Electron, CocoaPods, TypeScript, Xcode y VS Code. En VS Code conserva ajustes, atajos y extensiones, pero elimina cachés y `workspaceStorage`; por eso pide confirmación.

Para automatizar la limpieza deep sin pregunta interactiva:

```bash
purge-my-mac --deep --yes
```

## Actualizar o desinstalar

Para actualizar, vuelve a ejecutar el comando de instalación. Para desinstalar:

```bash
rm ~/.local/bin/purge-my-mac
```

## Compatibilidad y seguridad

- Diseñado para macOS y compatible con el Bash incluido en el sistema.
- Solo actúa sobre cachés regenerables y recursos de Docker sin usar.
- Continúa si una herramienta falla y muestra el error sin ocultarlo.
- Respeta [`NO_COLOR`](https://no-color.org/) y desactiva animaciones al redirigir la salida.

El ahorro mostrado compara el espacio libre del disco antes y después de la ejecución; otros procesos pueden afectar ligeramente al resultado.

## Desarrollo

```bash
bash -n purge-my-mac install.sh
./purge-my-mac --dry-run --no-color
```

MIT
