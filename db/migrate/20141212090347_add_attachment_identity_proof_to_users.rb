class AddAttachmentIdentityProofToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :identity_proof
    end
  end

  def self.down
    remove_attachment :users, :identity_proof
  end
end
