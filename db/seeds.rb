require "faker"

user_data = [
  {
    first_name: "John",
    last_name: "Doe",
    email: "test@kimmel.com",
  },
  {
    first_name: "Jane",
    last_name: "Doe",
    email: "example@kimmel.com",
  },
  {
    first_name: "Jacob",
    last_name: "Haug",
    email: "jacob@kimmel.com",
  },
  {
    first_name: "Mark",
    last_name: "Jones",
    email: "demo@kimmel.com",
  },
  {
    first_name: "Charlie",
    last_name: "Kimmel",
    email: "software@kimmel.com",
  },
  {
    first_name: "Jeremy",
    last_name: "Kimmel",
    email: "development@kimmel.com",
  },
]

admin_role = Role.create!(
  name: "Admin"
)
SyncAbilities.new(admin_role, Abilities).call

user_data.each do |data|
  User.create!(
    role: admin_role,
    email: data[:email],
    password: "Tester12",
    first_name: data[:first_name],
    last_name: data[:last_name],
  )
end
