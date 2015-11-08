# == Schema Information
#
# Table name: tasks
#
#  id            :integer          not null, primary key
#  name          :string
#  deadline_date :date
#  complete      :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  course_id     :integer
#  description   :text
#

class Task < ActiveRecord::Base
  validates :name, presence: true, uniqueness: {scope: [:user, :course], case_sensitive: false}
  validates :deadline_date, presence: true, format: {with: /\d{4}-\d{2}-\d{2}/,
                                                     message: 'date must have format yyyy-mm-dd'}
  validates :user_id, presence: true
  validates :description, presence: true

  before_validation :format_name

  belongs_to :user
  belongs_to :course

  has_many :notes

  delegate :username, to: :user, prefix: true

  def set_task_user(user)
    self.user_id = user.id
  end

  protected

  def format_name
    self.name = self.name.squish.gsub(' ', '_')
  end
end
