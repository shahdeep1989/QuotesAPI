class AddCategoryIdToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :category_id, :integer
  end
end
