=begin
Copyright 2016 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "date"
require "erb"
require "fileutils"

# Render a tree of files using ERB
#
# example:
#
#     TreeRenderer.new("/template/path", "/target/path", variables).save
#
class TreeRenderer
  # @return [String] the path to the template directory to be rendered
  attr_reader :template_path

  # @return [String] the target path where to render the template
  attr_reader :target_path

  # @return [Binding] binding for the variables to use for rendering
  attr_reader :var_binding

  # Initialize the paths and variables for rendering
  #
  # @param template_path [String] the path to the template directory to be rendered
  # @param target_path   [String] the target path where to render the template
  # @param variables     [Hash, Object, Binding] the variables to use for rendering
  #
  def initialize(template_path, target_path, variables = {})
    @template_path = template_path
    @target_path   = target_path
    @var_binding   = calculate_binding(variables)
  end

  # Run the rendering process
  def save
    all_files.each{ |file| parse_and_save(file) }
  end

private

  # Take the initialize variables thing and transforms it to Binding
  #
  # @param variables [Hash, Object, Binding] the variables to use for rendering
  # @return          [Binding]               binding for the input variables
  #
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

  # get list of files in the `template_path`
  #
  # @return [Array<String>] list of files in the `template_path` dir
  #
  def all_files
    Dir.glob("#{template_path}/**/*", File::FNM_DOTMATCH).reject{|path| File.directory?(path) }.sort
  end

  # read `file` from `template_path`, render it, amd save it in `target_path`
  #
  # @param file [String] path to file to render
  #
  def parse_and_save(file)
    save_file(
      transform_path(file),
      parse_template(file)
    )
  end

  # write `content` to the given `path`, it will create required directories
  #
  # @param path    [String] the path of file to save to
  # @param content [String] the content to save
  #
  def save_file(path, content)
    FileUtils.mkdir_p(File.expand_path("..", path))
    File.open(path, "w") do |f|
      f.write(content)
    end
  end

  # translates path to `file` from `template_path` to `target_path`
  # it will also render it to replace file names if needed
  #
  # @param file [String] the file name to transform from  `template_path`
  # @return     [String] translated file in `target_path`
  #
  def transform_path(file)
    render(file.sub(template_path, target_path))
  end

  # read and render template from `path`
  #
  # @param path [String] path to file to read
  # @return     [String] rendered content of the file
  #
  def parse_template(path)
    render(File.read(path))
  end

  # render given content
  #
  # @param content [String] the content to render
  # @return        [String] the rendered content
  #
  def render(content)
    ERB.new(content).result(var_binding)
  end
end
