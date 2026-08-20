# HC Playlist v0.2.1 — Login Status Fix

- Sửa lỗi `/api/auth/login`: headers bị truyền nhầm vào tham số HTTP status.
- Không thay đổi D1, Google OAuth, UI hoặc schema.
- Health version: `0.2.1-login-fix`.

# HC Playlist v0.2 — Phase 1 Auth + Google OAuth + Real Channels

## Đã triển khai
- Bỏ fake login.
- Đăng nhập HC Account qua `admin.hcmediadn.com/api/platform/login` với `appId=hc-playlist`.
- Session riêng của Playlist, HttpOnly cookie.
- AI credentials do Admin cấp chỉ đi server-to-server; lưu mã hóa trong D1 session, không trả xuống frontend.
- Google OAuth 2.0 + PKCE.
- Refresh token Google được AES-GCM mã hóa trước khi lưu D1.
- Lấy Google Account thật.
- Lấy YouTube Channel thật bằng YouTube Data API v3.
- Trang Kênh YouTube bỏ dữ liệu mẫu và render Channel thật.
- Có nhiều Google Connections cho cùng một HC Account.
- Có nút Đồng bộ Channel.

## Cloudflare bindings/secrets cần cấu hình
### D1
Tạo D1 database, ví dụ `hc-playlist-db`, chạy `schema.sql`, sau đó bind vào Worker với Variable name:
`DB`

### Secrets
Trong Worker `hc-playlist-web` thêm:
- `HC_PLATFORM_SHARED_SECRET` — PHẢI giống secret cùng tên đang dùng ở Admin.
- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`
- `APP_DATA_KEY` — base64 của đúng 32 bytes ngẫu nhiên.

Optional:
- `GOOGLE_OAUTH_REDIRECT_URI=https://playlist.hcmediadn.com/api/oauth/google/callback`

## Google Cloud Console
Bật `YouTube Data API v3`.
OAuth Client type: Web application.
Authorized redirect URI chính xác:
`https://playlist.hcmediadn.com/api/oauth/google/callback`

## Scope
Phase 1 dùng `https://www.googleapis.com/auth/youtube` để không phải xin lại scope khi sang phase tạo/sửa Playlist.

## Thứ tự test
1. `/api/health` phải báo `db:true`, `google:true`.
2. Mở `playlist.hcmediadn.com` → phải hiện màn hình đăng nhập thật.
3. Đăng nhập HC Account đã được Admin cấp `hc-playlist`.
4. Bấm `Kết nối Google / YouTube`.
5. Google consent → callback về Playlist.
6. Channel thật xuất hiện trên trang chính.
7. Bấm `Đồng bộ Channel` để test refresh token.

## Không thay đổi Admin trong v0.2
Admin v1.0.7 đã có `hc-playlist` và endpoint generic `/api/platform/login`, đủ cho Phase 1.
