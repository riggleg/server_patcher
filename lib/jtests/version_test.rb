class VersionTest < JTest
  attr_accessor :path
  def test_it(path)
    self.path = path
    if is_v3?
      puts read_v3_version
      return read_v3_version
    end
    if is_v15?
      puts read_v15_version
      return read_v15_version
    end
    
    raise "Version not found for #{path}"
    
  end
  def read_v3_version
    version_file = File.read(v3_version_file_path)
    r_release = /\$RELEASE\s*=\s*'([^']*)';/i
    return version_file.scan(r_release)[0][0]
  end
  def v3_version_file_path
    File.join(path, "libraries", "cms", "version", "version.php")
  end
  def is_v3?
    return File.exist?(v3_version_file_path)
  end
  def v15_version_file_path
    File.join(path, "libraries", "joomla", "version.php")
  end
  def is_v15?
    File.exist?(v15_version_file_path)
  end
  def read_v15_version
    version_file = File.read(v15_version_file_path)
    r_release = /\$RELEASE\s*=\s*'([^']*)';/i
    return version_file.scan(r_release)[0][0]
  end
end
