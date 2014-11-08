class Assignment < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :classroom
  has_many :submissions


  has_one :event, :as => :owner, :dependent => :destroy

  before_validation :default_values, on: :create
  after_create :create_submissions
  after_create :create_event

  validates :teacher,      presence: true
  validates :classroom,    presence: true
  validates :name,         presence: true
  validates :due,          presence: true

  def get_submission(student_id)
    submissions.find_by_student_id(student_id)
  end

  private

  def create_submissions
    classroom.students.each {|s| submissions.create(:student_id => s.id)}
  end

  def create_event
    self.event = Event.create(
        :name => name,
        :description => description,
        :startime => due,
        :endtime => due,
        :classroom_id => classroom_id
    )
  end

  def default_values
    self.max_points ||= 0
  end
end
