module Database
  def self.establish_connection(engine:)
    case engine
    when :sqlite3
      ActiveRecord::Base.establish_connection(
        adapter: engine,
        database: ':memory:'
      )
    else
      create_database(engine)
    end

    create_tables
  end

  def self.create_database(engine)
    params = connection_params(engine)
    ActiveRecord::Base.establish_connection(params)
    begin
      ActiveRecord::Base.connection.create_database 'temporarily_test'
    rescue ActiveRecord::StatementInvalid
    end
    ActiveRecord::Base.establish_connection(
      params.merge(database: 'temporarily_test')
    )
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
    params = { adapter: engine, encoding: 'utf8' }
    params[:username] = 'travis' if engine == :mysql2
    params
  end
end
