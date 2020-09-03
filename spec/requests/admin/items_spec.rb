require 'rails_helper'

RSpec.describe 'Admin::ItemsManagement', type: :request do
  let(:admin) do
    Admin.create(
      email: 'admin@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  describe 'get admin/new_items' do
    #it_behaves_like "authenticated action", {get :new}

    it 'returns status 200' do
      get new_admin_item_path
      expect(response).to have_http_status 200
    end
  end

  describe 'item creation' do
    it 'creates an item'
  end
end
