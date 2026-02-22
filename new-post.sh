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

# Build front matter
FRONT_MATTER="---
title: \"${TITLE}\"
date: ${DATE}
categories:
  - Uncategorized
tags:
  - []"

if [[ -n "$IMAGE" ]]; then
  FRONT_MATTER="${FRONT_MATTER}
header:
  overlay_image: /assets/images/${IMAGE}
  overlay_filter: 0.5"
fi

FRONT_MATTER="${FRONT_MATTER}
---

"

echo "${FRONT_MATTER}" > "$FILENAME"

echo "Created: $FILENAME"
