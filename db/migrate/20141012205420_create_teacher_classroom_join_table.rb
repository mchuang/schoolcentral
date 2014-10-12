class CreateTeacherClassroomJoinTable < ActiveRecord::Migration
  def change
    create_join_table :teachers, :classrooms do |t|
      # t.index [:teacher_id, :classroom_id]
      # t.index [:classroom_id, :teacher_id]
    end
  end
end
