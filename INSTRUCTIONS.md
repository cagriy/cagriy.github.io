# Phase Shift — Post Writing Guide

## Creating a New Post

Use the `new-post.sh` script:

```bash
# Basic post
./new-post.sh "My Post Title"

# Post with a splash/header image
./new-post.sh "My Post Title" --image my-image.jpg
```

This creates `_posts/YYYY-MM-DD-my-post-title.md` with front matter pre-filled and prints the filename.

Open the file in your editor, write your content in Markdown below the `---` closing line, then save.

## Front Matter Reference

```yaml
---
title: "My Post Title"
date: 2026-02-22
categories:
  - Technology        # one or more categories
tags:
  - ai
  - ethics
excerpt: "Optional custom excerpt shown on the homepage and archive pages."
header:
  overlay_image: /assets/images/my-image.jpg
  overlay_filter: 0.5    # 0.0–1.0 darkness overlay for text readability
  caption: "Photo credit: Source Name"
---
```

All fields except `title` and `date` are optional.

## Adding a Splash / Header Image

1. Drop your image into `assets/images/`:
   ```
   assets/images/my-image.jpg
   ```

2. Reference it in the post front matter:
   ```yaml
   header:
     overlay_image: /assets/images/my-image.jpg
     overlay_filter: 0.5
   ```

3. The image appears as a full-width banner at the top of the post with the title overlaid.

## Previewing Locally

```bash
# First time: install dependencies
bundle install

# Serve with live reload at http://localhost:4000
bundle exec jekyll serve
```

## Publishing

```bash
git add .
git commit -m "New post: My Post Title"
git push
```

GitHub Pages builds and deploys automatically within ~1 minute.

## Directory Structure

```
.
├── _config.yml          # Site configuration
├── _data/
│   └── navigation.yml   # Top navigation links
├── _pages/
│   ├── about.md         # /about/
│   ├── categories.md    # /categories/
│   ├── posts.md         # /posts/
│   └── tags.md          # /tags/
├── _posts/              # Blog posts (YYYY-MM-DD-title.md)
├── assets/
│   └── images/          # Splash images for posts
├── Gemfile              # Ruby dependencies for local dev
├── index.html           # Homepage (uses Minimal Mistakes 'home' layout)
└── new-post.sh          # Script to scaffold a new post
```
