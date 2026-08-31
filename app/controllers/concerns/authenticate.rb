module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end

    def unauthenticated_access_only(**options)
      allow_unauthenticated_access **options
      before_action -> { redirect_to root_path if authenticated? }, **options
    end
  end
end
