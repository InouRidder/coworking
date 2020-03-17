# frozen_literal_string: true

# Controller in charge of new registrations
class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end

  def create
    @registration = Registrations::CreateService.call(params: strong_params)

    if @registration.persisted?
      redirect_to root_path, notice: "You're on the waiting list!"
    else
      render :new
    end
  end

  private

  def strong_params
    params.require(:registration).permit(:email, :name, :bio, :phone)
  end
end
