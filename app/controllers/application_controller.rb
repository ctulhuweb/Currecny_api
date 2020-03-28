class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(exc)
    render json: { error: "record not found" }, status: :not_found
  end
end
