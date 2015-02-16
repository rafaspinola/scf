class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @subscriptions = Subscription.all
    respond_with(@subscriptions)
  end

  def show
    respond_with(@subscription)
  end

  def new
    @subscription = Subscription.new
    @subscription.participant = Participant.new
    @subscription.company = Company.new
    respond_with(@subscription)
  end

  def edit
    a = @subscription.participant.name
    a = @subscription.company.name unless @subscription.company == nil
    respond_with(@subscription)
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.save
    respond_with(@subscription)
  end

  def update
    @subscription.update(subscription_params)
    respond_with(@subscription)
  end

  def destroy
    @subscription.destroy
    respond_with(@subscription)
  end

  private
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def subscription_params
      params.require(:subscription).permit(:participant_id, :course_class_id, :company_id, :salesman_id, :amount, :amount, company_attributes: [:name, :cnpj, :county_subscription, :address, :neighborhood, :city, :state, :postal_code, :phone, :responsible_name, :responsible_email, :responsible_job_description], participant_attributes: [:name, :cpf, :birthday, :marital_state, :address, :neighborhood, :city, :state, :postal_code, :phone, :cellphone, :email, :profession, :job_description])
    end
end
