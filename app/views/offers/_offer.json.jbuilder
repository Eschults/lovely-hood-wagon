json.extract! offer, :id, :nature, :description, :picture_file_name, :type_of_offer, :published, :sell

json.price offer.one_price_int == 0 ? t('.free') : offer.one_price(t('.hourly_price'), t('.weekly_price'), t('.daily_price'))
json.icon offer.sell ? asset_path("sell.png") : asset_path("#{offer.i18n_nature(params[:i18n])}.png")
json.pictureUrl offer.picture_file_name ? offer.picture.url(:medium) : image_url('no-image.png')
