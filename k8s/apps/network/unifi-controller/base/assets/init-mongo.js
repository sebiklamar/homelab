db.getSiblingDB("unifidb").createUser({user: "unifiuser", pwd: "unifipass", roles: [{role: "dbOwner", db: "unifidb"}]});
db.getSiblingDB("unifidb_stat").createUser({user: "unifiuser", pwd: "unifipass", roles: [{role: "dbOwner", db: "unifidb_stat"}]});
// db.getSiblingDB("unifidb_stat").grantRolesToUser("unifiuser", ["dbOwner"]);
