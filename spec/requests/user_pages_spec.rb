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

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end


      describe "after submission" do
        before { click_button submit }

        it { should have_selector('li', "Name can't be blank") }
        it { should have_selector('li', "Email can't be blank") }
        it { should have_selector('li', 'Email is invalid') }
        it { should have_selector('li', "Password can't be blank") }
        it { should have_selector('li', 'Password is too short (minimum is 6 characters)') }

        it { should have_title("Sign Up") }
        it { should have_content('error') }
      end
    end

    describe 'with valid information' do
      let(:user_name) { 'Example User' }
      before do
        fill_in 'Name',          with: user_name
        fill_in 'Email',         with: 'user@example.com'
        fill_in 'Password',      with: 'foobar'
        fill_in 'Confirmation',  with: 'foobar'
      end
      it 'should create a user' do
        expect {click_button submit }.to change(User, :count).by(1)
      end

      describe 'it should redirect to user profile page' do
        before { click_button submit }

        it { should have_selector('h1', user_name) }
        it { should have_selector('h1', full_title(user_name)) }

        # Aparte del texto Welcome, verificar que este se encuentre en un div con la clase:
        # <div class="alert alert-success">Welcome to the Sample App!</div>
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out',    href: signout_path) }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }

        describe 'followed by signout' do
          before { click_link 'Sign out' }
          it { should have_link('Sign in', href: signin_path) }
        end
      end
    end
  end

  describe 'signin' do
    before { visit signin_path }

    describe 'with invalid information' do
      before { click_button 'Sign in' }

      it { should have_title('Sign in') }
      # helper definido en spec/support/utilities.rb :-)
      it { should have_error_message('Invalid') }
    end

    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end
  end
end
