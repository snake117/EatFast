# frozen_string_literal: true

# This migration comes from acts_as_taggable_on_engine (originally 6)
class AddMissingIndexesOnTaggings < ActiveRecord::Migration[6.0]
  def change
    safety_assured { add_index ActsAsTaggableOn.taggings_table, :tag_id unless index_exists? ActsAsTaggableOn.taggings_table, :tag_id }
    safety_assured { add_index ActsAsTaggableOn.taggings_table, :taggable_id unless index_exists? ActsAsTaggableOn.taggings_table, 
                                                                                 :taggable_id }
    safety_assured { add_index ActsAsTaggableOn.taggings_table, :taggable_type unless index_exists? ActsAsTaggableOn.taggings_table, 
                                                                                   :taggable_type }
    safety_assured { add_index ActsAsTaggableOn.taggings_table, :tagger_id unless index_exists? ActsAsTaggableOn.taggings_table, 
                                                                               :tagger_id }
    safety_assured { add_index ActsAsTaggableOn.taggings_table, :context unless index_exists? ActsAsTaggableOn.taggings_table, :context }

    unless index_exists? ActsAsTaggableOn.taggings_table, %i[tagger_id tagger_type]
      safety_assured { add_index ActsAsTaggableOn.taggings_table, %i[tagger_id tagger_type] }
    end

    unless index_exists? ActsAsTaggableOn.taggings_table, %i[taggable_id taggable_type tagger_id context],
                         name: 'taggings_idy'
      safety_assured { add_index ActsAsTaggableOn.taggings_table, %i[taggable_id taggable_type tagger_id context],
                name: 'taggings_idy' }
    end
  end
end
