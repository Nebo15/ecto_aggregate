#!/bin/sh
# `pwd` should be /opt/ecto_aggregate
APP_NAME="ecto_aggregate"

if [ "${DB_MIGRATE}" == "true" ]; then
  echo "[WARNING] Migrating database!"
  ./bin/$APP_NAME command "${APP_NAME}_tasks" migrate!
fi;
