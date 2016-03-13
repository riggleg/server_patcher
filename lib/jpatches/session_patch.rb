class SessionPatch < JPatch
  command_name :session_patch
  attr_accessor :file_patches
  def initialize
    self.file_patches = Hash.new
    sfp = FilePatch.new
    sfp.path = "libraries/joomla/session/session.php"
    sfp.bad_md5 = "00ebe0c3ec353c82566a2e490c5e5c36"
    sfp.good_md5 = "63651a22d38b69f66959199955c5490c"
    sfp.replace_with = "1.5/libraries/joomla/session/session.php"
    sfp.patch_name = self.class.name
    file_patches_1_5 = [sfp]
    self.file_patches["1.5"] = file_patches_1_5
    self.file_patches["3.3"] = false
  end
  def self.process(site)
    p = self.new
    p.patch(site)
  end
  def patch(site)
    raise "Cannot file patch for version #{site.joomla_version}" unless self.file_patches.has_key?(site.joomla_version.to_s)
    if file_patches[site.joomla_version.to_s] == false
      puts "No patch for #{site.joomla_version} in #{site.local_path}"
      return
    end
    patches = self.file_patches[site.joomla_version.to_s]
    patches.each do |patch|
      puts "For site #{site.local_path}:"
      if patch.needs_patch? site
        puts "Need to patch, but skipping for test"
        #patch.patch_it(site)
      else
        puts "Already patched...skipping"
      end
    end
  end
  
  
end
