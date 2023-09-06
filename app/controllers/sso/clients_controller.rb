# app/controllers/sso/clients_controller.rb
module Sso
  class ClientsController < ApplicationController
    before_action :authenticate_user!
    before_action :is_current_user_admin?
    before_action :set_client, only: %i[show edit update destroy]

    def index
      @clients = Client.all
    end

    def show; end

    def new
      @client = Client.new
    end

    def create
      @client = Client.new(client_params)
      if @client.save
        redirect_to sso_client_path(@client), notice: 'Client was successfully created.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @client.update(client_params)
        redirect_to sso_client_path(@client), notice: 'Client was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @client.destroy
      redirect_to sso_clients_url, notice: 'Client was successfully destroyed.'
    end

    private

    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:sso_client).permit(:name, :redirect_uri, :site_url, :token_url, :authorize_url, :user_info_url,
                                         :user_info_fields, :user_info_id_field, :user_info_username_field,
                                         :user_info_email_field, :user_info_first_name_field,
                                         :user_info_last_name_field, :open_id_connect_endpoint)
    end

    def is_current_user_admin?
      current_user.admin?
    end
  end
end
