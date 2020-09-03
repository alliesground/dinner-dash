RSpec.shared_examples 'an admin authenticated action' do |action|
  it 'requires admin authentication' do
    eval action
    expect(response).to redirect_to new_admin_session_path
  end
end
