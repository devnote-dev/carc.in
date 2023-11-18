require "json"

module Carcin
  class RunPresenter
    include JSON::Serializable

    getter id : String
    getter language : String
    getter version : String?
    getter code : String
    getter stdout : String
    getter stderr : String
    getter exit_code : Int32
    @[JSON::Field(converter: Time::Format.new("%FT%TZ"))]
    getter created_at : Time?
    getter url : String
    getter html_url : String
    getter download_url : String

    def initialize(run : Run)
      @id = Carcin::Base36.encode run.id.not_nil!
      @language = run.language
      @version = run.version
      @code = run.code
      @stdout = run.stdout
      @stderr = run.stderr
      @exit_code = run.exit_code
      @created_at = run.created_at
      @url = "%s/runs/%s" % {Carcin::BASE_URL, @id}
      @html_url = "%s/#/r/%s" % {Carcin::FRONTEND_URL, @id}
      file_extension = Carcin::Runner::RUNNERS[@language].short_name
      @download_url = "%s/runs/%s.%s" % {Carcin::BASE_URL, @id, file_extension}
    end
  end
end
