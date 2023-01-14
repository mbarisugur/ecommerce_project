unless @product.blank?
  json.products @product.each do |product|
    json.id product.id
    json.name product.name
    json.description product.description
    json.quantity product.quantity
    json.price product.price

    json.category product.category

    if ((defined? product.product_image) && (product.product_image != nil))
      json.product_image rails_blob_url(product.product_image)
    end
  end
else
  json.products @entity.each do |product|
    json.id product.id
    json.name product.name
    json.description product.description
    json.quantity product.quantity
    json.price product.price

    json.category product.category

    if ((defined? product.product_image) && (product.product_image != nil))
      json.product_image rails_blob_url(product.product_image)
    end
  end
  json.message2 "cacheden geldi"
end

json.message @message
json.status true