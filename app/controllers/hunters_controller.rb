class HuntersController < ApplicationController
  skip_before_action :require_hunter, only: [:new, :create]

  def new
    @hunter = Hunter.new
  end

  def create
    @hunter = Hunter.new(hunter_params)
    respond_to do |format|
      if verify_recaptcha(model: @hunter) && @hunter.save
        self.current_hunter = @hunter
        flash[:notice] = 'Welcome to Mousehunter Tracker'
        format.js { render js: "Turbolinks.visit('/')" }
        format.html { redirect_to profile_path }
      else
        format.js { render json: @hunter.errors, status: :unprocessable_entity }
        format.html { render 'new' }
      end
    end and return
  end

  def show
    @last_record = current_hunter.profile_records.last
  end

  def progress
    progress_attrs = [:gold,:points,:event_breeds_total,:event_breeds_caught, :breeds_caught, :breeds_total, :created_at, :location]
    @data = current_hunter.profile_records.select(progress_attrs).map{|pr| pr.attributes.merge({
      created_js_time: pr.created_js_time,
      location_image: pr.location_image
    })}
    respond_to do |format|
      format.json { render json: @data.to_json }
      format.html { redirect_to profile_path }
    end
  end

  def team
    team_attrs = [:gold,:points,:event_breeds_total,:event_breeds_caught, :breeds_caught, :breeds_total, :created_at, :location]

    @data = current_hunter.team_members.map { |tm|
      {
        id: tm.id,
        name: tm.name,
        records: tm.profile_records.select(team_attrs).map{|pr| pr.attributes.merge({created_js_time: pr.created_js_time })}
      }
    }
    respond_to do |format|
      format.json { render json: @data.to_json }
      format.html { redirect_to profile_path }
    end
  end

private
  def hunter_params
    p = params.require(:hunter).permit(:email, :password, :name, :password_confirmation, :profile_id)
  end
end

