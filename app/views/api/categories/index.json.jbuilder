

json.categories @categories.each do |category|
  json.id category.id
  json.name category.name
end

json.message @message
json.status true