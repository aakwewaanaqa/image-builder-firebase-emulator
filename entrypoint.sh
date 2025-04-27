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

    # 自动登录 (需通过 volume 挂载已认证的 HOME 目录)
    if [ -f /root/.config/configstore/firebase-tools.json ]; then
        echo "Using existing Firebase credentials"
    else
        echo "⚠️ 请先通过交互式终端登录：docker exec -it [容器ID] firebase login --no-localhost"
    fi
fi

# 启动模拟器
firebase emulators:start --project=default --import=data --export-on-exit=data
