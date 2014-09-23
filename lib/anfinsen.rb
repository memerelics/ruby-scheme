Dir[File.join(File.dirname(__FILE__), '*.rb')].each{|f| require f }

module Anfinsen
  class Cli
    include Basic

    def self.run(args=[])
      # TODO: args.size.zero? #=> REPL
      raise 'file not found' unless File.exist?(args.first)
      puts new.eval(open(args.first).read)
    end
  end
end
