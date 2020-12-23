module SpecRequestHelper
    def json_body
        @json_body ||= JSON.parse(response.body, symbolize_names: true)
    end
end