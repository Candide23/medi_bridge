# app/controllers/translations_controller.rb
class TranslationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_translation, only: %i[show edit update destroy download]

  def index
    @translations = current_user.translations
  end

  def show
    # renders app/views/translations/show.html.erb
  end

  def download
    # Send raw text as a file, no layout, no respond_to
    send_data @translation.content.to_s,
              filename: "translation_#{@translation.language}_#{Date.current}.txt",
              type: "text/plain",
              disposition: "attachment"
  end

  def new
    @translation = Translation.new
  end

  def edit; end

  def create
    @translation = Translation.new(translation_params)
    if @translation.save
      redirect_to @translation, notice: "Translation was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @translation.update(translation_params)
      redirect_to @translation, notice: "Translation was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @translation.destroy!
    redirect_to translations_path, status: :see_other, notice: "Translation was successfully destroyed."
  end

  private

  def set_translation
    @translation = Translation.find(params[:id])
    unless @translation.health_record.user_id == current_user.id
      redirect_to root_path, alert: "Access denied." and return
    end
  end

  def translation_params
    params.require(:translation).permit(:language, :content, :health_record_id)
  end
end


