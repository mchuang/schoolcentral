require 'rails_helper'

RSpec.describe User, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it "password and password_confirmation must match" do
    expect {
      FactoryGirl.create(:user,
        :password => "password",
        :password_confirmation => "badpassword"
      )
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "password must be at least 8 characters" do
    expect {
      FactoryGirl.create(:user,
        :password => "bad",
        :password_confirmation => "bad"
      )
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "password must be at most 128 characters" do
    expect {
      FactoryGirl.create(:user,
        :password => "a"*129,
        :password_confirmation => "a"*129
      )
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "email can be empty" do
    expect {
      FactoryGirl.create(:user, :email => "")
    }.not_to raise_error
  end

  it "email can be non-unique" do
    expect {
      FactoryGirl.create(:user, :email => "fake@fake.com")
      FactoryGirl.create(:user, :email => "fake@fake.com")
    }.not_to raise_error
  end

  it "password encrypted with bcrypt and correct cost" do
    user = FactoryGirl.create(:user)
    expect(user.encrypted_password).to start_with("$2a$#{User.stretches}$")
  end
end
