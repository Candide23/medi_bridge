class CreateHealthRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :health_records do |t|
      t.integer :record_type
      t.string :language
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
