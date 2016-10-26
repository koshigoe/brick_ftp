module BrickFTP
  module CLI
    class Site < Thor
      desc 'usage', 'Show site usage.'
      def usage
        puts BrickFTP::API::SiteUsage.find.to_json
      end
    end
  end
end
