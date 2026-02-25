# xbdStats

This tool can be deployed as a Docker container. The container runs the
`xbdStats` binary and generates its required `xbdStats.ini` at startup
from environment variables.

## Quick Start

1.  Create a folder for deployment and add a `docker-compose.yml` file.
2.  Optionally create a `.env` file next to it if you want to keep
    `TMDB_API_KEY` out of the compose file.
3.  Start the container with `docker compose up -d`.

### Example `docker-compose.yml`
```yaml
services:
  xbdstats:
    image: ghcr.io/Xbox-Discord-Rich-Presence/xbdstats
    container_name: xbdstats
    restart: unless-stopped
    environment:
      XBOX360_IP: 192.168.0.162
      XBOX360_POLL_INTERVAL: 30
      XBOX360_VERBOSE: 0
      XBOX360_ENABLED: false
      TMDB_API_KEY: ${TMDB_API_KEY}
    ports:
      - 1101:1101
      - 1102:1102
      - 1103:1103
networks: {}
```

### Optional `.env`
```
TMDB_API_KEY=tmdb_key_here
```

## Configuration

The container writes a `xbdStats.ini` at startup based on environment
variables.

### Environment Variables
| Variable                | Default         | Description                              |
| ----------------------- | --------------- | ---------------------------------------- |
| `XBOX360_IP`            | `192.168.0.162` | IP address of the Xbox 360 to poll       |
| `XBOX360_POLL_INTERVAL` | `30`            | Poll interval in seconds                 |
| `XBOX360_VERBOSE`       | `0`             | Verbose logging (`0`/`1`)                |
| `XBOX360_ENABLED`       | `false`         | Enable Xbox 360 polling (`true`/`false`) |
| `TMDB_API_KEY`          | (empty)         | TMDB API key for media metadata          |

## Updating

Pull the latest image tag you're using and restart:
```bash
docker compose pull
docker compose up -d
```