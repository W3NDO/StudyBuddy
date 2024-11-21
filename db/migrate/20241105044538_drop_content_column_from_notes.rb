class DropContentColumnFromNotes < ActiveRecord::Migration[7.0]
  def change
    remove_column :notes, :content
  end
end
