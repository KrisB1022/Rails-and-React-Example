module RecordHelper
    ENGLISH_ALPHA_COUNT = 26

    def create_owner(row)
        owner = Owner.create(
            name: row['owner'],
            phone_number: row['owner_phone_number'],
            email: row['owner_email'],
            image: row['owner_image']
        )
    
        puts "#{owner[:name]} created."
    
        return owner
    end
    
    def create_dogs(dogs, owner)
        result = []
        if dogs
            dogs.each do |dog|
                d = Dog.create(
                    name: dog,
                    owner: owner
                )
                result.push(d)
            end
    
            puts "#{dogs.size} dogs created for #{owner[:name]}"
        end
        
        return result
    end

    def create_review(row, sitter)
        review = Review.create(
            rating: row['rating'],
            text: row['text'],
            sitter: sitter,
            start_date: row['start_date'],
            end_date: row['end_date']
        )
        puts "Review for #{sitter[:name]} was created."

        return review
    end

    def create_sitter(row)
        score = get_sitter_score(row['sitter'])

        sitter = Sitter.create(
            name: row['sitter'],
            phone_number: row['sitter_phone_number'],
            email: row['sitter_email'],
            image: row['sitter_image'],
            stays: 0,
            ratings_total: 0,
            sitter_score: score,
            ratings_score: 0,
            overall_score: score
        )
        return sitter
    end
    
    def sanitize_str(str)
        return str.downcase.gsub(/[^a-z]/, '').split('').uniq
    end
    
    def get_sitter_score(name)
        unique_chars = sanitize_str(name)
        return (ENGLISH_ALPHA_COUNT.to_f / unique_chars.size * 5) / 10
    end

    def get_ratings_score(sitter)
        return sitter.ratings_total / sitter.stays.to_f
    end

    def get_overall_score(sitter)
        if sitter.stays >= 10
            return sitter.ratings_score
        end

        stays = sitter.stays.to_f
        total_score = sitter.sitter_score * stays + sitter.ratings_score * stays

        return (total_score / stays).truncate(2)
    end

end