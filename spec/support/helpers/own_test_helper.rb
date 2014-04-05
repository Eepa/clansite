module OwnTestHelper

  def sign_in(credentials)
    visit signin_path
    fill_in('name', with:credentials[:name])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

end
