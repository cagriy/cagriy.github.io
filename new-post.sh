#!/usr/bin/env bash
# Usage:
#   ./new-post.sh "My Post Title"
#   ./new-post.sh "My Post Title" --image path/to/image.jpg

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 \"Post Title\" [--image path/to/image.jpg]"
  exit 1
fi

TITLE="$1"
IMAGE=""

# Parse optional --image flag
shift
while [[ $# -gt 0 ]]; do
  case "$1" in
    --image)
      IMAGE="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

DATE=$(date +%Y-%m-%d)
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
FILENAME="_posts/${DATE}-${SLUG}.md"

if [[ -f "$FILENAME" ]]; then
  echo "File already exists: $FILENAME"
  exit 1
fi

IMAGE_VALUE="${IMAGE}"

cat > "$FILENAME" <<EOF
---
layout: post
title: "${TITLE}"
author: "Cagri"
date: ${DATE}
categories:
  - Uncategorized
tags:
  - []
image: ${IMAGE_VALUE}
---

EOF

echo "Created: $FILENAME"
