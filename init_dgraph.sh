#!/bin/bash
set -e

# 1. Очистка
sudo rm -rf dgraph/{zero1,zero2,zero3,alpha1,alpha2}
mkdir -p dgraph/{zero1,zero2,zero3,alpha1,alpha2}

# 2. Запуск Zero1
docker-compose up -d zero1
# Ждём 10–15 секунд, пока zero1 станет лидером
sleep 30
# 3. Запуск остальных Zero
docker-compose up -d zero2 zero3
# Ждём 10 секунд
sleep 30
# 4. Проверка: все Zero работают?

# 5. Запуск Alpha
docker-compose up -d alpha1 alpha2 alpha3 ratel