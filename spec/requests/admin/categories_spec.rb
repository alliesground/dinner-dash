require 'rails_helper'
require 'support/shared_examples/authentication'

RSpec.describe 'Admin::CategoriesManagement', type: :request do
  let(:admin) { create(:admin) }

  describe 'category creation' do
    it_behaves_like "an admin authenticated action",
                    "post admin_categories_path"

    context 'with authenticated admin' do
      before(:each) { sign_in admin }

      context 'with valid data' do
        it 'creates a category' do
          post admin_categories_path,
               xhr: true,
               params: { category: attributes_for(:category) }
          expect(Category.count).to eq 1
        end
      end
    end
  end
end
