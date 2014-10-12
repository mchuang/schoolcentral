class Admin < ActiveRecord::Base
	#Admin has one user object, (as account)
	has_one :user, :as => :account, :dependent => :destroy
end
