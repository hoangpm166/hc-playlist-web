# HC Playlist Manager v0.1 — UI Shell

Domain mục tiêu: `playlist.hcmediadn.com`
Worker name: `hc-playlist-web`
App ID trên Admin: `hc-playlist`

## Bản này có
- Dashboard Channel-first.
- Click Channel mở Workspace.
- Tabs: Playlists / Daily Add / My Video / History / Settings.
- Playlist table thể hiện Profile fields quan trọng.
- UI Daily Add theo job từng Playlist.
- My Video với URL + vị trí + multi-playlist.
- Responsive desktop/mobile.

Dữ liệu đang là preview để chốt UX. Chưa nối Google OAuth, YouTube Data API, D1, Queue.

## Deploy thử
1. Tạo repo mới cho Playlist Manager.
2. Upload toàn bộ source này.
3. Cloudflare Workers Builds kết nối repo, Worker `hc-playlist-web`.
4. Gắn custom domain `playlist.hcmediadn.com`.

Sau khi chốt giao diện mới làm Phase 1 backend: HC Account login + Google OAuth + D1 schema.
