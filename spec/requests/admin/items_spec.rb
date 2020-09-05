require 'rails_helper'
require 'support/shared_examples/authentication'

RSpec.describe 'Admin::ItemsManagement', type: :request do
  let(:admin) do
    Admin.create(
      email: 'admin@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  describe 'get admin/new_items' do
    it_behaves_like "an admin authenticated action", 'get new_admin_item_path'

    context 'with authenticated admin' do
      before(:each) { sign_in admin }

      it 'returns status 200' do
        get new_admin_item_path
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'item creation' do
    category = Category.create(name:'test')

    it_behaves_like "an admin authenticated action", "post admin_items_path, params: { item: {title:'test item', desc: 'test desc', price: 0, category_ids: [#{category.id}]} }"

    context 'with authenticated admin' do
      before(:each) { sign_in admin }

      it 'creates an item' do
        expect{  
          post admin_items_path, xhr: true, params: { item: {title: 'test item', desc: 'this is a test item', price: 1000, category_ids: [category.id] } 
        } }.to change(Item, :count).by 1
      end
    end
  end
end
