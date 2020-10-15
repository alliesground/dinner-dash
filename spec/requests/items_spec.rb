require 'rails_helper'

RSpec.describe 'ItemsManagement', type: :request do
  describe 'get /items' do
    it 'returns items by category' do
      category = create(:category)
      item1 = create(:item, title: 'item1', category: category) 
      item2 = create(:item, title: 'item2', category: category) 

      get items_path,
          params: { q: {categories_id_eq: 1} }

      expect(response).to be_successful
      expect(response.body).to include("item1")
      expect(response.body).to include("item2")
    end
  end
end
