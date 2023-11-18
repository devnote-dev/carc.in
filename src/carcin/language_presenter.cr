module Carcin
  class LanguagePresenter
    include JSON::Serializable

    getter id : String
    getter name : String
    getter versions : Array(String)

    def initialize(@name, runner)
      @id = runner.short_name
      @versions = runner.versions
    end
  end
end
