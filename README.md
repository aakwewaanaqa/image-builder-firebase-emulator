# Firestore Emulator No Problem

## Step 1

For amd / x86_64 use this one.
```sh

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg JDK_ARCH=linux-x64 \
  --build-arg JDK_ARCH=linux-aarch64 \
  -t firestore-emulator:latest \
  .
```

## Step 2

Run this first to login and store config in the volume.
```sh
docker volume create firestore-config
docker volume create firestore-data

docker run --rm -it \
    --name=firebase \
    -p 4000:4000 -p 1337:1337 \
    -v firestore-config:/root/.config \
    firestore-emulator
```
