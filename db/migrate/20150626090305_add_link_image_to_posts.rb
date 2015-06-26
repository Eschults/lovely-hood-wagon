class AddLinkImageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :link_image, :string
  end
end
