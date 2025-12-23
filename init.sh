#!/bin/bash

# Ждём, пока Dgraph Alpha будет готов
until curl -s http://localhost:8080/health > /dev/null; do
  echo "Waiting for Dgraph to be ready..."
  sleep 2
done

# Устанавливаем схему
curl -X POST http://localhost:8080/alter -d $'
  name: string @index(exact) .
  email: string @index(exact) @upsert .
  friend: [uid] @reverse .
'

echo "Schema set!"