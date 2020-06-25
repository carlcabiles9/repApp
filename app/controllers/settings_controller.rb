# frozen_string_literal: true

class SettingsController < ApplicationController
  def profile
    @profile = User.find_by_id(current_user)
  end

  def update
    set_profile
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

    private

  def profile_params
    params.require(:profile).permit(:firstname, :surname, :number)
   end
  end
