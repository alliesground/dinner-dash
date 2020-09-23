require 'rails_helper'
require 'support/shared_examples/authentication'

RSpec.describe 'Admin::OrdersManagement', type: :request do
  let(:admin) { create(:admin) }

  describe 'get admin/orders' do
    it_behaves_like 'an admin authenticated action', 
                    'get admin_orders_path'

    context 'with authenticated admin' do
      before(:each) { sign_in admin }

      it 'returns status 200' do
        get admin_orders_path
        expect(response).to have_http_status 200
      end
    end
  end

end
