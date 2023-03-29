json.extract! restaurant, :id, :user_id, :category_id, :name, :description, :price_range, :claimed, :email, :phone, :website, :hours, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
