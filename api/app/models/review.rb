class Review < ApplicationRecord
  include RecordHelper

  before_save :update_sitter_scores

  belongs_to :sitter

  validates :rating, :sitter, presence: true
  validates :text, length: { minimum: 62 }
  validates :start_date, :end_date, 
    format: { with: /\d{4}-\d{2}-\d{2}/, message: 'YYYY-MM-DD format only' }

  private

  def update_sitter_scores
    # self.sitter.update_scores
  end

end
