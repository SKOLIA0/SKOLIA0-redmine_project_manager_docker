#!/bin/sh

# Ждем, пока база данных станет доступной
until nc -z db 5432; do
  echo "Waiting for PostgreSQL..."
  sleep 3
done

echo "PostgreSQL is up - executing command"
exec "$@"
