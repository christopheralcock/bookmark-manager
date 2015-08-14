feature 'User signs out' do
  before(:each) do
    User.create(email: 'alice@example.com',
                password: '12345678',
                password_confirmation: '12345678')
  end

  scenario 'while being signed in' do
    user = create(:user)
    sign_in(user)

    click_button 'Sign out'
    expect(page).to have_content('Successful signout is yours!') # where does this message go?
    expect(page).not_to have_content('Welcome, alice@example.com')
  end
end
