#!/bin/bash

echo "Waiting for database to be ready..."
until pg_isready -h db -U postgres -d gobid; do
  sleep 1
done

echo "Creating database id doesn't exist..."
psql -h db -U postgres -d gobid -c "CREATE DATABASE gobid;" || true

echo "Applying migrations..."
cd /app/internal/store/pgstore/migrations
tern migrate

echo "Starting application"
cd /app

exec ./main