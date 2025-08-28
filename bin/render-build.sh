#!/usr/bin/env bash
set -o errexit

# 1) Install Ruby gems
bundle install

# 2) Install JS deps (if you’re using webpack/esbuild)
if command -v yarn >/dev/null 2>&1; then
  yarn install --frozen-lockfile || yarn install
elif [ -f package-lock.json ]; then
  npm ci || npm install
fi

# 3) Compile assets (skip if API-only)
bundle exec rake assets:precompile
