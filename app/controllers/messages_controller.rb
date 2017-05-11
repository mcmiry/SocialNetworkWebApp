class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.where('to_user_id = ?', session[:current_user_id])
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    @message.from_user_id = session[:current_user_id]
    @user = User.where('nick = ?', message_params[:to_user_id])
    if @user.blank?
      redirect_to messages_url, notice: 'User must exists.'
    else
      @message.to_user_id = @user.first.id
      @message.status = "Send"

      if @message.save
        redirect_to messages_url
      else
        render :new
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    if Message.destroy(@message.id)
      redirect_to messages_url, notice: 'Message was successfully destroyed.'
    else
      redirect_to messages_url, notice: @message.errors
    end
  end

  def delete
    message = Message.where('id = ?', params[:id]).first
    if Message.destroy(message.id)
      redirect_to messages_url
    else
      redirect_to messages_url, notice: 'Message was not successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:from_user_id, :to_user_id, :subject, :text, :status)
    end
end
