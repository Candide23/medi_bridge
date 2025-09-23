class PagesController < ApplicationController
  # NOTE: INDENTATION
    def home
    redirect_to health_records_path if user_signed_in?
  end
end
