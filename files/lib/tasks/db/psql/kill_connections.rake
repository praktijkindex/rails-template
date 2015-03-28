#
# This patch ensures db:drop works for postgres db, by killing the postgres connections
#
# Thanks http://stackoverflow.com/a/14164210/538534 and
# https://gist.github.com/mattscilipoti/4455341#comment-878446
namespace "db:psql" do
  task :kill_connections => :environment do
    env = Rails.env
    db_config = Rails.configuration.database_configuration[env]
    fail(ArgumentError, "Could not find db config entry for env (#{env})") unless db_config
    db_name = db_config["database"]

    # thanks to http://stackoverflow.com/questions/12924466/capistrano-with-postgresql-error-database-is-being-accessed-by-other-users
    # previously, we were killing the postgres processes: http://stackoverflow.com/questions/2369744/rails-postgres-drop-error-database-is-being-accessed-by-other-users
    cmd = %(psql -c "SELECT pid, pg_terminate_backend(pid) as terminated FROM pg_stat_activity WHERE pid <> pg_backend_pid();" -d "#{db_name}")

    puts "WARN: killing connections to #{db_name}."

    unless system(cmd)
      fail $?.inspect
    end
  end
end

task "db:drop" => "db:psql:kill_connections"

