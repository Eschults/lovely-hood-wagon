ActiveAdmin.register User do
  index do
    selectable_column
    column :id
    column :sign_in_count
    column :email
    column :first_name
    column :last_name
    column :street
    column "identity" do |product|
      image_tag product.identity_proof.url(:medium), width: '50'
    end
    column "address" do |product|
      image_tag product.address_proof.url(:medium), width: '50'
    end
    column :iban
    column :authorized
    actions
  end

  permit_params :name, :email, :first_name, :last_name, :identity_verified, :address_verified
end
