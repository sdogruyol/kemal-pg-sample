require "kemal"
require "json"
require "pg"

PG_URL = "postgres://username@localhost:5432/db_name"
DB     = PG.connect PG_URL

# Fetches all the users from the DB and serves it as a JSON array.
# You need to have the corresponding table and fields.
get "/" do |env|
  env.content_type = "application/json"
  users = DB.exec("SELECT * FROM users")
  users.to_hash.map do |user|
    {first_name: user["first_name"] as String, last_name: user["last_name"] as String}
  end.to_json
end
