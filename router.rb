#router.rb

require_relative 'HTMLgenerator.rb'

class Router

		case ARGV[0]
		when "index"
				generator = HtmlGenerator.new
				generator.print_header
				generator.index(ARGV[1])
		when "show"
			generator = HtmlGenerator.new
			generator.print_header
			generator.show(ARGV[1])
		end
	generator.print_footer
	generator.write_to_file
end

Router.new 