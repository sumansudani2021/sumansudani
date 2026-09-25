// Runs once, on the very first start (empty data volume), authenticated as root.
// `db` is MONGO_INITDB_DATABASE (default_database).

// MongoDB only lists a database once it contains something, so create a
// small collection to make default_database visible in Compass/DBeaver.
// Safe to drop once you've added your own collections.
db.createCollection("_bootstrap");
db._bootstrap.insertOne({ createdAt: new Date(), note: "Created by local docker setup. Safe to drop." });

// The root user (role "root" on admin) already has full rights: create/drop databases,
// users and roles, backup/restore, etc. Nothing else to grant.
