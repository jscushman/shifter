class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :authenticate_admin, only: [:new, :edit, :create, :update, :destroy]

  # GET /groups
  def index
    @groups = Group.includes(:actives, :inactives)
  end

  # GET /groups/1
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to @group, flash: { success: 'Group was successfully created.' }
    else
      render :new
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      redirect_to @group, flash: { success: 'Group was successfully updated.' }
    else
      render :edit
    end
  end

  # DELETE /groups/1
  def destroy
    if @group.people.size == 0
      @group.destroy
      redirect_to groups_url, flash: { success: 'Group was successfully deleted.' }
    else
      redirect_to :back, flash: { "alert-danger": 'Group is not empty, so cannot be deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name)
    end
end
