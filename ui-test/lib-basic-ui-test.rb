require 'rubygems'
require 'selenium-webdriver'

@@driver = Selenium::WebDriver.for :firefox
@@driver.manage.timeouts.implicit_wait = 10
@@wait = Selenium::WebDriver::Wait.new(:timeout => 10)

def open
	@@driver.get "http://localhost:3000"
end

def close
	@@driver.quit
end

def login(username_input, password_input)
	navBarLogin()
	@@driver.find_element(:id => "new_user") 
	username = @@driver.find_element :id => "username-field"
	password = @@driver.find_element :id => "password-field"

	username.send_keys username_input
	password.send_keys password_input

	loginBtn = @@driver.find_element :id => "login-button"
	loginBtn.click
	@@driver.find_element(:class => "profile-display") 
end

def logout
	logoutBtn =  @@driver.find_element :id => "logout-btn" 
	logoutBtn.click

	@@driver.find_element :class => "jumbotron"
end

def displayById(id)
	item = @@driver.find_element(:id => id)
	return item.displayed?
end

def displayByClass(cls)
	item = @@driver.find_element(:class => cls)
	return item.displayed?
end 

def displayByName(name)
	item = @@driver.find_element(:name => name)
	return item.displayed?
end

def displayByTagName(tag_name , cls )
	item = @@driver.find_element(:tag_name => tag_name, :class =>cls)
	return item.displayed?
end

def findTableItemByContent(id,content)
	table = @@driver.find_element(:id => id)
	body = table.find_element(:tag_name =>"tbody")
	rows = body.find_elements(:tag_name => "tr")
	t = false
	for row in rows
		columns = row.find_elements(:tag_name => "td")
		for column in columns
			p column.text
			if column.text == content
				t = true
			end
		end
	end 
	 
	return t
end

def raiseAssertionError(m)
  puts m
end

def assert(bool, message=nil)
	if !bool
		raiseAssertionError("----- assertion failed!: " + m)
	end
end

def assertNotNil(value)
	assert(value != nil, "value is nil")
end

def assertIdElementExists(id)
	begin 
		@@driver.find_element(:id => id)
	rescue NoSuchElementError
		raiseAssertionError(id + " does not exist")
	end
end

def assertIdElementNotExist(id)
	begin 
		@@driver.find_element(:id => id)
		raiseAssertionError(id + " exists")
	rescue NoSuchElementError
		
	end 
end

def verify(expected, received, message=nil)
	if expected != received
		if message
			raiseAssertionError(message)
		else
			raiseAssertionError("Expected " + expected + " but got " + received)
		end
	end
end