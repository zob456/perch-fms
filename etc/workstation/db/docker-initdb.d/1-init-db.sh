#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER perchfmsservice WITH PASSWORD 'servicedbPassword';
    CREATE DATABASE perchfmsdb;
    GRANT ALL PRIVILEGES ON DATABASE perchfmsdb TO perchfmsservice;
EOSQL