class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:show, :edit, :update, :destroy]

  # GET /relationships
  # GET /relationships.json
  def index
    @relationships = Relationship.where('user1_id = ? AND status = ?', session[:current_user_id], "Accept")
    @relationshipsP = Relationship.where('user2_id = ? AND status = ?', session[:current_user_id], "Pending")
  end

  # GET /relationships/1
  # GET /relationships/1.json
  def show
  end

  # GET /relationships/new
  def new
    @relationship = Relationship.new
  end

  # GET /relationships/1/edit
  def edit
  end

  # POST /relationships
  # POST /relationships.json
  def create
    @relationship = Relationship.new(relationship_params)
    if @relationship.save
      redirect_to @relationship, notice: 'Relationship was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /relationships/1
  # PATCH/PUT /relationships/1.json
  def update
    if @relationship.update(relationship_params)
      redirect_to @relationship, notice: 'Relationship was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /relationships/1
  # DELETE /relationships/1.json
  def destroy
    @relationship.destroy
    redirect_to relationships_url, notice: 'Relationship was successfully destroyed.'
  end

  def friend
    @relationship = Relationship.create(user1_id: session[:current_user_id], user2_id: params[:id], status: "Pending")
    if @relationship.save
      redirect_to relationships_url
    else
      redirect_to relationships_url, notice: 'Friend relationship request was NOT successfully send.'
    end
  end

  def unfriend
    @relationship = Relationship.where(user1_id: session[:current_user_id], user2_id: params[:id]).first

    if Relationship.destroy(@relationship.id)
      redirect_to relationships_path
    else
      redirect_to relationships_path, notice: 'Friend relationship request was NOT successfully deleted.'
    end
  end

  def accept_friend
    @relationship = Relationship.where('user1_id = ? AND user2_id = ? AND status = ?', params[:id], session[:current_user_id], "Pending")

    if @relationship.update(status: "Accept")
      redirect_to relationships_path
    else
      redirect_to relationships_path, notice: 'Something was wrong'
    end
  end

  def deny_friend
    @relationship = Relationship.where('user1_id = ? AND user2_id = ? AND status = ?', params[:id], session[:current_user_id], "Pending").first

    if Relationship.destroy(@relationship.id)
      redirect_to relationships_path
    else
      redirect_to relationships_path, notice: 'Something was wrong'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relationship
      @relationship = Relationship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relationship_params
      params.require(:relationship).permit(:user1_id, :user2_id, :status)
    end
end
