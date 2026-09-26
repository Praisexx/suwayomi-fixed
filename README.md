# suwayomi-fixed

Thin wrapper around the official `ghcr.io/suwayomi/tachidesk` image that fixes
a permission-denied crash when a fresh (empty) volume is mounted at
`/home/suwayomi/.local/share/Tachidesk`.

The base image runs as a non-root `suwayomi` user and relies on that path
already being world-writable at build time — mounting a real persistent
volume there (e.g. on Railway) shadows that with a directory owned by root,
which the non-root user can't write to.

This wrapper starts as root, `chown`s the mount to `suwayomi:suwayomi`, then
drops privileges via `setpriv` and execs the original startup script — so
extensions/library data actually persist across restarts and redeploys.

Used as the backend for the `inertia` manga reader app
(github.com/Praisexx/inertia).
