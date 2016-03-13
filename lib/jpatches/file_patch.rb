class FilePatch
  attr_accessor :path, :replace_with, :bad_md5, :good_md5
  def needs_patch?(site)
    p = File.join(site.local_path, path)
    md5 = Digest::MD5.hexdigest(File.read(p))
    if bad_md5 == md5
      return true
    end
    if good_md5 == md5
      return false
    end
    raise "MD5 Doesn't match BAD or GOOD for #{path} in #{site.local_path}"
  end
end
