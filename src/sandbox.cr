require "option_parser"

require "./carcin"
require "./carcin/sandbox/*"

class Process
  def self.uid
    LibC.getuid
  end
end

unless Process.uid == 0
  abort "This command must be run with root permissions."
end

def has_command(command)
  system("which #{command} 2>/dev/null >/dev/null")
end

{"btrfs", "pacstrap", "arch-chroot", "playpen"}.each do |tool|
  unless has_command(tool)
    abort "This command needs the #{tool} tool."
  end
end

fs_type = `df -T #{Carcin::SANDBOX_BASEPATH}`.lines.last.split[1]
unless fs_type == "btrfs"
  abort "#{Carcin::SANDBOX_BASEPATH} must be on a btrfs filesystem."
end

OptionParser.parse do |parser|
  parser.banner = "Build and manage sandboxes"

  parser.on("build LANGUAGE [VERSION]", "build (all) sandboxes") do |lang, _|
    Carcin::Sandbox::BuildCommand.new.execute(lang || "all")
  end

  parser.on("build-base LANGUAGE", "build base chroot") do |lang|
    Carcin::Sandbox::BuildBaseCommand.new.execute lang
  end

  parser.on("build-wrapper LANGUAGE", "(Re)build (all) playpen wrappers") do |lang|
    Carcin::Sandbox::BuildWrapperCommand.new.execute(lang || "all")
  end

  parser.on("rebuild LANGUAGE [VERSION]", "rebuild (all) sandboxes") do |lang, _|
    Carcin::Sandbox::RebuildCommand.new.execute(lang || "all")
  end

  parser.on("update LANGUAGE", "update base chroot and rebuild (all) sandbox bases") do |lang|
    Carcin::Sandbox::UpdateBaseCommand.new.execute lang
  end

  parser.on("drop LANGUAGE [VERSION]", "drop (all) sandboxes") do |lang, _|
    Carcin::Sandbox::DropCommand.new.execute(lang || "all")
  end

  parser.on("drop-base LANGUAGE", "drop base chroot") do |lang|
    Carcin::Sandbox::DropBaseCommand.new.execute lang
  end

  parser.on("gen-whitelist LANGUAGE", "generate new syscall whitelist") do |lang|
    Carcin::Sandbox::GenerateWhitelistCommand.new(true).execute(lang || "all")
  end

  parser.on("-h", "--help", "show help information") { puts parser }
end
