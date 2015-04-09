module SessionHelpers
  def sign_in(email, password)
    visit '/sessions/new'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Sign in'
  end

  def sign_up(email = 'bob@example.com',
              password = 'oranges!',
              password_confirmation = 'oranges!')
    visit '/users/new'
    expect(page.status_code).to eq 200
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end

  def reset_form(email = 'bob@example.com')
    visit '/reset_password'
    expect(page.status_code).to eq 200
    fill_in :email, with: email
    click_button 'Request token'
  end

  def change_form(password = 'apples!',
                  password_confirmation = 'apples!')
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Reset password'
  end
end