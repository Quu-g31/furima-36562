FactoryBot.define do
  factory :purchase_log_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    municipality { '東京都' }
    address_code { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { 12345678910 }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
