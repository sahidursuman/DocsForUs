

class DoctorsController < ApplicationController
    include StatesHelper
    include SpecialtyDataHelper
    include HTTParty
    include GendersHelper
  def find
      @states = helpers.states
    if search_params[:first_name] != "" && search_params[:last_name] != ""
      @our_doctors = Doctor.where(first_name: search_params[:first_name], last_name: search_params[:last_name])
      doctor_args = {first_name: search_params[:first_name], last_name: search_params[:last_name],city: search_params[:city].downcase, state: search_params[:state].downcase}

      @api_doctors=Doctor.search_doctor(doctor_args)

      @show_new_doctor = true
      render "recommendations/add"
    end
  end

  def new
    @doctor = Doctor.new
    @states = helpers.states
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      redirect_to new_recommendation_path(id: @doctor.id)
    else
      @errors = @doctor.errors.full_messages
      render :new
    end
  end

  def index
   @insurance = helpers.get_insurance
   @states = helpers.states
   @genders = helpers.genders
   @specialties = helpers.get_specialties + Doctor.select('specialty').distinct.map {|dr| dr.specialty}
   @q = Doctor.ransack(params[:q])
   @doctors = @q.result.includes(:recommendations)
  end

  def show
  end

  private


  def search_params
   params.require(:doctor).permit(:first_name, :last_name,:city,:state)
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :gender, :email_address,:phone_number,:street,:city,:state,:zipcode)
  end
end #end of class
