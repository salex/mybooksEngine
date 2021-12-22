# This migration comes from mybooks (originally 20211219042331)
class CreateMybooksBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :mybooks_books do |t|
      t.string :name
      t.string :root
      t.string :assets
      t.string :equity
      t.string :liabilities
      t.string :income
      t.string :expenses
      t.string :checking
      t.string :savings
      t.text :settings

      t.timestamps
    end
  end
end
