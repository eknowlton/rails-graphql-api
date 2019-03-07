# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

role = Role.create!(
  name: "Admin"
)

SyncAbilities.new(role, Abilities).call

User.create!(
  walter_id: 1,
  intranet_id: 1,
  role: role,
  email: "test@kimmel.com",
  password: "Tester12",
  first_name: "John",
  last_name: "Doe",
  abbreviation: "JAD",
  title: "Software Developer",
  hire_date: "2015/01/01"
)

User.create!(
  walter_id: 2,
  intranet_id: 2,
  role: role,
  email: "example@kimmel.com",
  password: "Tester12",
  first_name: "Jane",
  last_name: "Doe",
  abbreviation: "JBD",
  title: "Quality Assurance",
  hire_date: "2015/01/01"
)
