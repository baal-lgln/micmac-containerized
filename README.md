# MicMac containerized
Provides a minimal [MicMac](https://github.com/micmacIGN/micmac) docker image.

## Local development and testing
Build the image with:

```bash
docker build --pull --rm -t micmac:latest .
```

Mount a Volume with your data at `$(pwd)/data` and run the image with:

```bash
docker run -v $(pwd)/data:/data --rm -it micmac:latest
```