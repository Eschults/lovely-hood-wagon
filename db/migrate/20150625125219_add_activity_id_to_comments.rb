class AddActivityIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :activity_id, :integer
  end
end
