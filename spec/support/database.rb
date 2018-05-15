module Database
  def self.establish_connection(engine:)
    case engine
    when :sqlite3
      ActiveRecord::Base.establish_connection(
        adapter: engine,
        database: ':memory:'
      )
    else
      ActiveRecord::Base.establish_connection(connection_params(engine))
    end

    create_tables
  end

  def self.create_tables
    ActiveRecord::Base.connection.tap do |conn|
      conn.drop_table(:things, if_exists: true)
      conn.create_table :things do |t|
        t.text :name
      end
    end
  end

  def self.connection_params(engine)
    params = {
      adapter: engine,
      database: 'temporarily_test',
      encoding: 'utf8'
    }
    params[:username] = 'travis' if engine == :mysql2
    params
  end
end
