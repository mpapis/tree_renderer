=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "date"
require "erb"
require "fileutils"

class TreeRenderer
  attr_reader :template_path, :target_path, :var_binding

  def initialize(template_path, target_path, variables = {})
    @template_path = template_path
    @target_path   = target_path
    @var_binding   = calculate_binding(variables)
  end

  def save
    all_files.each{ |file| parse_and_save(file) }
  end

private

  def calculate_binding(variables)
    case variables
    when Hash
      require "ostruct"
      OpenStruct.new(variables).instance_eval { binding }
    when Binding
      variables
    else
      variables.instance_eval { binding }
    end
  end

  def all_files
    Dir.glob("#{template_path}/**/*", File::FNM_DOTMATCH).reject{|path| File.directory?(path) }.sort
  end

  def parse_and_save(file)
    save_file(
      transform_path(file),
      parse_template(file),
    )
  end

  def save_file(path, content)
    FileUtils.mkdir_p(File.expand_path("..", path))
    File.write(path, content, 0, mode: "w")
  end

  def transform_path(file)
    render(file.sub(template_path, target_path))
  end

  def parse_template(path)
    render(File.read(path))
  end

  def render(content)
    ERB.new(content).result(var_binding)
  end
end
