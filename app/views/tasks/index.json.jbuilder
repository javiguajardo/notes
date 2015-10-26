json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :deadline_date, :complete
  json.url task_url(task, format: :json)
end
