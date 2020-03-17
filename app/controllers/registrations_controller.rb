# frozen_literal_string: true

# Controller in charge of new registrations
class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(strong_params)

    if Registrations::CreateService.call(@registration)
      redirect_to root_path, notice: 'Succesfully created a registration'
    else
      render :new
    end
  end

  private

  def strong_params
    params.require(:registration).permit(:email, :name, :bio, :phone)
  end
end
