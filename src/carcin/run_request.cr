module Carcin
  class RunRequest
    include JSON::Serializable

    getter language : String
    property version : String?
    getter code : String
    @[JSON::Field(ignore: true)]
    property author_ip : String?

    def initialize(@language, @version, @code, @author_ip)
    end
  end
end
