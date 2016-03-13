class JCommand
  self.class_variable_set(:@@command_names, Hash.new)
  def self.command_names
    class_variable_get(:@@command_names)
  end
  def self.command_names= (new_commands)
    class_variable_set(:@@command_names, new_commands)
  end
  def self.command_name(*names)
    names.each do |name|
      self.command_names = self.command_names.merge({name => self})
    end
  end

  def self.has_command?(command_name)
    self.command_names.has_key?(command_name.to_sym)
  end

  def self.get_command(command_name)
    return nil unless self.has_command?(command_name)
    return self.command_names[command_name.to_sym]
  end


end
