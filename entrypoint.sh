#!/bin/bash
set -e

# 初始化 Firebase 项目
if [ ! -f firebase.json ]; then
    echo "Initializing Firebase project..."
    mkdir -p firebase
    cd firebase
    
    # 自动生成 firebase.json
    cat <<EOF > firebase.json
{
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  },
  "emulators": {
    "firestore": {
      "host": "0.0.0.0",
      "port": 1337
    },
    "ui": {
      "enabled": true,
      "host": "0.0.0.0",
      "port": 4000
    }
  }
}
EOF
fi

firebase login --no-localhost
firebase emulators:start --project=default --import=data --export-on-exit=data
