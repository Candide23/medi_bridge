class AddTextCacheToHealthRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :health_records, :text_cache, :text
    add_index :translations, [:health_record_id, :language], unique: true
  end
end
