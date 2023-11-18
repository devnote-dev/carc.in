require "json"
require "pg"

module Carcin
  VERSION          = "0.1.0"
  BASE_URL         = ENV["BASE_URL"]? || "https://carc.in"
  FRONTEND_URL     = ENV["FRONTEND_URL"]? || BASE_URL
  SANDBOX_BASEPATH = File.expand_path File.join(__DIR__, "..", "sandboxes")
  @@db : DB::Database?

  def self.db
    @@db ||= PG.connect(ENV["DB"]? || "postgres:///carcin")
  end
end

require "./carcin/*"
