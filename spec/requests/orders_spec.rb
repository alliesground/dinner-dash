require 'rails_helper'
require 'support/shared_examples/user_authentication'

RSpec.describe 'OrdersManagement', type: :request do
  describe 'post /orders' do
    it_behaves_like "a user authenticated action",
                    "post orders_path"

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
  end
end
