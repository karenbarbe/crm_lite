class Customer
  attr_accessor :profile
  attr_reader :id

  @@customer_id = 0

  def initialize(profile)
    @profile = profile
    @id = @@customer_id += 1
  end

  def company
    @profile[:company]
  end

  def company=(new_company)
    @profile[:company] = new_company
  end

  def contact
    @profile[:contact]
  end

  def contact=(new_contact)
    @profile[:contact] = new_contact
  end
  
  def email
    @profile[:email]
  end

  def email=(new_email)
    @profile[:email] = new_email
  end

  def stage
    @profile[:stage]
  end

  def stage=(new_stage)
    @profile[:stage] = new_stage
  end

  def date_created
    @profile[:date_created]
  end

 


end
