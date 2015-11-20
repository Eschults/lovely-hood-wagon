json.offers do
  json.array! @offers.sort_by(&:updated_at).reverse.each do |offer|
    json.partial! "offers/offer", offer: offer
  end
end