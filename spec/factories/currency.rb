FactoryBot.define do
  factory :currency, class: "Currency" do
    name { Faker::Currency.name }
    rate { BigDecimal("88.7654") }
  end
end