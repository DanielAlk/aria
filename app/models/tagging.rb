class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  validates_uniqueness_of :tag, scope: [:taggable_id, :taggable_type]
end
