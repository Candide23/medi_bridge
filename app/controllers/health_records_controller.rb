class HealthRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_health_record, only: %i[show edit update destroy]

  def index
    @health_records = current_user.health_records.order(created_at: :desc)
  end

  def show; end

  def new
    @health_record = current_user.health_records.new
  end

  def create
    @health_record = current_user.health_records.new(health_record_params)
    if @health_record.save
      redirect_to @health_record, notice: "Health record created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @health_record.update(health_record_params)
      redirect_to @health_record, notice: "Health record updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

def destroy
  @health_record = HealthRecord.find(params[:id])
  @health_record.destroy
  
  respond_to do |format|
    format.html { redirect_to health_records_path, notice: 'Record was successfully deleted.' }
    format.json { head :no_content }
  end
end


  private

  def set_health_record
    @health_record = current_user.health_records.find(params[:id])
  end

  def health_record_params
    params.require(:health_record).permit(:record_type, :language, :document)
  end
end
