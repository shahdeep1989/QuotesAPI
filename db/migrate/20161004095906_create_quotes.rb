class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :quote
      t.integer :index_val
      t.integer :cnt, :default => 0

      t.timestamps null: false
    end
  end
end
