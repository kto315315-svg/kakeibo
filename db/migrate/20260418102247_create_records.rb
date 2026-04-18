class CreateRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :records do |t|
      t.integer :amount
      t.date :date
      t.text :memo
      t.string :income_or_expense
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
