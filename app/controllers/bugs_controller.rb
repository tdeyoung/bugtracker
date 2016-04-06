class BugsController < ApplicationController
  respond_to :html, :js

  before_action :set_issue_types
  before_action :set_priorities
  before_action :set_statuses
  before_action :set_bug, only: [:show, :edit, :update, :destroy]
  before_action :all_bugs, only: [:index, :create, :destroy, :update]

  def all_bugs
    @bugs = Bug.all
  end

  # GET /bugs
  # GET /bugs.json
  def index
    @bugs = Bug.all
  end

  # GET /bugs/1
  # GET /bugs/1.json
  def show
  end

  # GET /bugs/new
  def new
    @bug = Bug.new
  end

  # GET /bugs/1/edit
  def edit
  end

  # POST /bugs
  # POST /bugs.json
   def create
     if params[:cancel] == "Cancel"
         respond_to do |format|
             format.js { render action: 'cancel'}
         end
     else
         @bug = Bug.new(bug_params)
         user = User.find(bug_params[:user_id])
         @bug.build_user(:id  => user.id)
         if @bug.save
             @current_bug = @bug
         else
             respond_to do |format|
                 format.js { render action: 'new' }
              end 
          end
      end 
    end
  # def create
  #   @bug = Bug.new(bug_params)
  #   user = User.find(bug_params[:user_id])
  #   @bug.build_user(:id => user.id)
  #   @bug.save!
  #   @current_bug = @bug
  #   @bugs = Bug.all
  # end

  # def create
  #   @bug = Bug.new(bug_params)

  #   respond_to do |format|
  #     if @bug.save
  #       format.html { redirect_to @bug, notice: 'Bug was successfully created.' }
  #       format.json { render :show, status: :created, location: @bug }
  #       user = User.find(bug_params[:user_id])
  #       @bug.build_user(:id => user.id)
  #     else
  #       format.html { render :new }
  #       format.json { render json: @bug.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /bugs/1
  # PATCH/PUT /bugs/1.json
def update
    if params[:cancel] == "Cancel"
        respond_to do |format|
          format.js { render action: 'cancel'}
        end 
    else
        if !@bug.update(bug_params)
            respond_to do |format|
                format.js {render action: 'edit' }
            end
        end 
    end
end

  # def update
  #   @bug.update!(bug_params)
  # end

  # def update
  #   respond_to do |format|
  #     if @bug.update(bug_params)
  #       format.html { redirect_to @bug, notice: 'Bug was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @bug }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @bug.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /bugs/1
  # DELETE /bugs/1.json
  def destroy
    @bug.destroy!
  end

  # def destroy
  #   @bug.destroy
  #   respond_to do |format|
  #     format.html { redirect_to bugs_url, notice: 'Bug was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
    end

    def set_issue_types
      @issue_types = Bug.issue_types
    end

    def set_priorities
      @priorities = Bug.priorities
    end

    def set_statuses
     @statuses = Bug.statuses
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bug_params
      params.require(:bug).permit(:title, :description, :issue_type, :priority, :status, :user_id)
    end
end
