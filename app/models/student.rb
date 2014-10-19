class Student < ActiveRecord::Base
	#student has one user object, (as account)
	has_one :user, :as => :account, :dependent => :destroy
	#student is a member of many classrooms
	has_and_belongs_to_many :classrooms

	has_many :attendance
 	
 	#return list of all teachers in all classrooms
 	def teachers
		classrooms.map {|cls| cls.teachers}.flatten.uniq
	end
end
