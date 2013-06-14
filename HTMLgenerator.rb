#htmlgenerator
require 'open-uri'
require 'json'
require 'rubygems'

class HtmlGenerator

	def initialize
		@html_string = ""
	end

	def index(searchterm)
		result_data = retrieve_data("http://lcboapi.com/products?q=#{searchterm}")
		result_data.each do |x|
			@html_string << "
			<h2 class='prod_name'>#{x["name"]}</h2>
			<p class='primary_category'>#{x["primary_category"]}</p>
			<p class='secondary_category'>#{x["secondary_category"]}</p>
			<p class='price'>Price in cents: #{format_price(x["price_in_cents"])}</p>
			<p class='alcoholics_price'>Price in cents per liter of alcohol: #{x["price_per_liter_of_alcohol_in_cents"]}</p>"
		end
	end	

	def show(searchterm)
		result_data = retrieve_data("http://lcboapi.com/products/#{searchterm}")
		@html_string << "
			<h2 class='prod_name'>#{result_data["name"]}</h2>
			<p class='primary_category'>#{result_data["primary_category"]}</p>
			<p class='secondary_category'>#{result_data["secondary_category"]}</p>
			<p class='price'>Price in cents: #{result_data["price_in_cents"]}</p>
			<p class='alcoholics_price'>Price in cents per liter of alcohol: #{result_data["price_per_liter_of_alcohol_in_cents"]}</p>"
	end

	def print_header
		@html_string << "<!DOCTYPE html>\n<head>\n<title>AA's Nightmare</title>\n</head>\n<body>"
	end

	def print_footer
		@html_string << "</body>\n</html>"
	end


	def retrieve_data(url)
		unparsed_data = open(url).read
		result_data = JSON.parse(unparsed_data)["result"]
	end

	def format_price(price)
		price.to_f/100
	end

	def write_to_file
		File.open("LCBO.html", "w") do |x|
			x.write(@html_string)
		end
	end

end



