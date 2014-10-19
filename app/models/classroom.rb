class Classroom < ActiveRecord::Base
	#more then one teacher and more then one student per class, but teahcers and
	#students also have more then one class
	has_and_belongs_to_many :teachers
	has_and_belongs_to_many :students


    has_many :attendance

end
