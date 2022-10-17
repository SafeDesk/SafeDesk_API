module SafeDesk
  class API < Grape::API
    # version 'v1', using: :path
    format :json
    prefix 'api'
    version 'v1', using: :path

      mount SafeDesk::ChoresAPI

  end
end