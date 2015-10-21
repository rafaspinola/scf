class PagesController < ApplicationController
  def admin
  end

  def index
  	@payment_documents_to_be_generated = Subscription.payment_documents_to_be_generated.count
  end
end
