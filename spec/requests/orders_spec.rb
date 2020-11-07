require 'rails_helper'

RSpec.describe 'OrdersManagement', type: :request do
  describe 'post /orders' do
    let(:cart) { Cart.create }
    let(:user) { create(:user) }

    context 'with authenticate_user' do
      before { sign_in user }

      before(:each) do
        item1 = create(:item, title: 'item1')
        item2 = create(:item, title: 'item2')

        cart.cart_items.create(
          [{item_id: item1.id},{item_id: item2.id}]
        )

        allow_any_instance_of(ActionDispatch::Request).
          to receive(:session) { { cart_id: cart.id } }

        post orders_path
      end

      it 'creates order' do
        expect(Order.count).to eq 1
      end

      it 'creates associated order_items from cart items' do
        expect(OrderItem.count).to eq 2
      end
    end


    # it 'returns items by category' do
    #   category = create(:category)
    #   item1 = create(:item, title: 'item1', category: category) 
    #   item2 = create(:item, title: 'item2', category: category) 

    #   get items_path,
    #     params: { q: {categories_id_eq: category.id} }

    #   expect(response).to be_successful
    #   expect(response.body).to include("item1")
    #   expect(response.body).to include("item2")
    # end
  end
end
