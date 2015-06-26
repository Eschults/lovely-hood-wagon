class AddLinkTitleToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :link_title, :string
  end
end
