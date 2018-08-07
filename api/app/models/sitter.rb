class Sitter < ApplicationRecord
    include RecordHelper

    before_create :add_sitter_score
    
    has_many :reviews
    self.per_page = 25

    validates :name, length: { minimum: 2 }
    validates :phone_number, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :email, uniqueness: { message: 'Email aready exists' }

    private

    def add_sitter_score
        score = RecordHelper.get_sitter_score(self.name)
        self.sitter_score = score
        self.overall_score = score
    end

end
