feature 'User sign in' do

 before :each do
   user = build(:user)


   scenario 'with correct credentials' do
     sign_in(user)
     expect(page).to have_content "Welcome, #{user.email}"
   end
end
 def sign_in(user)
   visit '/sessions/new'
     fill_in :email,                 with: user.email
     fill_in :password,              with: user.password
     click_button 'Sign in'
   end
 end
