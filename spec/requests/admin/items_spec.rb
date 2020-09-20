require 'rails_helper'
require 'support/shared_examples/authentication'

RSpec.describe 'Admin::ItemsManagement', type: :request do
  let(:admin) { create(:admin) }

  let(:image) do
    fixture_file_upload( Rails.root.join('public', 'apple-touch-icon.png'), 
                         'image/png')
  end

  describe 'get admin/new_items' do
    it_behaves_like 'an admin authenticated action', 
                    'get new_admin_item_path'

    context 'with authenticated admin' do
      before(:each) { sign_in admin }

      it 'returns status 200' do
        get new_admin_item_path
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'item creation' do
    it_behaves_like "an admin authenticated action",
                    "post admin_items_path"

    context 'with authenticated admin' do
      before(:each) { sign_in admin }

      before(:each) do
        category = create(:category)

        post admin_items_path, 
             xhr: true, 
             params: { item: attributes_for(:item, 
                                            category_ids: [category.id], 
                                            images: [image]) }
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
    let(:existing_item) { create(:item) }

    it_behaves_like "an admin authenticated action",
                    "put '/admin/items/1'"

    context 'with authenticated admin' do
      before(:each) { sign_in admin }

      context 'with valid data' do
        before(:each) do
          put "/admin/items/#{existing_item.id}",
              xhr: true,
              params: { item: {title: 'updated title'} }
        end

        it 'updates item' do
          existing_item.reload
          expect(existing_item.title).to eq 'updated title'
        end
      end

      context 'with invalid data' do
        before(:each) do
          put "/admin/items/#{existing_item.id}",
              xhr: true,
              params: { item: {title: ''} }
        end

        it 'does not update item' do
          existing_item.reload
          expect(existing_item.title).to eq 'test item'
        end
      end
    end
  end

  describe "delete attached image" do
    let!(:item) { create(:item, images: [image]) }

    context 'with authenticated admin' do
      before(:each) { sign_in admin }

      it 'deletes attached image' do
        expect {
          delete delete_attached_image_admin_items_path(item.images.first.id)
        }.to change{ActiveStorage::Attachment.count}.from(1).to(0)
      end
    end
  end

end
