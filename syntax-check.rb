require 'chef/knife'

module KnifePlugin
  class SyntaxCheck < Chef::Knife

    banner "knife syntax-check"

    option :environments,
      :short => '-e',
      :long => '--environments',
      :boolean => true,
      :description => "Test only environment syntax"
    option :roles,
      :short => '-r',
      :long => '--roles',
      :boolean => true,
      :description => "Test only role syntax"
    option :nodes,
      :short => '-n',
      :long => '--nodes',
      :boolean => true,
      :description => "Test only node syntax"
    option :databags,
      :short => '-D',
      :long => '--databags',
      :boolean => true,
      :description => "Test only databag syntax"
    option :cookbooks,
      :short => '-c',
      :long => '--cookbooks',
      :boolean => true,
      :description => "Test only cookbook syntax"
    option :all,
      :short => '-a',
      :long => '--all',
      :boolean => true,
      :description => "Test syntax of all roles, environments, nodes, databags and cookbooks"

    deps do
      require 'yajl'
      require 'pathname'
    end

    def run
      if config[:roles]
        test_object("roles/*", "role")
      elsif config[:environments]
        test_object("environments/*", "environment")
      elsif config[:nodes]
        test_object("nodes/*", "node")
      elsif config[:databags]
        test_databag("data_bags/*", "data bag")
      elsif config[:cookbooks]
        test_cookbooks()
      elsif config[:all]
        test_object("roles/*", "role")
        test_object("environments/*", "environment")
        test_object("nodes/*", "node")
        test_databag("data_bags/*", "data bag")
        test_cookbooks()
      else
        ui.msg("Usage: knife syntax-check --help")
      end
    end

    # Test all cookbooks
    def test_cookbooks()
      ui.msg("Testing all cookbooks...")
      system("knife cookbook test --all") or raise "Syntax check of all cookbooks failed!"
    end

    # Test object syntax
    def test_object(dirname,type)
      ui.msg("Finding type #{type} to test from #{dirname}")
      check_syntax(dirname,nil,type)
    end

    # Test databag syntax
    def test_databag(dirname, type)
      ui.msg("Finding type #{type} to test from #{dirname}")
      dirs = Dir.glob(dirname).select { |d| File.directory?(d) }
      dirs.each do |directory|
        dir = Pathname.new(directory).basename
        check_syntax("#{directory}/*", dir, type)
      end
    end

    # Common method to test file syntax
    def check_syntax(dirpath, dir = nil, type)
      files = Dir.glob("#{dirpath}").select { |f| File.file?(f) }
      files.each do |file|
        fname = Pathname.new(file).basename
        if ("#{fname}".end_with?('.json'))
          ui.msg("Testing file #{file}")
          json = File.new(file, 'r')
          parser = Yajl::Parser.new
          hash = parser.parse(json)
        elsif("#{fname}".end_with?('.rb'))
          ui.msg("Testing file #{file}")
          system("ruby -c #{file}") or raise "Syntax check of #{file} failed!"
        end
      end
    end

  end
end
