class ChangeRecordTypeToStringInHealthRecords < ActiveRecord::Migration[7.1]
  def up
    # cast integer to text (Postgres syntax); on SQLite it’s fine without USING
    change_column :health_records, :record_type, :string, using: 'record_type::text'
  end

  def down
    change_column :health_records, :record_type, :integer, using: 'record_type::integer'
  end
end
