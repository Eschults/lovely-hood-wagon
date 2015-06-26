class AddLinkDescriptionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :link_description, :text
  end
end
