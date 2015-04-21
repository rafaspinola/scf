class CourseClassPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @course_class = model
  end

  def index?
    true
  end

  def show?
    true
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    return false if @current_user == @user
    @current_user.admin?
  end

end
