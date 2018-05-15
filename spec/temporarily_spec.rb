RSpec.describe Temporarily do
  it 'has a version number' do
    expect(Temporarily::VERSION).not_to be nil
  end

  shared_examples '.call' do
    let(:connection) { ActiveRecord::Base.connection }
    after { Thing.delete_all }

    it 'Creates a temporary table' do
      Thing.create(name: 'abc')
      Thing.create(name: 'xyz')

      tmp_table = nil
      Temporarily.call(Thing, Thing.limit(1)) do
        expect(Thing.count).to eq 1
        expect(Thing.table_name).to_not eq 'things'
        tmp_table = Thing.table_name
      end
      expect(Thing.table_name).to eq 'things'
      expect(connection.table_exists?(tmp_table)).to eq false
      expect(connection.table_exists?(Thing.table_name)).to eq true
    end
  end

  context 'sqlite3' do
    before { Database.establish_connection(engine: :sqlite3) }
    include_examples '.call'
  end

  context 'postgresql', :ci do
    before { Database.establish_connection(engine: :postgresql) }
    include_examples '.call'
  end

  context 'mysql2', :ci do
    before { Database.establish_connection(engine: :mysql2) }
    include_examples '.call'
  end
end
