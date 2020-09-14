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

  let(:image) do
    fixture_file_upload( Rails.root.join('public', 'apple-touch-icon.png'), 
                         'image/png')
  end

  describe 'get admin/new_items' do
    it_behaves_like 'an admin authenticated action', 
                    'get new_admin_item_path', :include_shared => false

    context 'with authenticated admin' do
      before(:each) { sign_in admin }

      it 'returns status 200' do
        get new_admin_item_path
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'item creation' do
    let(:category) { Category.create(name:'test') }

    it_behaves_like "an admin authenticated action", 
                    "post admin_items_path"

    context 'with authenticated admin' do
      before(:each) { sign_in admin }

      before(:each) do
        post admin_items_path, 
             xhr: true, 
             params: { item: { title: 'test item', 
                               desc: 'this is a test item', 
                               price: 1000, 
                               category_ids: [category.id],
                               images: [image] } } 
      end

      it 'creates an item' do
        expect(Item.count).to eq 1
      end

      it 'uploads item images' do
        expect(ActiveStorage::Attachment.count).to eq 1
      end

    end
  end

  describe 'item update' do
    it_behaves_like "an admin authenticated action",
                    "put '/admin/items/1'"

    context 'with authenticated admin' do
      before(:each) { sign_in admin }

      context 'with valid data' do
        let(:category) { Category.create(name:'test') }

        let(:existing_item) do
          Item.create(
            title: 'existing item',
            desc: 'this is existing item',
            price: 1,
            category_ids: [category.id],
            images: [image]
          )
        end

        before(:each) do
          put "/admin/items/#{existing_item.id}",
              xhr: true,
              params: { item: {title: 'updated title',
                               desc: existing_item.desc,
                               price: existing_item.price,
                               category_ids: existing_item.category_ids,
                               images: [image]} }
        end

        it 'updates item' do
          existing_item.reload
          expect(existing_item.title).to eq 'updated title'
        end
      end

      context 'with invalid data' do
        let(:category) { Category.create(name:'test') }

        let(:existing_item) do
          Item.create(
            title: 'existing item',
            desc: 'this is existing item',
            price: 1,
            category_ids: [category.id],
            images: [image]
          )
        end

        it 'does not update item' do
          put "/admin/items/#{existing_item.id}",
              xhr: true,
              params: { item: {title: '',
                               desc: existing_item.desc,
                               price: existing_item.price,
                               category_ids: existing_item.category_ids,
                               images: [image]} }

          existing_item.reload
          expect(existing_item.title).to eq 'existing item'
        end
      end
    end
  end

end
