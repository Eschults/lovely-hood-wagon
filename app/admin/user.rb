ActiveAdmin.register User do
  index do
    selectable_column
    column :id
    column :email
    column :first_name
    column :last_name
    column :created_at
    column :admin
    actions
  end

  permit_params :name, :email, :first_name, :last_name, :identity_verified, :address_verified
end
