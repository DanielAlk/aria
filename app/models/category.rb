class Category < ActiveRecord::Base
	extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
	has_ancestry
  has_many :products, :dependent => :restrict_with_error
  has_many :payment_products, :dependent => :restrict_with_error
  has_many :works, :dependent => :restrict_with_error
  before_destroy :abort_if_fixed

	validates_presence_of :title

	def path_to_s
		self.path_ids.join '/'
	end

	def is_not_new_and_has_children?
		!self.new_record? && self.has_children?
	end

	private
		def abort_if_fixed
			self.descendants.each do |c|
				if c.products.present? || c.payment_products.present?
					errors.add 'Categoría', 'No se puede eliminar ya que alguna subcategoría tiene productos asociados.'
					return false
				end
				if c.works.present?
					errors.add 'Categoría', 'No se puede eliminar ya que alguna subcategoría tiene obras asociadas.'
					return false
				end
			end
			return true if !fixed
			errors.add 'Categoría Fija', 'No se puede eliminar esta categoría'
			false
		end

		def should_generate_new_friendly_id?
		  title_changed? && !fixed
		end

		def slug_candidates
		  [
		    :title,
		    [ :title, :id ]
		  ]
		end

end
