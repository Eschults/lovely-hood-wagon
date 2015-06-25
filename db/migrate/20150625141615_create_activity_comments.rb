class CreateActivityComments < ActiveRecord::Migration
  def change
    create_table :activity_comments do |t|
      t.integer :activity_id
      t.text :content
      t.references :user, index: true

      t.timestamps
    end
  end
end
