module FmHelpers
  def login(login, password)
    visit new_user_session_path
    if has_link? 'Sign out'
      click_link 'Sign out'
    end
    visit new_user_session_path
    expect(page).to have_content 'Sign in'
    fill_in 'Login', :with => login
    fill_in 'Password', :with => password
    click_button 'Sign in'
    expect(page).to have_content 'Sign out ' + login
  end

  def create_car(name, make, model, rego, state, odo, location)
    login('fm.manager', 'fm.manager')
    visit cars_path
    click_link 'new car'
    expect(page).to have_content 'Add new car'
    fill_in 'Name', :with => name
    fill_in 'Make', :with => make
    fill_in 'Model', :with => model
    fill_in 'Rego', :with => rego
    fill_in 'State', :with => state
    fill_in 'Initial Odometer reading', :with => odo
    fill_in 'Initial location', :with => location
    click_button 'Create Car'
    visit cars_path
    expect(page).to have_content name
    click_link 'Sign out'
  end
end
