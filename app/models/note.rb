# == Schema Information
#
# Table name: notes
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  notebook_id :integer
#  user_id     :integer
#

class Note < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: :notebook, case_sensitive: false}
  validates :content, presence: true
  validates :notebook_id, presence: true
  validates :user_id, presence: true
  
  belongs_to :notebook
  belongs_to :user
  delegate :name, to: :notebook, prefix: true

  def set_note_user(user)
    self.user_id = user.id
  end
end
