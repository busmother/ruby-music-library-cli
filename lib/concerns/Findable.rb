require "pry"
module Concerns::Findable
    def find_by_name(name)
        self.all.detect{|a| a.name == name}
    end

    def self.create(name)
        new_one = self.new(name)
        @@all << new_one
        new_one
    end

    def self.find_by_name(name)
        @@all.find{|i| i.name == name}
    end

    def find_or_create_by_name(name)
        if self.find_by_name(name) == nil
            self.create(name)
        else
            self.find_by_name(name)
        end
    end
end