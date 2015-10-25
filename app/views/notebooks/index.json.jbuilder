json.array!(@notebooks) do |notebook|
  json.extract! notebook, :id, :name
  json.url notebook_url(notebook, format: :json)
end
