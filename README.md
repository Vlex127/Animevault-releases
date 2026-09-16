# AnimeVault

A cinematic native desktop app for discovering, streaming, and downloading anime — built on Electron, powered by AnimePahe.

## Stack

- **Electron + electron-vite** — main/preload/renderer build pipeline
- **React 19 + TypeScript** — renderer UI
- **Tailwind CSS + Radix UI** — styling and headless components
- **Zustand** — renderer state management
- **Drizzle ORM + better-sqlite3** — local SQLite persistence
- **yt-dlp** — download engine
- **hls.js** — HLS video streaming

## Features

- **Cinematic Player** — HLS streaming with quality selection, subtitle/dub switching, auto-skip intro/outro via AniSkip, PiP, keyboard shortcuts
- **Native Downloads** — Download episodes via yt-dlp with real-time progress, pause/resume, configurable download location
- **AniList Discovery** — Trending, seasonal, and genre-filtered anime with rich metadata
- **Watch History** — Per-episode progress, resume from where you left off
- **My List & Collections** — Organize anime into Watching, Completed, Favorites, and custom collections
- **Remote Config** — Kill switch and announcements via GitHub-hosted JSON
- **Buy Me a Coffee** — Support the project

## Getting started

```bash
pnpm install
pnpm dev
```

## Building

```bash
pnpm build                    # production build
pnpm dist --linux deb         # .deb package
pnpm dist --linux AppImage    # .AppImage
pnpm dist --linux deb AppImage --publish never  # both
```

## Releases

Releases are built via GitHub Actions on tag push:

```bash
git tag v0.2.0
git push origin v0.2.0
```

Builds publish to the [releases repo](https://github.com/Vlex127/Animevault-releases).

## Structure

```
src/
  main/               # Electron main process
    db/               # Drizzle schema + migrations
    ipc/              # IPC handlers (anime, library, downloads, settings, etc.)
    providers/        # AnimePahe + AniList API clients
    services/         # Business logic (anime, aniskip, download-manager, remote-config)
    index.ts          # App entry, window creation, file server
  preload/            # contextBridge API
  renderer/           # React UI
    src/
      components/     # Reusable components (block-screen, announcement-modal, etc.)
      features/       # Feature modules (search overlay)
      pages/          # Page components (home, discover, player, settings, etc.)
      stores/         # Zustand stores
  shared/             # Types, schemas, constants (IPC channels)
```

## Landing page

`index.html` in the project root — deployed on Vercel at [animevault.vincentiwuno.me](https://animevault.vincentiwuno.me).

## License

MIT
