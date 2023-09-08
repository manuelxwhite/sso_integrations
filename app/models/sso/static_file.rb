module Sso
  class StaticFile
    def self.save_clients_yml
      clients_data = Sso::Client.all.map { |client| client_data_hash(client) }
      File.open("#{Rails.root}/config/sso_clients.yml", 'w') { |f| f.write(clients_data.to_yaml) }
    end

    def self.client_data_hash(client)
      {
        name: client.name,
        data: {
          client_id: client.id,
          redirect_uri: client.redirect_uri,
          issuer: client.open_id_connect_endpoint,
          client_options: client_options_hash(client)
        }
      }
    end

    def self.client_options_hash(client)
      {
        site: client.site_url,
        redirect_uri: client.redirect_uri,
        authorization_endpoint: client.authorize_url,
        token_endpoint: client.token_url,
        user_info_endpoint: client.user_info_url
      }
    end
  end
end
