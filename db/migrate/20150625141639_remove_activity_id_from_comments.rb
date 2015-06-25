class RemoveActivityIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :activity_id, :integer
  end
end
