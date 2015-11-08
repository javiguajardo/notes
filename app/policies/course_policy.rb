class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.courses.each { |course| course.id })
      end
    end
  end
end