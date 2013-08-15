require 'spec_helper'

describe User do

  before { @user = User.new(name: 'Example User', email: 'yo@mi.net') }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe 'When name is not present' do
    before { @user.name = ' ' }
    it { should_not be_valid }
  end

  describe 'When email is not present' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @user.name = 'a' * 51 }
    it { should_not be_valid }
  end

  #subject { @user.name }
  #it { should_not empty }
end
