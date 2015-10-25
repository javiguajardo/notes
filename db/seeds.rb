# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# Notebook seeds
Notebook.create(name: 'Default')

# Generate 50 notes.
50.times do |i|
  Note.create(title: Faker::Book.title, content: Faker::Lorem.paragraph, notebook_id: 1)
end

# Role seeds
Role.create(name: 'Admin', key: 'admin', description: 'System administrator that has all privileges.')
Role.create(name: 'Visitor', key: 'visitor', description: 'User that visits the site.')

#User seeds
User.skip_callback(:create, :before, :set_default_role)

User.create(username: 'admin', email: 'admin@example.com', password: 'password',
            password_confirmation: 'password', role: Role.find_by_key('admin'))

User.set_callback(:create, :before, :set_default_role)
