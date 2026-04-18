class CreateRecordTags < ActiveRecord::Migration[8.1]
  def change
    create_table :record_tags do |t|
      t.references :record, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
