#!/bin/sh
set -eu

# Se foi passado um comando manual, execute-o normalmente.
if [ "$#" -gt 0 ] && [ "$1" != "apache2-foreground" ]; then
  exec "$@"
fi

if [ ! -f .env ] && [ -f .env.dist ]; then
  echo "Criando .env a partir de .env.dist..."
  cp .env.dist .env
  chown --reference=.env.dist .env
fi

mkdir -p var/cache var/log vendor
chown -R www-data:www-data var vendor
chmod -R ug+rwX var vendor

if [ ! -f vendor/autoload.php ]; then
  echo "Instalando dependências..."

  composer install --no-plugins --no-scripts --no-interaction

  composer update symfony/flex \
    --with-dependencies \
    --no-plugins \
    --no-scripts \
    --no-interaction

  composer install --no-interaction
fi

exec apache2-foreground