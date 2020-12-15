class Group < ApplicationRecord
    has_many :concerts, dependent: :destroy
    enum type_group: %w[Girlgroup Boygroup Band]

    def concerts_this_month
       f = []
        d =  self.concerts.map do |c|
            c.date.month
            end 
        d.each do |date|
            f << date if date == Time.now.month
        end  
        f.count
    end

    def last_concert
        concerts.map {|c|c.date}.max
    end

    def most_people
        concerts.map {|c| c.attendance}.max
    end

    def longest_concert
        concerts.map {|c| c.duration}.max
    end

end