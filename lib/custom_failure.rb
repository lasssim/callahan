class CustomFailure < Devise::FailureApp
  include ActionController::UrlWriter
  def respond!
    options = @env['warden.options']
    scope   = options[:scope]
    
    redirect_path = if mapping = Devise.mappings[scope]
      eval("new_#{scope}_session_url(:host => 'secure.domain.com', :protocol => 'https')")
    else
      "/#{default_url}"
    end
    query_string = query_string_for(options)
    store_location!(scope)

    headers = {}
    headers["Location"] = redirect_path
    headers["Location"] << "?" << query_string unless query_string.empty?
    headers["Content-Type"] = 'text/plain'
asdfk    
    puts "-----------------------"
    require 'pp'
    pp options
    pp scope
    puts "-----------------------"

    [302, headers, ["You are being redirected to #{redirect_path}"]]
  end
end


