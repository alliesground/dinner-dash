echo $SSH_PUBLIC_KEY > ~/.ssh/authorized_keys

bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:create db:migrate
echo 'Postgres database has been created and migrated!'

# Remove a potentially pre-existing server.pid for Rails.
rm -f tmp/pids/server.pid

bundle exec rails server -b 0.0.0.0 -p 8080
