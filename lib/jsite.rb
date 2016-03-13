class JSite
  attr_accessor :local_path, :joomla_version
  def initialize(local_path)
    self.local_path = local_path
    run_tests
  end
  def run_tests
    vt = VersionTest.new
    self.joomla_version = vt.test_it(local_path)
  end
  
end
