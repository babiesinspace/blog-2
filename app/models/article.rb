class Article < ApplicationRecord
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings 

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    #Use given string of tags seperated by commas and split into an array of strings
    #Remove trailing whitespace and downcase to ensure non-repetition 
    #Remove non-unique values
    tag_names = tags_string.split(",").collect{ |string| string.strip.downcase }.uniq 
    
    #Run each tag through the method 'find or create by' to locate existing tags
    #Or create new instances as needed
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    
    #Assign the tags to the article it was sent with
    self.tags = new_or_found_tags
  end  
end
