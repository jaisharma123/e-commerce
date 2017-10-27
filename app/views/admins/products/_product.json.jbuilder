json.extract! product, :id, :name, :description, :price, :size, :color, :created_at, :updated_at
json.url product_url(product, format: :json)
