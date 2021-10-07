class AddContentToPicture < ActiveRecord::Migration[6.1]
  def change
    add_column :pictures, :content, :text
  end
end
