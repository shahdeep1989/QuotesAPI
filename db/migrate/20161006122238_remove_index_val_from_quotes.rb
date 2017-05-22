class RemoveIndexValFromQuotes < ActiveRecord::Migration
  def change
    remove_column :quotes, :index_val, :integer
  end
end
