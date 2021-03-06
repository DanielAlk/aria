json.array!(@articles) do |article|
  json.extract! article, :id, :shape, :status, :title, :subtitle, :description, :text, :link, :link_title, :link_external, :image, :position, :slug
  json.url article_url(article, format: :json)
end
