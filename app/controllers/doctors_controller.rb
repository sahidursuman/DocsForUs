class DoctorsController < ApplicationController
  def new
  @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      redirect_to doctor_path
    else
      @errors = @doctor.errors.full_messages
      render :new
    end
  end

  def index
  end


  private
  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :gender, :email_address,:phone_number,:street,:city,:state,:zipcode)
  end
end
