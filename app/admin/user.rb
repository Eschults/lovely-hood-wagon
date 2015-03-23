ActiveAdmin.register User do
  index do
    selectable_column
    column :id
    column :email
    column :first_name
    column :last_name
    column :street
    column :identity_proof
    column :address_proof
    column :iban
    column :authorized
    actions
  end

  permit_params :name, :email, :first_name, :last_name, :identity_verified, :address_verified
end
