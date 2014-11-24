
def editPassword(oldpassword, newpassword)
	pwPanel = @@driver.find_element(:id => "accordion").find_elements(:class => "panel")[3]
	pwPanel.find_element(:tag_name => "a").click
	@@driver.find_element(:id => "user_current_password").send_keys oldpassword
	@@driver.find_element(:id => "user_password").send_keys newpassword
	@@driver.find_element(:id => "user_password_confirmation").send_keys newpassword
	@@driver.find_element(:id => "save-cancel-password").click
end

def getEmail
	emailPanel = @@driver.find_element(:id => "accordion").find_elements(:class => "panel")[4]
	return emailPanel.find_element(:tag_name => "div").find_elements(:tag_name => "div")[1].text
end

def getPhoneNumber
	pnPanel = @@driver.find_element(:id => "accordion").find_elements(:class => "panel")[5]
	return pnPanel.find_element(:tag_name => "div").find_elements(:tag_name => "div")[1].text
end

def getAddress
	addrPanel = @@driver.find_element(:id => "accordion").find_elements(:class => "panel")[6]
	return addrPanel.find_element(:tag_name => "div").find_elements(:tag_name => "div")[1].text
end

def editEmail(email)
	emailPanel = @@driver.find_element(:id => "accordion").find_elements(:class => "panel")[4]
	emailPanel.find_element(:tag_name => "a").click
	@@driver.find_element(:id => "user_email").send_keys email
	@@driver.find_element(:id => "save-cancel-email").click
end

def editPhoneNumber(phoneNumber)
	pnPanel = @@driver.find_element(:id => "accordion").find_elements(:class => "panel")[5]
	pnPanel.find_element(:tag_name => "a").click
	@@driver.find_element(:id => "user_phone_mobile").send_keys phoneNumber
	@@driver.find_element(:id => "save-cancel-phone").click
end

def editAddress(address)
	addrPanel = @@driver.find_element(:id => "accordion").find_elements(:class => "panel")[6]
	addrPanel.find_element(:tag_name => "a").click
	@@driver.find_element(:id => "user_address").send_keys address
	@@driver.find_element(:id => "save-cancel-address").click
end