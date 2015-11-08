json.array!(@tasks) do |task|
  json.extract! task, :id, :complete, :description
  json.title task.name
  json.start task.deadline_date
end
