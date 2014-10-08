class Teacher < ActiveRecord::Base
	# teacher has one user object, (as account)
	has_one :user, :as => :account
end
