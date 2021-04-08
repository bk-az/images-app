require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: 'mail.bk.az@gmail.com', password: 'testing123') }

  it 'should create a user' do
    expect { subject.save }.to change(User, :count).by(1)
  end

  it 'should destroy the user' do
    subject.save
    expect { subject.destroy }.to change(User, :count).by(-1)
  end

  it 'email is required' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'email must be unique' do
    subject.save
    user = User.new(email: subject.email, password: 'testing123')
    expect(user).to_not be_valid
  end

  it 'password is required' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'should be valid' do
    expect(subject).to be_valid
  end
end
