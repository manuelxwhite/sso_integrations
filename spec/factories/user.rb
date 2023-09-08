FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'john.doe@example.com' }
    username { 'johndoe' }
    provider { 'google_oauth2' }
    uid { '123456789' }
    password { 'password' }
  end
end
