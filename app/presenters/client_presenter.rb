class ClientPresenter
    def initialize(client)
        @client = client
    end

    def outer_class
        if @client.client_and_secret?
            "inline-flex items-center bg-green-100 text-green-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded-full dark:bg-green-900 dark:text-green-300"
        else
            "inline-flex items-center bg-red-100 text-red-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded-full dark:bg-red-900 dark:text-red-300"
        end
    end

    def inner_class
        if @client.client_and_secret?
            "w-2 h-2 mr-1 bg-green-500 rounded-full"
        else
            "w-2 h-2 mr-1 bg-red-500 rounded-full"
        end
    end

    def status_text
        if @client.client_and_secret?
            "Data Available"
        else
            "Data Missing"
        end
    end
end