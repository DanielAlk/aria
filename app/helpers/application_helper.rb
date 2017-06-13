module ApplicationHelper
	def root_path
		if admin_signed_in?
			home_path
		else
			super
		end
	end

	def ancestry_options(items, &block)
	  result = []
	  items.map do |item, sub_items|
	    result << [yield(item), item.id]
	    result += ancestry_options(sub_items, &block)
	  end
	  result
	end

	def ancestry_product_categories(items)
	  result = []
	  items.map do |item, sub_items|
	    result << ["#{'-' * item.depth} #{item.title}", products_page_path(item)]
	    result += ancestry_product_categories(sub_items)
	  end
	  result
	end

	def ancestry_work_categories(items)
	  result = []
	  items.map do |item, sub_items|
	    result << ["#{'-' * item.depth} #{item.title}", works_page_path] if item.slug.to_sym == :works
	    result << ["#{'-' * item.depth} #{item.title}", works_page_path(item)] if item.slug.to_sym != :works
	    result += ancestry_work_categories(sub_items)
	  end
	  result
	end
end
