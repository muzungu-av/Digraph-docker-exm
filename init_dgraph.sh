#!/bin/bash
set -e

# 1. Очистка
sudo rm -rf dgraph/{zero1,zero2,zero3,alpha1,alpha2,alpha3}
mkdir -p dgraph/{zero1,zero2,zero3,alpha1,alpha2,alpha3}

# 2. Запуск Zero1
docker-compose up -d 