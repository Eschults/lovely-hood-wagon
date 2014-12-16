class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :conversation, index: true
      t.references :writer, index: true
      t.datetime :read_at
      t.text :content

      t.timestamps
    end
  end
end
