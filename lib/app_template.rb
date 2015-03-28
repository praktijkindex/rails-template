class AppTemplate

  attr_reader :block

  def initialize &block
    @block = block
    call
  end

  def call
    git :init
    instance_eval &block
  end

  def gem *args
    template_context.gem *args
  end

  def copy_files files_root
    Dir["#{files_root}/**/*", "#{files_root}/**/.*"].select{|path| File.file?(path)}.each do |path|
      relative_path = path.sub(%r(^#{files_root}/), "")
      file(relative_path, File.read(path))
    end
  end

  def delete_files file_list
    file_list.each do |path|
      run "rm #{path}"
    end
  end

  def append_to path, text
    open path, "a+" do |file|
      file.puts text
    end
  end

  def source path
    instance_eval File.read(File.expand_path("../app_template/#{path}.rb", __FILE__))
  end

  def commit message
    yield if block_given?
    git add: "-A ."
    git commit: "-m '#{message}'"
  end

  def method_missing(method, *args, &block)
    template_context.send method, *args, &block
  end

  def template_context
    @template_context ||= eval("self", block.binding)
  end
end
