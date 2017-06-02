json.array!(@works) do |work|
  json.extract! work, :id, :title, :status, :special, :category_id, :description, :characteristics, :data_sheet, :information, :external_link
  json.url work_url(work, format: :json)
end
