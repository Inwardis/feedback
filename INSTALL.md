# Installing Inwardis

Inwardis ships as Docker images and runs entirely on your infrastructure. A production install
is **three containers**: the product (backend + web app in one), the render sidecar
(server-side diagram rendering), and PostgreSQL. Real-time collaboration adds an optional
fourth (`hocuspocus`), off by default.

> This page mirrors the in-app manual's Installation page — once the product is running, the
> **? Help** panel inside the app is the authoritative, version-matched documentation.

## Quickstart

1. **Get a license key** — [a free 30-day trial](https://inwardis.com/trial.html) or a
   purchase. The email carries the key **and your personal download link** for the product
   bundle.
2. **Download** the bundle from your personal link — the filename carries the version, e.g.
   `inwardis-bundle-1.0.0.tar.gz` — and `docker-compose.prod.yml` from the download page, into one directory.
3. **Create a `.env` file** next to them with the three required secrets (below) **and the
   version you downloaded** — the compose file pins images by `INWARDIS_VERSION`, and it must
   match the bundle or `docker compose up` fails with *image not found*:

   ```
   INWARDIS_VERSION=1.0.0-rc.53   # ← the version from your download page / bundle filename
   ```
4. **Set up email** (below) — optional, recommended for a team install: invitations,
   notifications and (if you turn it on) login codes go out by email. Login itself works
   without it.
5. `docker load -i inwardis-bundle-<version>.tar.gz`, then
   `docker compose -f docker-compose.prod.yml up -d`
6. Verify the version took: `http://<host>:8080/actuator/info` must show the version you
   pinned (a machine with older cached images can otherwise silently run the wrong one) and,
   under `license`, the trust anchor the build carries — your key validates only in the build
   your download page gave you.
7. Open `http://<host>:8080` and register — **the first account registered on a fresh install
   automatically has administrator rights** (there is no default username/password; you create
   the admin by being first). The MFA code arrives by email. Then install your license key
   under **Admin → License**.

Upgrading is a deliberate act: the compose file pins an image version on purpose. Download the
newer bundle from your personal link (new releases appear there while your subscription is
active; everything you were entitled to stays re-downloadable), `docker load` it, change the
tag, `docker compose up -d`.

## The three required secrets

| Variable | What it is | Generate with |
|----------|-----------|---------------|
| `POSTGRES_PASSWORD` | Database password | `openssl rand -hex 16` |
| `JWT_SECRET` | Signs login sessions. **At least 32 bytes.** Changing it logs everyone out. | `openssl rand -hex 32` |
| `INWARDIS_ENCRYPTION_KEY` | Encrypts stored git-remote credentials. **Exactly 32 bytes.** Losing it loses those credentials. | `openssl rand -base64 24` |

The compose file refuses to start without them — there are no insecure defaults in production.

### On Windows

Docker Desktop uses WSL2 as its engine, but it does **not** give you a Linux shell — the
distributions it installs are internal. **PowerShell needs nothing extra**, so start there.

Two things differ in PowerShell. Download the compose file with `curl.exe`, not
`curl`, which PowerShell aliases to `Invoke-WebRequest`. And `openssl` is not on Windows, so
generate the three secrets from .NET's cryptographic source:

```powershell
$rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$b = New-Object 'System.Byte[]' 16; $rng.GetBytes($b)
$pg  = ($b | ForEach-Object { $_.ToString('x2') }) -join ''
$b = New-Object 'System.Byte[]' 32; $rng.GetBytes($b)
$jwt = ($b | ForEach-Object { $_.ToString('x2') }) -join ''
$b = New-Object 'System.Byte[]' 24; $rng.GetBytes($b)
$key = [Convert]::ToBase64String($b)

@"
POSTGRES_PASSWORD=$pg
JWT_SECRET=$jwt
INWARDIS_ENCRYPTION_KEY=$key
INWARDIS_VERSION=<version>
"@ | Set-Content -Encoding ascii .env
```

**`-Encoding ascii` is required, not cosmetic.** PowerShell writes UTF-16 by default, Docker Compose
reads that as binary, and the first variable silently goes missing — which presents as Compose
refusing to start with no clue why. Never substitute `Get-Random` for the generator above: it is not
a cryptographic source, and these three secrets protect the database, every session and your stored
git credentials.

**Already using WSL?** If you have a Linux distribution installed — you would have added it
yourself, or with `wsl --install` — every command on this page works inside it unchanged. Enable
that distribution first under *Docker Desktop → Settings → Resources → WSL integration*, or
`docker` will not be on its path.

## Email setup — optional, recommended

The product sends email for **invitations**, **notifications** (license expiry, shares, system
alerts to admins) and **login codes when email MFA is enabled** — it is off by default
(`INWARDIS_AUTH_MFA_ENABLED=true` turns it on, and then a working mail path *is* required to
log in — the product refuses to start with MFA on and no `SMTP_HOST`, rather than lock everyone out). With no `SMTP_HOST` set, the product runs normally, the System page shows mail as
*not configured*, and those emails are simply not sent. Two ways to provide a mail path:

**A — your SMTP relay (production):** uncomment and set in the compose environment (or `.env`):

```yaml
SMTP_HOST: smtp.mycompany.com
SMTP_PORT: "587"
SMTP_USERNAME: ...
SMTP_PASSWORD: ...
SMTP_AUTH: "true"
SMTP_STARTTLS: "true"
```

**B — evaluation only, no relay at hand:** add a [Mailpit](https://mailpit.axllent.org/)
service to the same compose file and read your codes in its web UI at `http://<host>:8025`:

```yaml
  mailpit:
    image: axllent/mailpit
    ports:
      - "8025:8025"
```

and set `SMTP_HOST: mailpit` / `SMTP_PORT: "1025"` on the product service (no auth, no TLS —
the defaults). Every email the product sends lands in Mailpit instead of a real inbox — fine
for trying it out, not for a team install.

## Environment variable reference

Everything beyond the three secrets, `INWARDIS_VERSION` and mail is optional; defaults are
production-sane.

### Core

| Variable | Default | Purpose |
|----------|---------|---------|
| `INWARDIS_VERSION` | **required** | The version of your downloaded bundle (e.g. `1.0.0-rc.53`). The compose file pins all three image tags by it and refuses to start without it — a wrong value fails with *image not found* instead of silently running an older image. Verify at `/actuator/info`. |
| `SPRING_DATASOURCE_URL` | set by compose | JDBC URL of the PostgreSQL database |
| `SPRING_DATASOURCE_USERNAME` / `_PASSWORD` | set by compose | Database credentials |
| `INWARDIS_DATA_DIR` | `/app/data` (image) | License key location — must be on a volume |
| `INWARDIS_REPOS_ROOT` | `/app/data/repos` (image) | Git version repositories — must be on a volume |
| `INWARDIS_GIT_ATTACHMENTS` | `false` | Install-wide default for *Attachments in the git tree* (text attachments verbatim + an `attachments.yaml` per element; binaries never). Each project can override it in Git Settings |
| `INWARDIS_RENDER_SIDECAR_URL` | `http://localhost:3001` | Render sidecar address (compose sets the container name) |
| `JAVA_OPTS` | empty | Extra JVM flags, e.g. `-Xmx2g` |
| `INWARDIS_WORKSPACE_NAME` | `Workspace` | Display name of the install-wide workspace, created on first startup (rename later in the Admin Panel) |
| `INWARDIS_MAX_PROJECT_DEPTH` | `8` | How deep projects may nest (subprojects of subprojects); a move or create beyond it is refused |

### Attachment storage

| Variable | Default | Purpose |
|----------|---------|---------|
| `INWARDIS_ATTACHMENT_STORAGE` | `db` | Where **new** attachments are stored: `db` (in PostgreSQL), `file` (a directory), `s3` (an S3-compatible bucket). Existing attachments keep working wherever they were stored; backup + restore moves them |
| `INWARDIS_ATTACHMENT_DIR` | `/app/data/attachments` | Directory for `file` storage — must be on a volume |
| `INWARDIS_S3_BUCKET` | unset | Bucket for `s3` storage; setting it enables the S3 client |
| `INWARDIS_S3_ENDPOINT` / `INWARDIS_S3_REGION` | unset / `us-east-1` | Endpoint for MinIO and other on-prem stores (leave unset for AWS); region |
| `INWARDIS_S3_ACCESS_KEY` / `INWARDIS_S3_SECRET_KEY` | unset (SDK default chain) | Static credentials; unset uses the AWS default chain (env, profile, instance role) |
| `INWARDIS_S3_PATH_STYLE` | `false` | `true` for MinIO and most on-prem stores |

### Mail

| Variable | Default | Purpose |
|----------|---------|---------|
| `SMTP_HOST` / `SMTP_PORT` | unset (email off) / `1025` | Your mail relay (see **Email setup** above) |
| `INWARDIS_AUTH_MFA_ENABLED` | `false` | Email 6-digit login codes — needs a working `SMTP_HOST` |
| `SMTP_USERNAME` / `SMTP_PASSWORD` | empty | Relay credentials |
| `SMTP_AUTH` / `SMTP_STARTTLS` | `false` / `false` | Enable for authenticated/TLS relays |
| `NOTIFICATIONS_ENABLED` | `true` | In-app + email notifications |
| `NOTIFICATION_FROM_ADDRESS` / `NOTIFICATION_FROM_NAME` | `noreply@inwardis.local` / `Inwardis` | Sender of every email the product sends — set the address to one your relay accepts |
| `APP_BASE_URL` | `http://localhost:5173` | The URL users open the product at; every link in an email (invitation, mention, login code) is built on it |

### Security & limits

| Variable | Default | Purpose |
|----------|---------|---------|
| `RATE_LIMIT_ENABLED` | `true` | Global API rate limiting (`false` for trusted networks) |
| `RATE_LIMIT_RPM` | `300` | Requests per minute per user |
| `RATE_LIMIT_LOGIN` | `10` | Login attempts per minute per IP (brute-force cap) |
| `MCP_RATE_LIMIT_ENABLED` | `true` | MCP (agent) rate limiting per API key — a runaway-loop guard, not a meter. `false` on a trusted single-user install |
| `MCP_RATE_LIMIT_READ` | `240` | MCP read calls per minute per API key |
| `MCP_RATE_LIMIT_WRITE` | `120` | MCP single-entity writes per minute per API key (incl. `create_version`) |
| `MCP_RATE_LIMIT_BULK` | `60` | MCP batch / render / version-diff calls per minute per API key (`apply_changes`, `render_view`, …) |
| `MCP_RATE_LIMIT_OVERALL` | `480` | All MCP calls per minute per API key |
| `MCP_ATTACHMENT_MAX_BYTES` | `8388608` | Largest file (decoded bytes) an agent may add or fetch over MCP; larger files use the REST attachments endpoint |
| `INWARDIS_METRICS_SCRAPE_TOKEN` | unset | Token granting Prometheus access to `/actuator/prometheus` |
| `INWARDIS_MAX_UPLOAD_SIZE` | `2GB` | Largest single upload over REST — attachments, imports and workspace-backup restores (Spring size syntax, e.g. `500MB`) |
| `INWARDIS_SLOW_QUERY_THRESHOLD_MS` | `500` | Database statements slower than this are logged as slow queries and counted on the admin Performance card |
| `INWARDIS_OBSERVABILITY_ALERTS_ENABLED` | `true` | Threshold alerts on the admin Performance card (error rate, slow queries, memory); `false` silences them |
| `CORS_ORIGINS` | `http://localhost:5173` | Only relevant if a separate web tier fronts the API — the standard install is same-origin |

### Feature flags

| Variable | Default | Purpose |
|----------|---------|---------|
| `INWARDIS_FEATURE_COLLABORATION` | `true` | Real-time collaboration — the *mode* is chosen per project; live sync also needs the `hocuspocus` container (`--profile collaboration`) |
| `INWARDIS_FEATURE_VERSIONING` | `true` | Git-backed version history |
| `INWARDIS_FEATURE_MCP` | `true` | MCP endpoint for AI agents (API keys are the real gate) |

Flags can also be toggled at runtime from the Admin Panel. OIDC single sign-on has its own
configuration — see the in-app manual once installed.

## Running behind a reverse proxy

Terminate TLS at Nginx/Traefik/Caddy and forward to port 8080. The product trusts
`X-Forwarded-Proto`/`-Host`/`-For`, so HTTPS detection, generated URLs and per-IP rate
limiting are correct behind a proxy with standard forwarding headers — no extra configuration.
Health probes for orchestrators: `GET /actuator/health/liveness` and
`/actuator/health/readiness`, both anonymous and status-only.

---

Problems installing? [Open a bug report](https://github.com/inwardis/feedback/issues/new?template=bug_report.yml)
— installation friction is exactly the feedback we want.
