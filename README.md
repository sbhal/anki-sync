# Overview
This repository builds the official [Anki sync server](https://docs.ankiweb.net/sync-server.html) and offers it as a Docker container that can be hosted independently.

### Docker Compose

You can use the provided docker compose to run:

```yaml
version: '3.3'
services:
  anki-sync:
    image: ghcr.io/sbhal/anki-sync:2.1.66
    container_name: anki-sync
    environment:
      - SYNC_USER1=user:pass
      - SYNC_USER2=user2:pass2
      - SYNC_BASE=/data
      - SYNC_HOST=192.168.1.x
      - SYNC_PORT=8080
    ports:
      - '8080:8080'
    volumes:
      - /path/to/data:/data
    restart: unless-stopped
```

And to run:

```console
docker-compose up -d
```

Replace the paths in `volumes` as in the above step.

The environment variables are detailed at [here](https://docs.ankiweb.net/sync-server.html).

List of image tags are available [here](https://github.com/sbhal/anki-sync/pkgs/container/anki-sync) and they directly correspond with the ones found at https://github.com/ankitects/anki/tags.

This is done after offician maintainer declined to support in near future [here](https://github.com/ankitects/anki/issues/2715).
# Runbooks
## Push tags 
```
git tag v2.1.66 main
git push origin v2.1.66
```
