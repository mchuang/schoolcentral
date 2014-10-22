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

  it "email must be unique" do
    FactoryGirl.create(:user, :email => "fake@fake.com")
    expect {
      FactoryGirl.create(:user, :email => "fake@fake.com")
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "identifier can be empty" do
    expect {
      FactoryGirl.create(:user, :identifier => "")
    }.not_to raise_error
  end

  it "identifier must be unique" do
    FactoryGirl.create(:user, :identifier => "fake")
    expect {
      FactoryGirl.create(:user, :identifier => "fake")
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "email and identifier cannot both be empty" do
    expect {
      FactoryGirl.create(:user, :email => "", :identifier => "")
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "password encrypted with bcrypt and correct cost" do
    user = FactoryGirl.create(:user)
    expect(user.encrypted_password).to start_with("$2a$#{User.stretches}$")
  end

  it "can create a user with an admin account associated" do
    account = User.create_account('Admin', {:password=>'password',:password_confirmation=>'password',:identifier=>'admintest'})
    expect(account.user.account_type).to eq('Admin')
    expect(account.user.identifier).to eq('admintest')
    expect(account).to eq(account.user.account)
  end
  
  it "can create a user with a teacher account associated" do
    account = User.create_account('Teacher', {:password=>'password',:password_confirmation=>'password',:identifier=>'teachertest'})
    expect(account.user.account_type).to eq('Teacher')
    expect(account.user.identifier).to eq('teachertest')
    expect(account).to eq(account.user.account)
  end

  it "can create a user with a student account associated" do
    account = User.create_account('Student', {:password=>'password',:password_confirmation=>'password',:identifier=>'studenttest'})
    expect(account.user.account_type).to eq('Student')
    expect(account.user.identifier).to eq('studenttest')
    expect(account).to eq(account.user.account)
  end

end
