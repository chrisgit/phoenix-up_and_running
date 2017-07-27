#!/bin/sh

# Place to store our application
mkdir -p /tmp/phoenix
cd /tmp/phoenix

# http://www.phoenixframework.org/v0.11.0/docs/mix-tasks
# https://stackoverflow.com/questions/25911361/elixir-mix-auto-acknowledge
# https://unix.stackexchange.com/questions/102484/what-is-the-point-of-the-yes-command

# Install hex no prompt
mix local.hex --force

# Install Phoenix no prompt
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

# Create umbrella application
mix new testapp_umbrella --umbrella
cd testapp_umbrella/apps

# Create test application
mix new testapp --sup

# Create Phoenix web app
mix phoenix.new testapp_web --no-ecto

# With no dependencies
# mix phoenix.new testapp_web --no-ecto --no-brunch
# mix deps.get
# if mix phoenix.new testapp_web --no-ecto fails then npm install or npm install && node node_modules/brunch/bin/brunch build

cd testapp_web
mix phoenix.server

# alternatively use interactive elixir
# iex -S mix phoenix.server

# Access the site from browser on host or curl on guest (normally port 4000) with http://localhost:4000