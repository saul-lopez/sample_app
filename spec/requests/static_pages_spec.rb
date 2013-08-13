require 'spec_helper'

describe 'Static pages' do

  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }

  subject { page }

  describe 'Home page' do
    before { visit root_path }

    it { should have_content('Sample App') }
    it { should have_title("#{base_title}") }
    it { should_not have_title('| Home') }
  end

  describe 'Help page' do

    it "should have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end
    it 'should have the right title' do
      visit help_path
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe 'About page' do
    it "should have the content 'About Us'" do
      visit about_path
      expect(page).to have_content('About Us')
    end
    it 'should have the right title' do
      visit about_path
      expect(page).to have_title("#{base_title} | About")
    end
  end
  describe 'Contact page' do
    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end
    it 'should have the title "Contact"' do
      visit contact_path
      expect(page).to have_title("#{base_title} | Contact")
    end
  end

end
