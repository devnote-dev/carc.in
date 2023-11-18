def Process.uid
  LibC.getuid
end

def Process.uid=(uid)
  unless LibC.setuid(uid.to_i32) == 0
    raise Errno.new "Can't switch to user #{uid}"
  end

  uid.to_i32
end
