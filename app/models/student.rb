class Student < ActiveRecord::Base
	#student has one user object, (as account)
	has_one :user, :as => :account
end
