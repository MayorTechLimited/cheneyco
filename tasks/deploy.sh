#!/bin/bash
# ---
# environment:
#   - SSH_AGENT_PID
#   - SSH_AUTH_SOCK
# ---
set -eu

. venv/bin/activate

rm -rf dist
staticjinja build --outpath ./dist
cp -r images iframeResizer.min.js dist/
tailwindcss -i ./styles.css -o ./dist/styles.css --minify
tailwindcss -i ./resources.css -o ./dist/resources.css --minify

ghp-import dist --branch=main --cname=cheneyco.mayortech.co.uk

git checkout main
git push origin main
git checkout develop
