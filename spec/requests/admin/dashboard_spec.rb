require 'rails_helper'

RSpec.describe 'Admin::Dashboard', type: :request do
  describe 'access to dashboard' do
    context 'when admin user' do
      let(:admin) do
        Admin.create(
          email: 'admin@test.com',
          password: 'password',
          password_confirmation: 'password'
        )
      end

      it 'allows access' do
        sign_in admin, scope: :admin

        get admin_path

        expect(response).to have_http_status 200
      end
    end

    it 'denies access to non-admin users'

    it 'denies public access' do
      get admin_path
      expect(response).to redirect_to new_admin_session_path
    end
  end
end
