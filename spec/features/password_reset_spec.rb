feature 'Password reset' do

 scenario 'requesting a password reset' do
   user = User.create(email: 'test@test.com', password: 'secret1234',
                      password_confirmation: 'secret1234')
   visit '/users/password/reset'
   fill_in 'Email', with: user.email
   click_button 'Reset password'
   user = User.first(email: user.email)
   expect(user.password_token).not_to be_nil
   expect(page).to have_content 'Check your emails'
 end

 scenario 'resetting password' do
   user = User.first
   user.password_token = 'token'
   user.save

   visit "/users/password/reset/#{user.password_token}"
   expect(page.status_code).to eq 200
   expect(page).to have_content 'Enter a new password'
 end

end
