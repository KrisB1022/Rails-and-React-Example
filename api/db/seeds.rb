# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'csv'
include RecordHelper

review_csv_text = File.read(Rails.root.join('lib', 'seeds', 'reviews.csv'))
review_csv = CSV.parse(review_csv_text, headers: true, encoding: 'ISO-8859-1')
review_csv.each do |row|
    owner = Owner.find_by_email(row['owner_email'])

    if owner.blank?
        owner = RecordHelper.create_owner(row)
        dogs = RecordHelper.create_dogs(row['dogs'].split('|'), owner)    
    end
    
    sitter = Sitter.find_by_email(row['sitter_email'])

    if sitter.blank?
        sitter = RecordHelper.create_sitter(row)
    end

    review = Review.where(
        sitter: sitter,
        start_date: row['start_date'],
        end_date: row['end_date']
    )

    if review.blank?
        review = RecordHelper.create_review(row, sitter)
        sitter.stays += 1
        sitter.ratings_total += review.rating
        sitter.ratings_score = RecordHelper.ratings_score(sitter)
        sitter.overall_score = RecordHelper.overall_score(sitter)
        sitter.save
    end

end
