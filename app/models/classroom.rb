class Classroom < ActiveRecord::Base
	#more then one teacher and more then one student per class, but teahcers and
	#students also have more then one class
	has_and_belongs_to_many :teacher
	has_and_belongs_to_many :student
end
