class FilePatch
  attr_accessor :path, :replace_with, :bad_md5, :good_md5, :patch_name
  def needs_patch?(site)
    md5 = md5_of_real_file(site)
    if bad_md5 == md5
      return true
    end
    if good_md5 == md5
      return false
    end
    raise "MD5 Doesn't match BAD or GOOD for #{path} in #{site.local_path}"
  end
  def md5_of_real_file(site)
    p = File.join(site.local_path, path)
    return Digest::MD5.hexdigest(File.read(p))
    
  end
  def patch_it(site)
    return unless needs_patch?(site)
    dest = File.join(site.local_path, path)
    src = File.join($program_root, "patch_files", patch_name.underscore, replace_with)
    puts "Patching #{dest}"
    puts "with #{src}"
    FileUtils.cp(src, dest)
    raise "Error copying.  MD5 Doesn't match new one" if md5_of_real_file(site) != good_md5
    puts "File patched"
  end
end
