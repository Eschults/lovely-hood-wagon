class AddAttachmentAddressProofToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :address_proof
    end
  end

  def self.down
    remove_attachment :users, :address_proof
  end
end
