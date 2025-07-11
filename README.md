# Firestore Emulator No Problem

## Step 1

Check what your computer's architecture is.
```sh

arch
```

If it says x86_64 it's an amd computer. <br>
If it says arm64 it's an arm computer. <br>

## Step 2

For amd / x86_64 use this one.
```sh

docker build \
    --build-arg JDK_ARCH=linux-x64 \
    -t firestore-emulator/amd .
```

For arm64 use this one.
```sh

docker build \
    --build-arg JDK_ARCH=linux-aarch64 \
    -t firestore-emulator/arm .
```

## Step 3

Run this first to login and store config in the volume.
For amd / x86_64 use this one.
```sh
docker run --rm -it \
    --name=firebase \
    -p 4000:4000 -p 1337:1337 \
    -v firestore-config:/root/.config \
    -v firestore-data:/workspace/firebase \
    firestore-emulator/amd
```

Run this first to login and store config in the volume.
For arm64 use this one.
```sh
docker run --rm -it \
    --name=firebase \
    -p 4000:4000 -p 1337:1337 \
    -v firestore-config:/root/.config \
    -v firestore-data:/workspace/firebase \
    firestore-emulator/arm
```