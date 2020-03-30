class ApplicationController < ActionController::API
  before_action :authenticate_request

  NotAuthorized = Class.new(StandardError)
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ApplicationController::NotAuthorized, with: :not_authorized

  private

  def record_not_found(exc)
    render json: { error: "Record not found" }, status: :not_found
  end

  def not_authorized
    render json: { error: "Not Authorized" }, status: :unauthorized
  end

  def authenticate_request
    unless AuthorizeApiRequest.call(request.headers)
      raise ApplicationController::NotAuthorized
    end
  end
end
