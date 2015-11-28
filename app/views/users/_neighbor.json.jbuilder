json.extract! neighbor, :id, :first_name, :description, :picture_file_name

json.picture neighbor.picture_file_name.nil? ? image_url('user_pic-225x225.png') : neighbor.picture.url(:medium)
json.offersInfo neighbor.published_offers.size > 0 ? (neighbor.published_offers.size + " " + t(".offer").pluralize(neighbor.published_offers.size) + t('.published', default: "#{' publiée'.pluralize(neighbor.published_offers.size)}").pluralize(neighbor.published_offers.size)) : t('.no_offer_yet')
json.description neighbor.description
json.first_name neighbor.first_name
json.user_path user_path(neighbor)
