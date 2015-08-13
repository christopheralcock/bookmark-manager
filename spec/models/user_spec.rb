describe User do

  let!(:user) do
    User.create(email: 'test@test.com', password: 'secret1234',
                           password_confirmation: 'secret1234')
  end

  it 'authenticates when given a valid email address and password' do
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user).to eq user
  end

  it 'does not authenticate when given an incorrect password' do
    expect(User.authenticate(user.email, 'wrong_stupid_password')).to be_nil
  end


  feature 'User signs out' do
    before(:each) do
      User.create(email: 'test@test.com',
                  password: 'test',
                  password_confirmation: 'test')
    end

    scenario 'while being signed in' do
      sign_in(email: 'test@test.com', password: 'test')
      click_button 'Sign out'
      expect(page).to have_content('goodbye!') # where does this message go?
      expect(page).not_to have_content('Welcome, test@test.com')
    end
  end

end
