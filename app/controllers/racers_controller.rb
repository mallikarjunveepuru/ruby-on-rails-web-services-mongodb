class RacersController < ApplicationController
  before_action :set_racer, only: [:show, :edit, :update, :destroy]

  def index
    @racers = Racer.paginate(page: params[:page], per_page: params[:per_page])
  end

  def show
  end

  def new
    @racer = Racer.new
  end

  def edit
  end

  def create
    @racer = Racer.new(racer_params)

    respond_to do |format|
      if @racer.save
        format.html { redirect_to @racer, notice: 'Racer was successfully created.' }
        format.json { render :show, status: :created, location: @racer }
      else
        format.html { render :new }
        format.json { render json: @racer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @racer.update(racer_params)
        format.html { redirect_to @racer, notice: 'Racer was successfully updated.' }
        format.json { render :show, status: :ok, location: @racer }
      else
        format.html { render :edit }
        format.json { render json: @racer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @racer.destroy
    respond_to do |format|
      format.html { redirect_to racers_url, notice: 'Racer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_racer
      @racer = Racer.find(params[:id])
    end

    def racer_params
      params.require(:racer).permit(:number, :first_name, :last_name, :gender, :group, :secs)
    end
end
