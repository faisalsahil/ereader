task :Schedule =>:environment do
    puts "=======================   CREATE POSTS =================="
    require 'xmlrpc/client'
    # @date = DateTime.now
    @today_date = Date.today
    @schedulings = Scheduleing.where(:schedule_date=>@today_date)
    @xmlrpc = Xmlrpc.first.path
    if !@schedulings.blank?
        @schedulings.each do |schedule|
            if schedule.author_book.payment_status == "approved"
                post = {
                        'post_title'       => schedule.author_book.title,
                        'post_excerpt'       => 'Post excerpt',
                        'post_content'       => 'Dear' + ' ' + "#{schedule.author_book.name}" + ' ' + 'You subscribe  book with email id ' + ' ' + "#{schedule.author_book.email}" + ' ' + '.' + ' ' +'Book author name' + ' ' + "#{schedule.author_book.author_name}" + ' ' + 'is succeefully posted.' + ' ' + 'Amazone Link is' + ' ' + ' ' + "#{schedule.author_book.amazone_link}" + '.' 
                      }
                      # http://clients.chimpchamp.com/wordpress/xmlrpc.php
                connection = XMLRPC::Client.new2(@xmlrpc)
                result = connection.call('wp.newPost', 1,'admin','admin123',post)              
                puts result
            end
        end
    end    
end  # end of environment
