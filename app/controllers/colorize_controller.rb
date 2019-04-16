class ColorizeController < ApplicationController
  def colorize
    input = {
      image: params.fetch("image_url")
    }

    # ================================================================================
    # Your code goes below.
    # ================================================================================

    @original_image_url = params.fetch("image_url")
    
    #holds image to be tagged 
    input = {image: @original_image_url}
    
    #algorithima object that processes data, with my API key
    client = Algorithmia.client(ENV.fetch('ALGORITHMIA_KEY'))
    
    #actual algorithim to run
    algo = client.algo('deeplearning/ColorfulImageColorization/1.1.13')
    
    # result, apply the algorithm to the original image
    result = algo.pipe(input).result
    
    new_link = result["output"]
    
    #Note that this result is in a hash form!! -- we need to extract the URL
    #key is "output", and we need to add https://algorithmia.com/v1/data/ at the beginning
    
    final_url = "https://algorithmia.com/v1/data/" + new_link[7..-1]
    
    @colorized_image_url = final_url

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("colorize_templates/colorize.html.erb")
  end

  def colorize_form
    render("colorize_templates/colorize_form.html.erb")
  end
end
