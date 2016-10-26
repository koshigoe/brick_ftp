module BrickFTP
  module CLI
    class Config < Thor
      desc 'get NAME', 'Show specified configuration.'
      def get(name)
        abort 'No such configuration.' unless BrickFTP.config.respond_to?(name)

        puts BrickFTP.config.send(name)
      end

      desc 'set NAME VALUE', 'Set configuration value.'
      def set(name, value)
        abort 'No such configuration.' unless BrickFTP.config.respond_to?("#{name}=")

        BrickFTP.config.send("#{name}=", value)
        BrickFTP.config.save!
      end
    end
  end
end
