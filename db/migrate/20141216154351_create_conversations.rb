class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :user1, index: true
      t.references :user2, index: true

      t.timestamps
    end
  end
end
