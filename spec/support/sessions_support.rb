def logout
  visit destroy_user_session_path
end

def login_as user, password = 'password'
  visit user_confirmation_path(:confirmation_token => user.confirmation_token)
  logout
  visit new_user_session_path
  fill_in_fields :user_email => user.email, :user_password => password
  click_button 'Sign in'
end

def confirm_user user
  visit user_confirmation_path(:confirmation_token => user.confirmation_token)
  logout
end