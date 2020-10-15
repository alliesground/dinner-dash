FactoryBot.define do
  factory :item do
    transient do
      category { false }
    end

    title {'test item'}
    desc {'this is test item'}
    price {100.00}
    active_for_sale { true }
    images { [] }

    before(:create) do |item, evaluator|
      category = evaluator.category || create(:category)
      item.categories << category
    end
  end
end
