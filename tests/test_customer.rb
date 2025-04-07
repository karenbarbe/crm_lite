require 'minitest/autorun'
require './customer'
require 'date'

class TestCustomer < Minitest::Test
  def test_customer_creation
    
    todays_date = Date.today.strftime("%m/%d/%Y")

    profile = {
      company: "Test Inc",
      contact: "FirstName LastName",
      email: "info@test.com",
      stage: "Qualified",
      date_created: todays_date
    }
    customer = Customer.new(profile)

    assert_equal "Test Inc", customer.company, "Company getter method failed"
    assert_equal "FirstName LastName", customer.contact, "Contact getter method failed"
    assert_equal "info@test.com", customer.email, "Email getter method failed"
    assert_equal "Qualified", customer.stage, "Stage getter method failed"
    assert_equal todays_date, customer.date_created, "Date created getter method failed"
    assert_equal 1, customer.id, "ID assignment failed"
  end


  def test_customer_update

    profile = {
      company: "Previous Inc",
      contact: "PrevFirstName PrevLastName",
      email: "prev@test.com",
      stage: "Demo",
    }

    customer = Customer.new(profile)

    customer.company = "New Test Inc"
    customer.contact = "NewFirstName NewLastName"
    customer.email = "new@test.com"
    customer.stage = "Won"

    assert_equal "New Test Inc", customer.company, "Company setter method failed"
    assert_equal "NewFirstName NewLastName", customer.contact, "Contact setter method failed"
    assert_equal "new@test.com", customer.email, "Email setter method failed"
    assert_equal "Won", customer.stage, "Stage setter method failed"
  end


end
