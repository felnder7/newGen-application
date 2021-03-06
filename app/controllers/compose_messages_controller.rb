class ComposeMessagesController < ApplicationController
  before_action :set_compose_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :current_user_compose_message, only:[:show]
  # GET /compose_messages
  # GET /compose_messages.json
  def index
    @compose_messages = ComposeMessage.all.order('Created_at DESC')
  end

  # GET /compose_messages/1
  # GET /compose_messages/1.json
  def show
  end

  # GET /compose_messages/new
  def new
    @compose_message = current_user.compose_messages.build
  end
  # GET /compose_messages/1/edit
  def edit
  end

  # POST /compose_messages
  # POST /compose_messages.json
  def create
    @compose_message =  current_user.compose_messages.build(compose_message_params)

    respond_to do |format|
      if @compose_message.save
        format.html { redirect_to @compose_message, notice: 'Message was successfully send.' }
        format.json { render :show, status: :created, location: @compose_message }
      else
        format.html { render :new }
        format.json { render json: @compose_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compose_messages/1
  # PATCH/PUT /compose_messages/1.json
  def update
    respond_to do |format|
      if @compose_message.update(compose_message_params)
        format.html { redirect_to @compose_message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @compose_message }
      else
        format.html { render :edit }
        format.json { render json: @compose_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compose_messages/1
  # DELETE /compose_messages/1.json
  def destroy
    @compose_message.destroy
    respond_to do |format|
      format.html { redirect_to compose_messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compose_message
      @compose_message = ComposeMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compose_message_params
      params.require(:compose_message).permit(:recipient, :message)
    end
end


def correct_user # check if the user is authorised to edit,update or destroy the pin
  @compose_message = current_user.compose_messages .find_by(id: params[:id])
  redirect_to compose_messages_path, notice: "Not authorised" if @compose_message.nil?
end


def current_user_compose_message
  if user_signed_in?
   @compose_messages = current_user.compose_messages.order("created_at DESC")
  end
end
