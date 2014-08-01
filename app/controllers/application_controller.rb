class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exeption|
    render status: :forbidden, html: 'nope'
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Mongoid::Errors::DocumentNotFound, with: :record_not_found

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def http_authenticate
    p 'here'
    authenticate_or_request_with_http_digest do |handle, secret|
      p 'handling update'
      true
    end
  end

  protected
  def record_not_found(exception)
    render status: :not_found, html: 'not found'
  end
end
