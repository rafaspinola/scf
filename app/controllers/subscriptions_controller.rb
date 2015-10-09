class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

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
    if @subscription.company == nil
      @subscription.company = Company.new
    else
      a = @subscription.company.name
    end
    respond_with(@subscription)
  end

  def create
    @subscription = Subscription.new(subscription_params)
    debugger
    if @subscription.save && @subscription.payment_method_requires_payment_document_input?
      redirect_to(action: :new, controller: :payment_documents, :subscription_id => @subscription.id) 
    else
      respond_with(@subscription)
    end
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
      params.require(:subscription).permit(:participant_id, :course_class_id, :company_id, :salesman_id, :price_id, :retains_iss, :charge_company, :first_payment_date, :observations, :payment_method, company_attributes: [:name, :cnpj, :county_subscription, :address, :neighborhood, :city, :state, :postal_code, :phone, :responsible_name, :responsible_email, :responsible_job_description], participant_attributes: [:name, :cpf, :birthday, :marital_state, :address, :neighborhood, :city, :state, :postal_code, :phone, :cellphone, :email, :profession, :job_description])
    end
end
