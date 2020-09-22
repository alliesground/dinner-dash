FactoryBot.define do
  factory :item do
    title {'test item'}
    desc {'this is test item'}
    price {100.00}
    active_for_sale { true }
    images { [] }

    before(:create) do |item|
      category = create(:category)
      item.categories << category
    end
  end
end
