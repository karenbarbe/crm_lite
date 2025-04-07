require './Customer'
require "date"
require 'facets/string/titlecase'
require './utils'

class CRMDatabase
  def initialize
    @customers = []
  end

  OPPORTUNITY_STAGE = [{q: "qualified"}, {f: "follow-up"}, {d: "demo"}, {n: "negotiation"}, {w: "won"}, {l: "lost"}, {u: "unqualified"}]
  CURSOR = Colors.primary("\s\s▁")
  INFO = Colors.primary("░")
  COMPLETE = Colors.primary("█")
  

  def create
    Spacing.line(2)
    puts Colors.primary("Welcome to CRM Lite CLI app!")
    loop do
      Spacing.line(3)
      puts "#{Colors.secondary("░ What would you like to do?")}"
      puts "\t1 to add a new customer"
      puts "\t2 to update a customer"
      puts "\t3 to delete a customer"
      puts "\t4 to view all customers"
      puts "\t5 to exit"
      Spacing.line(1)
      print "#{CURSOR} Enter key: "
      choice = gets.chomp.to_i

      case choice
      when 1
        add_customer
      when 2
        update_customer
      when 3
        delete_customer
      when 4
        view_customers_list
      when 5
        Spacing.line(2)
        puts "#{COMPLETE} #{Colors.primary("See you soon!")}"
        Spacing.line(3)
        break
      else
        print_invalid_option("key")
      end
    end

  end

  private

  def add_customer
    Spacing.line(2)
    puts "#{Colors.secondary("░ Let's add a new customer entry")}"
    Spacing.line(1)
    print "#{CURSOR} Enter company name: "
    company = gets.chomp.downcase.titlecase

    print "#{CURSOR} Enter contact full name: "
    contact = gets.chomp.downcase.titlecase

    print "#{CURSOR} Enter contact email: "
    email = gets.chomp.downcase

    Spacing.line(1)
    list_stage_options
    Spacing.line(1)
    print "#{CURSOR} Enter key: "
    stage_key = gets.chomp.downcase
    stage = check_stage_key(stage_key)

    customer = Customer.new({
      company: company,
      contact: contact,
      email: email,
      stage: stage,
      date_created: Date.today.strftime("%m/%d/%Y")
    })
    @customers.push(customer)

    Spacing.line(2)
    puts "#{COMPLETE} #{Colors.primary("Done! You added:")}"
    puts "#{COMPLETE}"
    puts "#{COMPLETE} id# #{customer.id} | #{company} | #{contact} | #{email} | #{stage}"
    puts "#{COMPLETE}"
    
  end

  def list_stage_options
    puts "#{Colors.secondary("░ Choose customer opportunity stage")}"
    OPPORTUNITY_STAGE.each do |stage|
      stage.each do |key, label|
        puts "\t#{key.upcase} for #{label.capitalize}"
      end
    end
  end

  def check_stage_key(key)
    OPPORTUNITY_STAGE.each do |stage|
      if stage.keys.first.to_s == key
        return stage.values.first.capitalize
      end
    end

    return "Undefined"
  end

  def update_customer
    Spacing.line(2)
    puts "#{Colors.secondary("░ Let's update an existing customer entry")}"
    Spacing.line(1)
    print "#{CURSOR} Enter customer id#: "
    id_to_update = gets.chomp.to_i
    index = find_customer(id_to_update)
    if index != nil
      Spacing.line(2)
      puts "#{Colors.secondary("░ Choose field to update")}"
      puts "\tC for company name"
      puts "\tN for contact full name"
      puts "\tE for contact email"
      puts "\tS for stage"
      Spacing.line(1)
      print "#{CURSOR} Enter key: "
      field = gets.chomp.downcase
      Spacing.line(1)

      case field
      when "c"
        print "#{CURSOR} Enter new company name: "
        new_company = gets.chomp.downcase.titlecase
        @customers[index].company = new_company
      when "n"
        print "#{CURSOR} Enter new contact full name: "
        new_contact = gets.chomp.downcase.titlecase
        @customers[index].contact = new_contact
      when "e"
        print "#{CURSOR} Enter new email: "
        new_email = gets.chomp.downcase
        @customers[index].email= new_email
      when "s"
        list_stage_options
        Spacing.line(1)
        print "#{CURSOR} Enter key: "
        new_stage_key = gets.chomp.downcase
        new_stage = check_stage_key(new_stage_key)
        @customers[index].stage = new_stage
      else
        print_invalid_option("key")
        return
      end

      Spacing.line(2)
      puts "#{COMPLETE} #{Colors.primary("Done! You updated:")}"
      puts "#{COMPLETE}"
      puts "#{COMPLETE} id# #{@customers[index].id} | #{@customers[index].company} | #{@customers[index].contact} | #{@customers[index].email} | #{@customers[index].stage}"
      puts "#{COMPLETE}"
    else
      print_invalid_option("id")
    end
  end

  def delete_customer
    Spacing.line(2)
    puts "#{Colors.secondary("░ Let's delete an existing customer entry")}"
    Spacing.line(1)
    print "#{CURSOR} Enter customer id#: "
    id_to_delete = gets.chomp.to_i
    index = find_customer(id_to_delete)
    if index != nil
      Spacing.line(2)
      puts "#{INFO} #{Colors.primary("You're about to delete:")}"
      puts "#{INFO} #{@customers[index].company} | #{@customers[index].contact} | #{@customers[index].email} | #{@customers[index].stage}"
      Spacing.line(1)
      print "#{CURSOR} Confirm entry delete (YES / NO): "
      choice = gets.chomp.downcase
      if choice == 'yes' || choice == 'y'
        @customers.delete_at(index)
        Spacing.line(2)
        puts "#{COMPLETE} #{Colors.primary("Customer entry was deleted.")}"
      else
        return
      end
    else
      print_invalid_option("id")
    end
  end

  def find_customer(requested_id)
    customer = @customers.find_index { |customer| customer.id == requested_id}
    return customer ? customer : nil
  end

  def view_customers_list
    Spacing.line(2)
    puts "#{COMPLETE} #{Colors.primary("Your current customers")}"
    puts "#{COMPLETE}"
    if @customers.length > 0
      @customers.each {|customer| puts "#{COMPLETE} id# #{customer.id} | #{customer.company} | #{customer.contact} | #{customer.email} | #{customer.stage} | Added #{customer.date_created}"}
      puts "#{COMPLETE}"
    else
      puts "#{COMPLETE} Nothing here yet"
      puts "#{COMPLETE}"
    end

  end

  def print_invalid_option(key)
    Spacing.line(1)
    puts "#{INFO} #{Colors.primary("We couldn't find that #{key}. Please try again.")}"
  end


end
