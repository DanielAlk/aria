module Filterize
	extend ActiveSupport::Concern

	module ClassMethods
	  attr_reader :filterize_options

	  private
		  def filterize(options={})
		  	if @filterize_options.blank?
		  		@filterize_options = options
		  	else
		  		@filterize_options = @filterize_options.merge(options)
		  	end
		  end
  end

	def filterize
		filterize_options = self.class.filterize_options
		@filterable = params[filterize_options[:param] || :filterable]
		object = filterize_options[:object].to_s.titlecase.constantize rescue false
		object = filterize_options[:object].call(params).to_s.titlecase.constantize rescue false
		object = object || self.class.name.sub('Controller', '').singularize.constantize
		collection = object.where(nil)
		if @filterable.present?
			if @filterable[:scopes].present?
				@filterable[:scopes].keys.each do |key|
					if (scope = @filterable[:scopes][key]).present?
						if object.respond_to? key.to_s.pluralize #is enum
							collection = collection.send(object.send(key.to_s.pluralize).key(scope.to_i))
						elsif object.column_names.include?(key.to_s + '_id')
							collection = collection.where(key.to_s + '_id' => scope)
						else
							collection = collection.where(key => scope)
						end
					end
				end
			end
			collection = collection.fsearch @filterable[:search] if @filterable[:search].present?
			collection = collection.forder @filterable[:order] if @filterable[:order].present?
			collection = collection.joins(@filterable[:joins].to_sym).distinct if @filterable[:joins].present?
			if @filterable[:range].present?
				@filterable[:range].keys.each do |key|
					range = @filterable[:range][key]
					collection = collection.frange(key, range[:min], range[:max]) if range[:min].present? || range[:max].present?
				end
			end
		end
		if (defaults = filterize_options).present?
			if (order = defaults[:order]).present?
				collection = collection.forder order
			end
			if (scope = defaults[:scope]).present?
				collection = collection.send(scope.to_s)
			end
			if (exclude = defaults[:exclude]).present? && (defaults[:exclude_if].blank? || defaults[:exclude_if].call(@filterable))
				collection = collection.where.not(exclude)
			end
		end
		instance_variable_set('@' + object.name.pluralize.downcase, collection)
	end
end