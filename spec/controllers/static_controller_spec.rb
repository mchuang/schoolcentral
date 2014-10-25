# @author: jdefond, dkang

require 'rails_helper'

RSpec.describe StaticController, :type => :controller do
  describe "StaticController" do
    it "checks it goes to home" do
      get :home
    end
  end
end
