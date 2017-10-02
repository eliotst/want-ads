# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Person.create(first_name: 'admin', last_name: 'admin',
    user_type: :admin, email: "admin@wanted.org",
    password: "foobar", password_confirmation: "foobar")

project = Project.create(person: admin, title: 'First Project',
    description: 'This is the first project.', state: Project.inactive)

Role.create(title: 'First Role', description: 'This is the first role',
    number_of_people: 2, project: project)
