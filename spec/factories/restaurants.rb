FactoryBot.define do

  factory :restaurant do
    sequence(:email) { |n| "a#{n}@a.a" }
    password { "000000" }
    name { "テスト店" }
    restaurant_image_id { "" }
    introduction { "" }
    postal_code { "0000000" }
    phone_number { "00000000000" }
    corporate { "a@a.a" }
    twitter { "" }
    facebook { "" }
    instagram { "" }
    completion_message { "" }
    prefecture { "" }
    city { "" }
    street { "" }
    building { "" }
  end

end
