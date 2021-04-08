## SETUP

```sh
bundle install
yarn install
# DB_PASSWORD environment variable is required, or update the config/database.yml file.
rails db:create
rails db:migrate
```
## START SERVER
```
rails s
```
