#!/usr/bin/env bash
set -e

# Cria estrutura de Assets.xcassets e coloca imagens de exemplo (base64 -> png)
ASSETS_DIR="StretchApp/Assets.xcassets"
mkdir -p "$ASSETS_DIR"

# Função que cria um imageset com uma imagem base64 e Contents.json
create_imageset() {
  name="$1"
  b64="$2"
  dir="$ASSETS_DIR/${name}.imageset"
  mkdir -p "$dir"
  echo "$b64" | base64 --decode > "$dir/${name}.png"
  cat > "$dir/Contents.json" <<EOF
{
  "images" : [
    {
      "idiom" : "universal",
      "filename" : "${name}.png",
      "scale" : "1x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}
EOF
  echo "Created $dir with ${name}.png"
}

# 1x1 transparent PNG (placeholder)
TRANSPARENT_PNG="iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII="

# Exemplos: Shoulder, Neck, Calf
create_imageset "Shoulder" "$TRANSPARENT_PNG"
create_imageset "Neck" "$TRANSPARENT_PNG"
create_imageset "Calf" "$TRANSPARENT_PNG"

echo "Assets created at $ASSETS_DIR. Open StretchApp/Assets.xcassets in Xcode to replace placeholders."