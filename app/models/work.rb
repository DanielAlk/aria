class Work < ActiveRecord::Base
  extend FriendlyId
  include Filterable
  include Tinymce
	friendly_id :slug_candidates, use: :slugged
	belongs_to :category
	has_many :images, -> { order(position: :asc) }, as: :imageable, dependent: :destroy
	has_many :taggings, as: :taggable, dependent: :destroy
	has_many :tags, through: :taggings

	has_attached_file :data_sheet_file
	validates_attachment_content_type :data_sheet_file, content_type: "application/pdf"
	validates_length_of :title, minimum: 5, message: "debe contener al menos 5 caracteres", unless: :hidden?

	tinymce columns: [ :characteristics, :data_sheet, :information ]

	filterable scopes: [ :status, :category, :special ]
	filterable search: [ :title, :characteristics, :data_sheet, :information, :description ]
	filterable order: [ :status, :title, :category, :created_at, :updated_at ]
	filterable labels: {
	  order: {
	    status: 'status', title: 'título', category: 'categoría', created_at: 'creación', updated_at: 'modificación'
	  },
	  scopes: {
	    status: {draft: 'borrador', active: 'activo', paused: 'pausado', deleted: 'eliminado'},
	    special: {is_regular: 'sin marca', is_new: 'nuevo', is_offer: 'oferta'}
	  }
	}

	enum status: [ :draft, :active, :paused, :deleted, :hidden ]
	enum special: [ :is_regular, :is_new, :is_offer ]

	def status_translated
	  {draft: 'Borrador', active: 'Activo', paused: 'Pausado', deleted: 'Eliminado', hidden: 'Destroyed'}[self.status.to_sym]
	end

  def image(size = :thumb)
    self.images.first.item.url(size) rescue "product-imgs/p-#{size}.jpg"
  end

  def destroy
    if self.deleted?
    	super
    else
      self.deleted!
    end
  end

  private
  	def should_generate_new_friendly_id?
  		title_changed?
  	end

  	def slug_candidates
  		[
  			:title,
  			[ :title, :id ]
  		]
  	end
end
