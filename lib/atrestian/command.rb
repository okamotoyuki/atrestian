module Atrestian

  class CommandExecutor

    def initialize
      api_config = Util::load_api_config
      if api_config.nil?
        ApiInfoUpdater.new.update
        api_config = Util::load_api_config
      end
      @apis = ApiInfoTable.new(api_config)
      puts
    end

    def print_api_names
      str = ''
      @apis.keys.sort.each do |key|
        str += "#{key}\n"
      end
      return str.chomp
    end

    def peco(input)
      unless input.nil?
        IO.popen('peco --select-1', 'r+') do |io|
          io.puts(input)
          io.close_write
          return io.gets.chomp
        end
      end
      return nil
    end

    private def print_api_description
      Util::print_red_bold_line(@target_api_info.name) # API name
      puts
      puts "\t#{@target_api_info.description}"
      puts
      Util::print_bold_line "Parameters:"
      puts
      if @target_api_info.params.empty?
        puts "\tNo parameters."
      else
        @target_api_info.params.each do |param|
          puts "\t#{param}"
        end
      end
      puts
      Util::print_bold_line "Sample:"
      puts
      @target_api_info.command.lines.each do |line|
        Util::print_gray_line("#{line}")
      end
    end

    def describe
      target_api_name = peco(print_api_names)
      @target_api_info = @apis.get(target_api_name)
      print_api_description
    end

  end

end
