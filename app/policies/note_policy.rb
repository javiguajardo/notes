class NotePolicy < ApplicationPolicy
  def index?
    user.admin? or user.visitor?
  end

  def show?
    user.admin? or user.visitor?
  end

  def new?
    user.admin? or user.visitor?
  end

  def edit?
    user.admin? or user.visitor?
  end

  def create?
    user.admin? or user.visitor?
  end

  def update?
    user.admin? or user.visitor?
  end

  def destroy?
    user.admin? or user.visitor?
  end
end
