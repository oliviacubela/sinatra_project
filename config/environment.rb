ENV['SINATRA_ENV'] ||= "development"
ENV['SINATRA_ENV'] ||= "production"


require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do
  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )

end

# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )


configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

  ActiveRecord::Base.establish_connection(
    :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :database => db.path[1..-1],
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
    :encoding => 'utf8'
    )

end

require './app/controllers/application_controller'
require_all 'app'