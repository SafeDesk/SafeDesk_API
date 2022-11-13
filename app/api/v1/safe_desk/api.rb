module SafeDesk
  class API < Grape::API
    # version 'v1', using: :path
    format :json
    prefix 'api'
    version 'v1', using: :path

      mount SafeDesk::ChoresAPI
      mount SafeDesk::HomeworkAPI
      mount SafeDesk::RewardsAPI
      mount SafeDesk::VolunteerAPI
      mount SafeDesk::RewardsAPI

  end
end