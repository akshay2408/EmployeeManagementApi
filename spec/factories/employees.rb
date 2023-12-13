FactoryBot.define do
  factory :employee do
    employee_id { '123' }
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'john.doe@example.com' }
    doj { Date.new(2023, 5, 18) }
    salary { 50000.0 }
    phone_numbers { ['1234567890', '9876543210'] }
  end
end
