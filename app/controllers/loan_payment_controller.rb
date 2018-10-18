class LoanPaymentController < ApplicationController
  def loan_payment
    @apr = params.fetch("annual_percentage_rate").to_f
    @years = params.fetch("number_of_years").to_i
    @principal = params.fetch("principal_value").to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    # we calculate the annual payments first, convert all information to floats and ints, then calculate monthly payments
    
    apr_dec = @apr / 100 #convert into a decimal
    
    monthly_rate = apr_dec / 12
    
    #source: https://en.wikipedia.org/wiki/Mortgage_calculator#Monthly_payment_formula
    monthly_payment = (monthly_rate * @principal) / (1 - (1 + monthly_rate)**(-@years * 12))
    
    @monthly_payment = monthly_payment
    
    render("loan_payment_templates/loan_payment.html.erb")
  end

  def loan_payment_form
    render("loan_payment_templates/loan_payment_form.html.erb")
  end
end
