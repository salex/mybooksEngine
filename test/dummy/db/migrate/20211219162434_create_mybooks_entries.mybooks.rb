# This migration comes from mybooks (originally 20211219155157)
class CreateMybooksEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :mybooks_entries do |t|
      t.references :book, null: false, foreign_key: true
      t.string :numb
      t.date :post_date
      t.string :description
      t.string :fit_id
      t.integer :lock_version

      t.timestamps
    end
  end
end
