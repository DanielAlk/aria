module Filterable
  extend ActiveSupport::Concern
  
  module ClassMethods
    attr_reader :filterable_options
    attr_reader :filterable_labels

    def fsearch(search_string)
    	options = filterable_options[:search]
  		return nil if options.blank?
  		sql = ''
  		options.each do |o|
  			sql += o.to_s + ' LIKE :search_string OR '
  		end
			self.where(sql[0...-4], search_string: '%' + search_string + '%')
  	end

  	def forder(filter)
  		way = filter.to_s.slice(/_asc|_desc/).remove('_')
  		property = filter.to_s.remove(/_asc|_desc/)
  		unless self.column_names.include?(property)
  			property = property + '_id'
  		end
  		arguments = {}
  		arguments[property] = way
  		self.order(arguments)
	  end

	  def frange(property, min, max, scoped_value = nil)
	  	options = filterable_options[:range]
	  	property = property.to_sym
	  	scoped = options[property][:scoped].to_sym rescue false
	  	results = self.where(nil)
	  	if scoped_value.present? && scoped.present?
	  		s_arguments = {}
	  		s_arguments[scoped] = scoped_value
	  		results = results.where(s_arguments)
	  	end
	  	arguments = {};
	  	arguments[property] = min.to_i..max.to_i
	  	results.where(arguments)
	  end

    private
	    def filterable(options={})
	    	if @filterable_options.blank?
	    		@filterable_options = options
	    	else
	    		@filterable_options = @filterable_options.merge(options)
	    	end
	    end
	    def filterable_label(options={})
	    	if @filterable_labels.blank?
	    		@filterable_labels = options
	    	else
	    		@filterable_labels = @filterable_labels.merge(options)
	    	end
	    end
  end
end