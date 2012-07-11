Rate Limit
======

Filter requests to your controllers, and block bruteforce attacks on your forms.

By limiting the rate of requests, you could, without harming usability:
* prevent password bruteforce on login forms
* prevent user enumeration on password reset forms
* slow significantly site scraping

Features
--------

* Block requests if they exceed a specified rate (blockBy*)
* Add a growing delay before accepting requests (slowBy*)
* Reset the filter if successful use (resetBlockerByKey/resetSlowerByKey)

Code example
------------

```ruby
class HelloController < ApplicationController
  def index
    if RateLimit.slowByIp(request)
      puts "not blocking the page"
    else
      puts "blocking the page"
      render :nothing => true, :status => 403
    end
  end
end
```

