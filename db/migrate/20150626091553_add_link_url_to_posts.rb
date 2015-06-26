class AddLinkUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :link_url, :string
  end
end
