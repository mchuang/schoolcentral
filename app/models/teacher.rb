class Teacher < ActiveRecord::Base
	# teacher has one user object, (as account)
	has_one :user, :as => :account
	#teacher is a member of many classrooms 
	has_and_belongs_to_many :classroom
end
