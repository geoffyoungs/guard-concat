require 'guard'
require 'guard/guard'
require 'guard/watcher'

module Guard
  class ConcatFilter < Guard

    VERSION = '0.0.6'

    def initialize(watchers=[], opts={})
      @output = "#{opts[:output]}.#{opts[:type]}"
      files = opts[:files].join("|")
      regex = %r{^#{opts[:input_dir]}/(#{files})\.#{opts[:type]}$}
      watcher = ::Guard::Watcher.new regex
      watchers << watcher
      @watchers, @opts = watchers, opts
      super watchers, opts
    end

    def run_on_changes(paths)
      concat
    end

    # The actual concat method
    #
    # scans the :files passed as options
    # supports * and expands them requiring all files in that path/folder

    def concat
      content = ""
      files = []
      @opts[:files].each do |file|
        files += if single? file
          ["#{@opts[:input_dir]}/#{file}.#{@opts[:type]}"]
        else
          expand file
        end
      end
      files.each do |file|
        content << File.read(file)
        content << "\n"
      end

      if @opts[:outputs]
        @opts[:outputs].each do |name|
          output = "#{name}.#{@opts[:type]}"
          local = content
          local = @opts[:filter].call(output, local) if @opts[:filter]
          File.open(output, "w"){ |f| f.write local.strip }
          UI.info "Concatenated #{output}"
        end
      else
        content = @opts[:filter].call(@output, content) if @opts[:filter]
        File.open(@output, "w"){ |f| f.write content.strip }
        UI.info "Concatenated #{@output}"
      end
    end

    def input_dir
      @opts[:input_dir]
    end

    def type
      @opts[:type]
    end


    private

    # handle the star option (*)

    def single?(file)
      file !~ /\*/
    end

    def expand(file)
      path = "#{input_dir}/#{file}.#{type}"
      Dir.glob path
    end

  end
end
