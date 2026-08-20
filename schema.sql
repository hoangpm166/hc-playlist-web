PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS app_sessions (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  user_json TEXT NOT NULL,
  credentials_cipher TEXT,
  created_at TEXT NOT NULL,
  expires_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_app_sessions_exp ON app_sessions(expires_at);

CREATE TABLE IF NOT EXISTS oauth_states (
  state TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  code_verifier TEXT NOT NULL,
  created_at TEXT NOT NULL,
  expires_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_oauth_states_exp ON oauth_states(expires_at);

CREATE TABLE IF NOT EXISTS google_connections (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  google_account_id TEXT NOT NULL,
  google_email TEXT,
  display_name TEXT,
  refresh_token_cipher TEXT NOT NULL,
  access_token_cipher TEXT,
  scopes TEXT,
  status TEXT NOT NULL DEFAULT 'CONNECTED',
  last_check_at TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  UNIQUE(user_id, google_account_id)
);
CREATE INDEX IF NOT EXISTS idx_google_connections_user ON google_connections(user_id,status);

CREATE TABLE IF NOT EXISTS youtube_channels (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  google_connection_id TEXT NOT NULL,
  youtube_channel_id TEXT NOT NULL,
  channel_title TEXT NOT NULL,
  channel_handle TEXT,
  thumbnail_url TEXT,
  subscriber_count INTEGER DEFAULT 0,
  video_count INTEGER DEFAULT 0,
  view_count INTEGER DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'CONNECTED',
  last_sync_at TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  UNIQUE(user_id, youtube_channel_id)
);
CREATE INDEX IF NOT EXISTS idx_youtube_channels_user ON youtube_channels(user_id,status);
CREATE INDEX IF NOT EXISTS idx_youtube_channels_connection ON youtube_channels(google_connection_id);
