class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :authenticate_admin, only: [:destroy]

  # GET /people
  def index
    @people = Person.includes(:group)
    @sortedactives = @people.actives.sort_by do |person|
      person.name.split(" ").reverse.join.upcase
    end
    @sortedinactives = @people.inactives.sort_by do |person|
      person.name.split(" ").reverse.join.upcase
    end
  end

  # GET /people/1
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    authenticate_specific_user @person.user
  end

  # POST /people
  def create
    @person = Person.new(person_params)
    @person.user = current_user
    if @person.save
      redirect_to @person, flash: { success: 'Person was successfully created.' }
    else
      render :new
    end
  end

  # PATCH/PUT /people/1
  def update
    authenticate_specific_user @person.user
    if @person.update(person_params)
      redirect_to @person, flash: { success: 'Person was successfully updated.' }
    else
      render :edit
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
    redirect_to people_url, flash: { success: 'Person was successfully destroyed.' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :group_id, :email, :phone, :user_id, :active)
    end
end
