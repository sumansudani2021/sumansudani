-- Runs once, on the very first start (empty data volume).
-- The official image already creates 'root'@'%' with ALL PRIVILEGES WITH GRANT OPTION;
-- this makes it explicit and idempotent.

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- Put additional *.sql, *.sql.gz or *.sh files in ./init to seed data on first start.
-- They run in alphabetical order (02-..., 03-...).
