class ApplicationController < ActionController::API
  before_action :authorization

  AUTHORIZATION_TOKEN = "E76dyVeBAiFuudXTYVt4zQXB"
  
  NotAuthorized = Class.new(StandardError)
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ApplicationController::NotAuthorized, with: :not_authorized

  private

  def record_not_found(exc)
    render json: { error: "Record not found" }, status: :not_found
  end

  def not_authorized
    render json: { error: "Not Authorized" }, status: :forbidden
  end

  def authorization
    if request.headers["Authorization"].present?
      token = request.headers["Authorization"].split(" ")[1]
      raise ApplicationController::NotAuthorized unless token == "E76dyVeBAiFuudXTYVt4zQXB"
    else
      raise ApplicationController::NotAuthorized
    end
  end
end
