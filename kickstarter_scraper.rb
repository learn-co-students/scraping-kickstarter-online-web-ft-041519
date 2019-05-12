
require 'nokogiri'
require "pry"

def create_project_hash
  html = File.read('fixtures/kickstarter.html')     #open the file
  kickstarter = Nokogiri::HTML(html)                #directory where data is kept for tests
  #binding.pry
  
  projects = {}
  
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {                    #forgot what this means projects[title] include?
      
      #each project title is a key, and the value is another hash with each of our other data points as keys.
      
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i        #removes the percent funded sign and turns it into an interger - no string
    }
  end
 
  # return the projects hash
  
  projects
end


#create_project_hash

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

# image link: project.css("div.project-thumbnail a img").attribute("src").value  
#an img tag in html is considered to have a source attribute ..You can use the .attribute method on a Nokogiri element to grab the value of that attribute.