json.extract! menu_item, :id, :restaurant_id, :category_id, :name, :description, :price, :image, :created_at, :updated_at
json.url menu_item_url(menu_item, format: :json)
json.image url_for(menu_item.image)
