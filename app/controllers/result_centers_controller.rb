class ResultCentersController < ApplicationController
  before_action :set_result_center, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @result_centers = ResultCenter.all
    respond_with(@result_centers)
  end

  def show
    respond_with(@result_center)
  end

  def new
    @result_center = ResultCenter.new
    respond_with(@result_center)
  end

  def edit
  end

  def create
    @result_center = ResultCenter.new(result_center_params)
    flash[:notice] = 'ResultCenter was successfully created.' if @result_center.save
    respond_with(@result_center)
  end

  def update
    flash[:notice] = 'ResultCenter was successfully updated.' if @result_center.update(result_center_params)
    respond_with(@result_center)
  end

  def destroy
    @result_center.destroy
    respond_with(@result_center)
  end

  private
    def set_result_center
      @result_center = ResultCenter.find(params[:id])
    end

    def result_center_params
      params.require(:result_center).permit(:name)
    end
end
