class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  rolify

  has_many :courses, foreign_key: "instructor_id", dependent: :destroy
  has_many :enrollments

  after_create :assign_default_role

  def assign_default_role
    (:student) if roles.empty?
  end

  def course_enroll?(course)
    enrollments.map(&:course).include?(course)
  end
end
