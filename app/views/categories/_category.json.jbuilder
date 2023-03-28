json.extract! category, :id, :name, :display_name, :ancestry, :ancestry_depth, :children_count, :slug, :created_at, :updated_at
json.url category_url(category, format: :json)
