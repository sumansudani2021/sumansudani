-- Runs once, on the very first start (empty data volume), as the superuser (root)
-- connected to default_database.

-- The configured user (root) is already SUPERUSER; make every admin attribute explicit.
ALTER ROLE CURRENT_USER WITH SUPERUSER CREATEDB CREATEROLE REPLICATION BYPASSRLS LOGIN;

-- Useful extensions in the default database
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
CREATE EXTENSION IF NOT EXISTS pgcrypto;          -- gen_random_uuid(), crypt()
CREATE EXTENSION IF NOT EXISTS citext;            -- case-insensitive text

-- Also add them to template1, so every NEW database you create inherits them.
\connect template1
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS citext;
