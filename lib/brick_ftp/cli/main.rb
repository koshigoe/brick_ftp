module BrickFTP
  module CLI
    class Main < Thor
      class_option :profile,
                   desc: 'Configuration profile.',
                   default: 'global',
                   type: :string

      class_option :config,
                   desc: 'Path for configuration file.',
                   default: BrickFTP::Configuration::CONFIG_FILE_PATH,
                   type: :string

      def initialize(*args)
        super
        BrickFTP.config = BrickFTP::Configuration.new(profile: options[:profile], config_file_path: options[:config])
      end

      desc 'config COMMAND', 'Manage configuration.'
      subcommand 'config', BrickFTP::CLI::Config

      desc 'site COMMAND', 'Manage site.'
      subcommand 'site', BrickFTP::CLI::Site
    end
  end
end
