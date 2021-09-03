FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    first_name            { 'えお' }
    last_name             { 'あいう' }
    first_name_kana       { 'エオ' }
    last_name_kana        { 'アイウ' }
    birth_day             { '2000/2/2' }
  end
end
