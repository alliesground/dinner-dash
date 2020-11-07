RSpec.shared_examples 'a user authenticated action' do |action|
  it 'requires user authentication' do
    eval action
    expect(response).to redirect_to new_user_session_path
  end
end
