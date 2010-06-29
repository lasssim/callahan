
#################################
# Authorization Init            #
#################################
#module Authorization
#  class Engine
#    def roles_for (user)
#      [:admin]
#    end
#  end
#end
#
#Role.find_or_create_by_name(:name => "admin")
#Role.find_or_create_by_name(:name => "user")


#################################
# Team Association Init         #
#################################

require 'hpricot'
require 'open-uri'
require 'pp'

URLBASE="http://www.wfdf.org"
MEMBERPART="index.php?page=list_members.php"


wfdf = Association.find_or_create_by_name(:name        => "World Flying Disc Federation",
                                          :abbrevation => "WFDF",
                                          :url         => URLBASE,
                                          :realm       => "INT", 
                                          :owner_id    => 1)


doc  = Hpricot(open("#{URLBASE}/#{MEMBERPART}"))

doc.search("/html/body/table[2]/tr/td[2]/div[1]/table/tr").each do |row|

  if row.attributes["class"] == "heading2"
    puts row.at("td").inner_html.strip
    #type = AssociationType.create(:name => row.at("td").inner_html.strip)
  else
    tmp = row.search("td")
    puts tmp[2].at("a").inner_html.strip
    r = tmp[0].inner_html.strip
    puts "----"
    pp r
    pp I18n.translate(:countries).select { |k, v| v == r }
    next if I18n.translate(:countries).select { |k, v| v == r }.empty?
    assoc = Association.find_or_create_by_name(:realm        => r == "International" ? "INT" : I18n.translate(:countries).select { |k, v| v == r }.first.first.to_s,
                                               :url          => "#{URLBASE}/#{tmp[1].at("a").attributes["href"]}",
                                               :abbrevation  => tmp[1].at("a").inner_html.strip,
                                               :name         => tmp[2].at("a").inner_html.strip,
                                               :owner_id     => 1)
    assoc.move_to_child_of(wfdf)

    if r == "Austria"
      tdoc = Hpricot(open("http://www.frisbeeverband.at/index.php?id=2"))
      tdoc.search("/html/body/div[@id='wrapper']/div[@id='content_wrapper']/div[@id='maincontent']/table/*/*/table/*/*").each do |team|
        break if team.inner_html =~ /alt="Österreichische Golf Clubs"/
        if team.inner_html =~ /<span class="content_ueberschrift">([\w\s\|]*)<\/span>/
          tname = $1
          tmail  = team.search("a[1]").first.attributes['href'].gsub("mailto:", "") unless team.search("a[1]").first.nil?
          turl   = team.search("a[2]").first.attributes['href']                     unless team.search("a[2]").first.nil?
          trealm =$1 if team.inner_html =~ /ort:\s([\w\s]*)/
          puts "  #{tname}"
        
          tassoc = Club.find_or_create_by_name(:realm       => trealm,
                                               :url         => turl, 
                                               :abbrevation => "", 
                                               :name        => tname, 
                                               :owner_id    => 1).move_to_child_of(Association.find_by_realm("AT"))
          
        end
      
      end
   
    end
  end

end

