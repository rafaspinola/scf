class CourseClassesController < ApplicationController
  before_action :set_course_class, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html, :json

  def index
    @course_classes = CourseClass.index_list
    respond_with(@course_classes)
  end

  def show
    respond_with(@course_class)
  end

  def new
    @course_class = CourseClass.new
    respond_with(@course_class)
  end

  def edit
  end

  def create
    @course_class = CourseClass.new(course_class_params)
    @course_class.save
    respond_with(@course_class)
  end

  def update
    @course_class.update(course_class_params)
    respond_with(@course_class)
  end

  def destroy
    @course_class.destroy
    respond_with(@course_class)
  end

  def prices
    #@prices = Course.joins(:course_classes).where("course_classes.id = ?", params[:id]).first.get_price_list
    cc = CourseClass.find params[:id]
    @prices = cc.course.prices
    respond_with(@prices)
  end

  # def dates
  #   @calendar = CourseClassDate.get_dates_from_list(params[:dates])
  #   render json: @calendar
  # end

  def subscriptions
    @subscriptions = Subscription.where(course_class_id: params[:id])
    respond_with(@subscriptions)
  end

  private
    def set_course_class
      @course_class = CourseClass.find(params[:id])
    end

    def course_class_params
      params.require(:course_class).permit(:course_id, :result_center_id, :city, :address, :start_time, :end_time, :date_list, :identifier, {:trainer_ids => []})
    end
end
