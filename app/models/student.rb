class Student < ActiveRecord::Base
	#student has one user object, (as account)
	has_one :user, :as => :account
	#student is a member of many classrooms 
	has_and_belongs_to_many :classroom
end
