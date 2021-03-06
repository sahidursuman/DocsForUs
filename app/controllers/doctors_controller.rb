class DoctorsController < ApplicationController
    helper_method :current_user
    helper_method :states
    helper_method :form_data

  def find
    @our_doctors = Doctor.where("first_name LIKE ? AND last_name LIKE ?", "%#{search_params[:first_name]}%", "%#{search_params[:last_name]}%")
    doctor_args = {first_name: search_params[:first_name], last_name: search_params[:last_name],city: search_params[:city].downcase, state: search_params[:state].downcase}
    @api_doctors=Doctor.search_doctor(doctor_args)
    @show_new_doctor = true
    render "recommendations/add"
  end

  def new
    if current_user
      @doctor = Doctor.new
    else
      flash[:alert] = 'You must be logged in to add a doctor'
      redirect_to login_path
    end
  end

  def create
    @doctor = Doctor.find_or_create_by(doctor_params)
    if !@doctor.save
      errors_route
    else
      @doctor.associate_insurances(insurance_params["uid"])
      save_route
    end
  end

  def index
    @tags = Tag.all.map {|tag| tag.description}
    page = params[:page]
    @q = Doctor.ransack(params[:q])
    @doctors = @q.result.includes(:recommendations, :insurances).page(page).per(10)
  end

  def show
    @doctor = Doctor.find(params[:id])
    if @doctor.recommendations.length > 0
      @tags = Tag.joins(:recommendations).where(recommendations: { doctor: @doctor})
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.remove(current_user.id)
    redirect_to root_path
  end

  def edit
    @doctor = Doctor.find(params[:id])
  end

  def update
    @doctor = Doctor.find(params[:id])
    @doctor.update_attributes(doctor_params)
    redirect_to doctor_path(@doctor)
  end

  private

  def save_route
    if session[:doctor]
      doctor_route
    else
      redirect_to new_recommendation_path(id: @doctor.id)
    end
  end

  def errors_route
    @errors = @doctor.errors.full_messages

    render :new
  end

  def doctor_route
    current_user.doctor = @doctor
    current_user.save
    redirect_to doctor_path(@doctor)
  end

  def search_params
   params.require(:doctor).permit(:first_name, :last_name,:city,:state)
  end

  def insurance_params
    params.require(:doctor).permit(:uid)
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :gender, :email_address, :phone_number, :street, :city, :state, :zipcode, :user_id)
  end

end#end of class
