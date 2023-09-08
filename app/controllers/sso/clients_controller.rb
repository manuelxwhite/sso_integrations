module Sso
  class ClientsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_sso_client, only: %i[show edit update destroy]

    # GET /sso/clients or /sso/clients.json
    def index
      @sso_clients = Sso::Client.all
      @sso_client = Sso::Client.new
    end

    # GET /sso/clients/1 or /sso/clients/1.json
    def show; end

    # GET /sso/clients/new
    def new
      @sso_client = Sso::Client.new
    end

    # GET /sso/clients/1/edit
    def edit; end

    # POST /sso/clients or /sso/clients.json
    def create
      @sso_client = Sso::Client.new(sso_client_params)

      respond_to do |format|
        if @sso_client.save
          format.html { redirect_to sso_client_url(@sso_client), notice: 'Client was successfully created.' }
          format.json { render :show, status: :created, location: @sso_client }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @sso_client.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /sso/clients/1 or /sso/clients/1.json
    def update
      respond_to do |format|
        if @sso_client.update(sso_client_params)
          format.html { redirect_to sso_client_url(@sso_client), notice: 'Client was successfully updated.' }
          format.json { render :show, status: :ok, location: @sso_client }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @sso_client.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /sso/clients/1 or /sso/clients/1.json
    def destroy
      @sso_client.destroy

      respond_to do |format|
        format.html { redirect_to sso_clients_url, notice: 'Client was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_sso_client
      @sso_client = Sso::Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sso_client_params
      params.require(:sso_client).permit(:name, :redirect_uri, :site_url, :token_url, :authorize_url, :user_info_url,
                                         :user_info_fields, :user_info_id_field, :user_info_username_field,
                                         :user_info_email_field, :user_info_first_name_field,
                                         :user_info_last_name_field, :open_id_connect_endpoint)
    end

    def require_admin
      unless current_user && current_user.admin?
        redirect_to root_path, alert: "You must be an admin to access this page."
      end
    end
  end
end
