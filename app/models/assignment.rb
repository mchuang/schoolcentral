class Assignment < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :classroom
  has_many :submissions


  has_one :event, :as => :owner, :dependent => :destroy

  before_save  :default_values
  after_create :create_submissions
  after_create :create_event

  validates :teacher_id,   presence: true
  validates :classroom_id, presence: true
  validates :name,         presence: true
  validates :due,          presence: true
  validate :due_in_future

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

  def due_in_future
    if due < Time.zone.now
      errors.add(:due, "due date must be in the future")
    end
  end

  def default_values
    self.max_points ||= 0
  end
end
