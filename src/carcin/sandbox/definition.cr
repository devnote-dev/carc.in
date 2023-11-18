module Carcin::Sandbox
  class Definition
    include JSON::Serializable

    getter name : String
    getter versions : Array(String)
    getter split_packages : Array(String)?
    getter binary : String?
    getter dependencies : Array(String)
    getter aur_dependencies : Array(String)
    getter timeout : Int32
    getter memory : Int32?
    getter max_tasks : Int32
    getter allowed_programs : Array(String)
  end
end
