class AddTextToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :text, :text
  end
end
