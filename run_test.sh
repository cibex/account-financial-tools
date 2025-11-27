#!/bin/bash

module="$1"

echo "Preparing..."
docker run --rm -v ./:/mnt/extra-addons --link postgresql-15:db -t odoo:19.0 bash -c "odoo db --db_host=db --db_user=odoo --db_password=odoo drop test"

echo "Running tests for $module..."
docker run --rm -v ./:/mnt/extra-addons --link postgresql-15:db -t odoo:19.0 -- -d test -i "$module" --test-enable --test-tags "/$module"

echo "Cleaning up..."
docker run --rm -v ./:/mnt/extra-addons --link postgresql-15:db -t odoo:19.0 bash -c "odoo db --db_host=db --db_user=odoo --db_password=odoo drop test"

