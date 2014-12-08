class AddAttachmentPictureToOffers < ActiveRecord::Migration
  def self.up
    change_table :offers do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :offers, :picture
  end
end
