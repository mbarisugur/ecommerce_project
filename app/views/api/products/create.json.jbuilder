
unless @product.blank?
  json.product do
    json.id @product.id
    json.name @product.name
    json.description @product.description
    json.quantity @product.quantity
    json.price @product.price

    json.category @product.category
    if ((defined? @product.product_image) && (@product.product_image.filename != nil))
      json.product_image rails_blob_url(@product.product_image)
    end
  end
else
  json.product do
    json.id @entity.id
    json.name @entity.name
    json.description @entity.description
    json.quantity @entity.quantity
    json.price @entity.price

    json.category @entity.category
    if ((defined? @entity.product_image) && (@entity.product_image.filename != nil))
      json.product_image rails_blob_url(@entity.product_image)
    end
  end
end


json.message @message
json.status true