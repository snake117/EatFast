module ApplicationHelper
	include Pagy::Frontend

	def nav_link_to(name = nil, options = {}, html_options = {}, &block)
	  if block
	    html_options = options
	    options = name
	    name = block
	  end

	  url = url_for(options)
	  starts_with = html_options.delete(:starts_with)
	  html_options[:class] = Array.wrap(html_options[:class])
	  active_class = html_options.delete(:active_class) || "active"
	  inactive_class = html_options.delete(:inactive_class) || ""

	  active = if (paths = Array.wrap(starts_with)) && paths.present?
	    paths.any? { |path| request.path.start_with?(path) }
	  else
	    request.path == url
	  end

	  classes = active ? active_class : inactive_class
	  html_options[:class] << classes unless classes.empty?

	  html_options.except!(:class) if html_options[:class].empty?

	  return link_to url, html_options, &block if block

	  link_to name, url, html_options
	end


	def mobile_nav_link_to(name = nil, options = {}, html_options = {}, &block)
	  if block
	    html_options = options
	    options = name
	    name = block
	  end

	  url = url_for(options)
	  starts_with = html_options.delete(:starts_with)
	  html_options[:class] = Array.wrap(html_options[:class])
	  active_class = html_options.delete(:mobile_active_class) || "mobile-active"
	  inactive_class = html_options.delete(:inactive_class) || ""

	  active = if (paths = Array.wrap(starts_with)) && paths.present?
	    paths.any? { |path| request.path.start_with?(path) }
	  else
	    request.path == url
	  end

	  classes = active ? active_class : inactive_class
	  html_options[:class] << classes unless classes.empty?

	  html_options.except!(:class) if html_options[:class].empty?

	  return link_to url, html_options, &block if block

	  link_to name, url, html_options
	end

	def price_range_output(num = 2)
		return "$" * num
	end

	def random_asset_image
		full_image_path = Dir[Rails.root.join('app', 'assets', 'images', '*')].sample
		return File.basename(full_image_path)
	end

	def us_states
  [
    ['Alabama', 'AL'],
    ['Alaska', 'AK'],
    ['Arizona', 'AZ'],
    ['Arkansas', 'AR'],
    ['California', 'CA'],
    ['Colorado', 'CO'],
    ['Connecticut', 'CT'],
    ['Delaware', 'DE'],
    ['District of Columbia', 'DC'],
    ['Florida', 'FL'],
    ['Georgia', 'GA'],
    ['Hawaii', 'HI'],
    ['Idaho', 'ID'],
    ['Illinois', 'IL'],
    ['Indiana', 'IN'],
    ['Iowa', 'IA'],
    ['Kansas', 'KS'],
    ['Kentucky', 'KY'],
    ['Louisiana', 'LA'],
    ['Maine', 'ME'],
    ['Maryland', 'MD'],
    ['Massachusetts', 'MA'],
    ['Michigan', 'MI'],
    ['Minnesota', 'MN'],
    ['Mississippi', 'MS'],
    ['Missouri', 'MO'],
    ['Montana', 'MT'],
    ['Nebraska', 'NE'],
    ['Nevada', 'NV'],
    ['New Hampshire', 'NH'],
    ['New Jersey', 'NJ'],
    ['New Mexico', 'NM'],
    ['New York', 'NY'],
    ['North Carolina', 'NC'],
    ['North Dakota', 'ND'],
    ['Ohio', 'OH'],
    ['Oklahoma', 'OK'],
    ['Oregon', 'OR'],
    ['Pennsylvania', 'PA'],
    ['Puerto Rico', 'PR'],
    ['Rhode Island', 'RI'],
    ['South Carolina', 'SC'],
    ['South Dakota', 'SD'],
    ['Tennessee', 'TN'],
    ['Texas', 'TX'],
    ['Utah', 'UT'],
    ['Vermont', 'VT'],
    ['Virginia', 'VA'],
    ['Washington', 'WA'],
    ['West Virginia', 'WV'],
    ['Wisconsin', 'WI'],
    ['Wyoming', 'WY']
  ]
end
end
