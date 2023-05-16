FactoryBot.define do
  factory :price_check do
    widget { nil }
    barcode { "MyString" }
    price { 1.5 }
    description { "MyString" }
  end
end
