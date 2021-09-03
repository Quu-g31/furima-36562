FactoryBot.define do
  factory :item do
    name            {Faker::Name.initials}
    describe        {Faker::Lorem.sentence}
    price           {Faker::Lorem.characters(number: 6, min_numeric: 6)}
    category_id     {2}
    item_status_id  {2}
    delivery_fee_id {2}
    prefecture_id   {2}
    send_by_day_id  {2}
    association :user
  end
end