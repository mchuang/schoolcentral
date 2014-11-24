require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
	before(:each) do
    	@student0 = FactoryGirl.create(:student_user, email: "", identifier: "student0")
	end

end
