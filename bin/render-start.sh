#!/usr/bin/env bash
set -o errexit

echo "Starting app in ${RAILS_ENV:-production}…"

echo "Running db:prepare…"
bundle exec rails db:prepare

if [ -f config/puma.rb ]; then
  echo "Launching Puma…"
  exec bundle exec puma -C config/puma.rb
else
  echo "Launching Rails server…"
  exec bundle exec rails server -b 0.0.0.0 -p "${PORT:-3000}"
fi
