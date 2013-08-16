FactoryGirl.define do
  factory :user do
    name      'Juan Perez'
    email     'juan@mi.net'
    password  'secreto'
    password_confirmation  'secreto'
  end
end
