# AnimeVault — User Guide

Everything you need to know to discover, stream, download, and organize anime with AnimeVault on Linux.

## Table of contents

- [Installation](#installation)
- [First launch — connecting to AnimePahe](#first-launch--connecting-to-animepahe)
- [The interface](#the-interface)
- [Searching and discovering anime](#searching-and-discovering-anime)
- [Watching](#watching)
- [Keyboard shortcuts](#keyboard-shortcuts)
- [Downloads](#downloads)
- [Your library](#your-library)
- [History, statistics, and the airing calendar](#history-statistics-and-the-airing-calendar)
- [Notifications](#notifications)
- [Settings](#settings)
- [Staying up to date](#staying-up-to-date)
- [Troubleshooting](#troubleshooting)

---

## Installation

AnimeVault ships in three formats. Pick one:

### One-line install (recommended — tarball, no sudo)

```bash
curl -fSL https://animevault.vincentiwuno.me/install.sh | bash
```

Installs to `~/.local/animevault.app` and adds an `anime` command plus a desktop menu entry. Re-run the same command any time to update.

### .deb (Debian / Ubuntu / Kali)

```bash
sudo apt install ./anime_0.5.0_amd64.deb
```

### AppImage

```bash
chmod +x AnimeVault-0.5.0.AppImage
./AnimeVault-0.5.0.AppImage
```

### Prerequisite for downloads: yt-dlp

Downloading episodes uses [yt-dlp](https://github.com/yt-dlp/yt-dlp). Streaming works without it, but the download queue will fail until it's installed:

```bash
pip install yt-dlp --break-system-packages
```

---

## First launch — connecting to AnimePahe

AnimeVault streams through AnimePahe, which sits behind a Cloudflare check. The first time you search or browse, the app needs an AnimePahe session:

1. Home or Discover shows a **"Connect to AnimePahe"** screen — click it (or do the same from **Settings → AnimePahe**).
2. A browser window opens and waits for the Cloudflare challenge. Complete it if one appears — usually it passes automatically.
3. The window closes itself and the app reloads. You're connected.

The session is kept for a while, but it does expire occasionally (see [Troubleshooting](#troubleshooting)).

> Only `animepahe.pw`, `animepahe.com`, and `animepahe.org` are official AnimePahe domains. Ignore look-alikes.

Metadata (titles, artwork, episode info, airing schedules) comes from AniList and needs no account or login.

---

## The interface

The sidebar gives you ten sections:

| Section | What it is |
|---|---|
| **Home** | Hero carousel, Continue Watching, Trending, Latest Releases, Seasonal rows |
| **Discover** | Full browse with filters (see below) |
| **My List** | Anime you've tagged Watching / Completed / Plan to Watch / On Hold / Dropped |
| **History** | Every episode you've watched, grouped by time |
| **Airing** | Calendar of upcoming episodes for shows you track |
| **Downloads** | Download queue and completed files (badge shows active count) |
| **Local** | Anime files from your own disk, imported and playable in-app |
| **Collections** | Your custom playlists/groupings, plus Favorites |
| **Statistics** | Watch time, episodes, top anime and genres |
| **Settings** | All preferences (see [Settings](#settings)) |

The top bar has a **Back** button, the **"Search anime…"** button (`Ctrl+K`), the **notification bell**, a **network status** indicator, and the window controls. The sidebar can be collapsed to icons.

---

## Searching and discovering anime

**Quick search** — press `Ctrl+K` (or click the search bar) anywhere. Results appear as you type, and recent searches are listed until you clear them.

**Discover page** — two feeds, switchable at the top:

- **Discover (Latest)** — the newest releases on AnimePahe
- **This Season** — seasonal anime from AniList

Click **Filters** to narrow by genre (28 options), season, year, type (TV / Movie / OVA / ONA / Special), status (Airing / Completed / Upcoming / Hiatus), or free-form custom tags. Active filters are summarized with a **Clear all** shortcut, and results load infinitely as you scroll.

**Details page** — click any anime card to see its banner, synopsis, status, rating, episode count, and three tabs: **Episodes**, **Related**, and **Recommendations**. Everything you do with a show — play, download, favorite, add to list — starts here.

---

## Watching

The player is built for anime binging:

- **Quality** — gear menu → **Quality** lists every available source (360p / 720p / 1080p, varies by title and release).
- **Sub or dub** — gear menu → **Audio Track** (Subtitled / Dubbed), with a **Subtitles On/Off** row alongside.
- **Playback speed** — gear menu, from 0.25× to 2×.
- **Skip Intro / Skip Ending** — when timings are known (AniSkip, with IntroDB fallback), a button appears in the bottom-right corner while you're inside the intro/ending. Click it to jump to the end of the segment.
- **Auto-advance** — when an episode ends, an **"Up Next"** prompt counts down 5 seconds and plays the next episode (if you disabled **Auto-play next episode** in Settings, it waits for you). Auto-advance skips episodes you've already finished, prefers a **downloaded copy** if you have one, and resumes a saved position if you started that episode before.
- **Picture-in-Picture** — the PiP button in the gear menu pops the video into a floating window.
- **Resume** — progress saves as you watch (and when you close the player). Reopening an episode seeks back to where you left off; if you watched past ~95%, it starts fresh.
- **Auto-hiding controls** — the overlay fades after 3 seconds of playback and reappears on mouse movement.

### Keyboard shortcuts

Inside the player:

| Key | Action |
|---|---|
| `Space` / `K` | Play / pause |
| `→` / `←` | Seek +10s / −10s |
| `↑` / `↓` | Volume +10% / −10% |
| `F` | Fullscreen |
| `M` | Mute |
| `Esc` | Exit fullscreen, or close the player (saves progress) |
| Click video | Play / pause |
| Double-click video | Toggle fullscreen |
| Click progress bar | Seek to that point |

Anywhere in the app:

| Key | Action |
|---|---|
| `Ctrl+K` | Open search |
| `Ctrl+Alt+←/→/↑/↓` | Snap the window to a screen half |
| `Ctrl+Alt+M` | Maximize / restore |

---

## Downloads

### Starting a download

On an anime's details page:

- **One episode** — the download icon on any episode row opens a **Resolution selector** showing the real available qualities with sizes, then **Download**.
- **A whole season** — **Download Season** lets you tick multiple episodes and a quality at once.
- **Mark mode** — select episodes by checkbox and download the batch.

Downloads run through yt-dlp with real-time progress, speed, and remaining-time estimates.

### Managing the queue

The **Downloads** page groups work into active downloads, needs-attention (failed), and completed. Each entry supports:

- **Pause / Resume** — a partial download continues where it stopped.
- **Cancel** — stops and removes a queued or running download.
- **Retry** — failed downloads show the reason (e.g. "Session expired", "No network connection") and re-queue with one click.
- **Remove** — deletes the queue entry (confirm by clicking twice).

The page header shows combined download speed and total disk usage.

### Settings that affect downloads

**Settings → Downloads**: download location (default `~/Videos/Anime`), default quality, max concurrent downloads (1–5), and a **Wi-Fi Only** mode that pauses the queue on metered connections.

### Playing downloaded episodes

Completed downloads are clickable — they play instantly from disk (no network needed) through the built-in local file server, with resume and an auto-next queue built from your downloaded episodes. When you stream a show you've also downloaded, the app automatically prefers the local copy.

---

## Your library

- **My List** — on any details page, use the list button to set a status: **Watching, Completed, Plan to Watch, On Hold, Dropped**. The My List page filters by these.
- **Favorites** — the heart button on any details page. Browse everything you've hearted under **Collections → Favorites**.
- **Collections** — create named groupings ("Noir", "Studio Ghibli", "Watch with Mom") with optional descriptions, add anime from their details pages, and remove them again. Delete a collection any time; it never deletes the anime themselves.
- **Local library** — the **Local** page indexes video files you point the app at so they get the same player, history, and resume treatment as streamed anime.

Tracking a show in My List also subscribes it to **new-episode notifications** and puts it on the **Airing** calendar.

---

## History, statistics, and the airing calendar

- **History** records every episode you watch, grouped Today / Yesterday / This Week / Earlier. Click any row to resume it. A **Clear History** button wipes the record.
- **Statistics** summarizes total watch time, episodes watched, anime watched and completed, a 30-day activity chart, your most-watched shows, and top genres.
- **Airing** shows the upcoming episode schedule for everything you track, so you know what's dropping this week.

Home's **Continue Watching** row surfaces your latest partially-watched episodes (up to 10) for one-click resume.

---

## Notifications

The **bell** in the top bar collects:

- **Download complete** / **Download failed**
- **New episode** alerts for shows you track
- General info messages

Click a notification to jump straight to the download, episode, or show — that marks it read. The feed is organized into Today / Earlier, **Mark all read** clears the badge, and **Clear** empties the list. Notifications persist across restarts (the last 200 are kept).

Pop-up toasts (and OS desktop notifications, when available) follow the **Settings → General → Notifications** master toggle — but the bell feed always records, even with toasts off.

New-episode alerts are checked on an interval you control (**every hour → once a day**, default 6h). Settings shows when the last check ran, whether it failed, and offers a **Check now** button.

---

## Settings

Six tabs:

| Tab | Options |
|---|---|
| **Appearance** | Theme (Dark / OLED / Light), accent color (7 choices) |
| **Playback** | Auto-play next episode, default volume, default speed, subtitles on by default |
| **Downloads** | Location, default quality, max concurrent, Wi-Fi only |
| **General** | Notifications toggle, new-episode alerts + check interval + **Check now**, minimize-to-tray on close |
| **About** | Version, links, the **Updates** card, project disclaimer |
| **AnimePahe** | Connect / disconnect the streaming session |

Changed anything? A **Save Changes** button appears until you save. **Minimize to tray** (on by default) keeps downloads and notifications running when you close the window — right-click the tray icon to get the app back.

---

## Staying up to date

How you update depends on how you installed:

- **Tarball (`install.sh`)** — fully in-app. **Settings → About** detects a new release; **Install Update** downloads and applies it (SHA-256 verified), then a **Restart** button relaunches the updated app.
- **AppImage** — updates download in the background and install when you quit. An **"Automatic updates"** toggle (on by default) appears in Settings → About for AppImage installs if you'd rather opt out. An "Update ready: Restart & Update" banner appears when a download completes.
- **.deb** — the app tells you when a new version exists (**Settings → About → Download v…**, which opens the release page); install the new `.deb` with `sudo apt install` yourself.

Occasionally the app shows an **"Update required"** banner — that means the current version has been retired server-side and you'll need to update to continue. Announcements from the developer (maintenance notices, etc.) appear as a pop-up once and don't come back after you dismiss them.

---

## Troubleshooting

**"No playback sources available. Connect to AnimePahe in Settings to watch."**
Your AnimePahe session is missing or expired. Settings → AnimePahe → **Connect**, solve the Cloudflare check, done. The same applies if Home/Discover show a connect screen.

**Searches or episode lists load slowly.**
AnimePahe requests are deliberately throttled (~2s between calls) to avoid getting the session banned. A short wait is normal; if it's stuck, see the session note above.

**A download fails with "Session expired" or 403.**
Reconnect AnimePahe (above), then hit **Retry** on the failed download.

**A download fails with "No network connection" / libcurl errors.**
Check your connection and the network indicator in the top bar, then Retry. Partial progress is kept — resumes don't start over.

**Nothing is downloading even though items are queued.**
Check Settings → Downloads: **Wi-Fi Only** pauses the queue on metered connections, and concurrent slots may be occupied. Also confirm yt-dlp is installed.

**Downloads or notifications stopped while the app was "closed."**
If minimize-to-tray is on, closing the window keeps the app running in the tray — but quitting the app stops everything. Look for the tray icon.

**The airing check reports "failed" in Settings.**
Usually a temporary AniList outage — try **Check now** later. It retries on its own and the last error is shown for diagnosis.

**The app window won't open but `anime` "does nothing."**
Only one instance can run — a second launch focuses the existing window (or tray). Check the tray icon, or run `anime --version` to confirm the install is healthy.

---

*Still stuck? [Open an issue](https://github.com/Vlex127/Animevault-releases/issues) or grab a coffee-fueled answer from the maintainer — [Buy Me a Coffee](https://coffee.vincentiwuno.me).*
