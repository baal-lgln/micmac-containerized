# MicMac containerized
Provides a minimal [MicMac](https://github.com/micmacIGN/micmac) docker image: 

```
docker pull ghcr.io/baal-lgln/micmac-containerized:latest
```

## Local development and testing
Build the image with:

```bash
docker build --pull --rm -t micmac-containerized:latest .
```

Mount a Volume with your data at `$(pwd)/data` and run the image with:

```bash
docker run -v $(pwd)/data:/data --rm -it micmac-containerized:latest
```
