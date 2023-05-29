require_relative '../db/migrate/01_create_students'
require_relative '../db/migrate/02_add_grade_and_birthdate_to_students'
require_relative '../db/migrate/03_change_datatype_for_birthdate'

describe AddGradeAndBirthdateToStudents do
  before do
    sql = "DROP TABLE IF EXISTS students"
    ActiveRecord::Base.connection.execute(sql)

    # Manually runs the migrations
    CreateStudents.new.change
    AddGradeAndBirthdateToStudents.new.change
    ChangeDatatypeForBirthdate.new.change

    Student.reset_column_information
  end

  it 'has a string birthdate' do
    birthdate = Date.parse("April 5th")
    student = Student.create(name: "Steven", grade: 12, birthdate: birthdate)
    expect(Student.where(birthdate: birthdate).first).to eq(student)
  end
end
