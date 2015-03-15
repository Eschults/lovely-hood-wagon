ActiveAdmin.register Offer do
  index do
    selectable_column
    column :id
    column :user
    column :nature
    column :type_of_offer
    column :hourly_price
    column :weekly_price
    column :daily_price
    column :published
    column :guarantee
    column :created_at
    column :updated_at
    actions
  end

  permit_params :published, :sold
end
