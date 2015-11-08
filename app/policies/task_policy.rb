class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.tasks.each { |task| task.id })
      end
    end
  end
end