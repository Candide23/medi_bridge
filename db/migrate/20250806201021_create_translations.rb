class CreateTranslations < ActiveRecord::Migration[7.1]
  def change
    create_table :translations do |t|
      t.string :language
      t.text :content
      t.references :health_record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
