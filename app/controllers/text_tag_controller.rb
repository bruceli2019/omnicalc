class TextTagController < ApplicationController
  def text_tag
    @text = params.fetch("text")

    # ================================================================================
    # Your code goes below.
    # ================================================================================

    # holds text to be tagged
    input = @text
    
    #holds algorithmia object that processes data, with my API key
    client = Algorithmia.client(ENV.fetch('ALGORITHMIA_KEY'))
    
    #specific algorithm to run
    algo = client.algo('nlp/AutoTag/1.0.1')
    
    #final output of algorithm
    result = algo.pipe(input).result

    @tags = result

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("text_tag_templates/text_tag.html.erb")
  end

  def text_tag_form
    render("text_tag_templates/text_tag_form.html.erb")
  end
end
