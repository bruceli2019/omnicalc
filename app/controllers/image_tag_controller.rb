class ImageTagController < ApplicationController
  def image_tag
    input = {
      image: params.fetch("image_url")
    }

    # ================================================================================
    # Your code goes below.
    # ================================================================================

    @original_image_url = params.fetch("image_url")
    
    input = {image: @original_image_url}
    
    client = Algorithmia.client(ENV.fetch('ALGORITHMIA_KEY'))
    
    algo = client.algo('deeplearning/IllustrationTagger/0.4.0')
    
    # this returns a hash, we want the one with key "general"
    result = algo.pipe(input).result
    
    @tag_hashes = result["general"]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("image_tag_templates/image_tag.html.erb")
  end

  def image_tag_form
    render("image_tag_templates/image_tag_form.html.erb")
  end
end
