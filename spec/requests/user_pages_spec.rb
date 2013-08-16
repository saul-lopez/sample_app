require 'spec_helper'


describe 'User Pages' do
  subject { page }

  describe 'signup page' do
    before { visit signup_path }

    it { should have_content('Sign Up') }
    it { should have_title(full_title('Sign Up')) }
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', user.name) }
    it { should have_title(user.name) }
  end

  describe 'signup' do
    before { visit signup_path }
    let(:submit) { 'Create my account' }

    describe 'wiith invalid information' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end
      it { should have_selector('li', "Name can't be blank") }
      it { should have_selector('li', "Email can't be blank") }
      it { should have_selector('li', "Email is invalid") }
      it { should have_selector('li', "Password can't be blank") }
      it { should have_selector('li', "Password is too short (minimum is 6 characters)") }
    end

    describe 'with valid informatio' do
      before do
        fill_in 'Name',          with: 'Example User'
        fill_in 'Email',         with: 'user@example.com'
        fill_in 'Password',      with: 'foobar'
        fill_in 'Confirmation',  with: 'foobar'
      end
      it 'should create a user' do
        expect {click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
