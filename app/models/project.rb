class Project < ApplicationRecord
    has_many :user_projects, dependent: :destroy
    has_many :users, through: :user_projects
    has_many :tasks, dependent: :destroy
    accepts_nested_attributes_for :tasks, reject_if: lambda {|attributes| attributes['name'].blank?}, allow_destroy: true
    accepts_nested_attributes_for :user_projects
    validates :title, :deadline, :objective, presence: true
    validate :deadline_cannot_be_in_the_past
    scope :complete, -> { where(complete: true) }
    scope :incomplete, -> { where(complete: false) }
    scope :due_soon, -> { where("deadline BETWEEN '#{DateTime.now.beginning_of_day}' AND '#{DateTime.now.end_of_day + 7}'")  }

    def deadline_cannot_be_in_the_past
        if deadline.present? && deadline < Date.today
            errors.add(:deadline, "cannot be in the past")
        end
    end

end
