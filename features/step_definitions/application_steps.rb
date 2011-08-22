Given /^I want to apply for a job$/ do
  visit '/'
  # pending # express the regexp above with the code you wish you had
end

When /^I click "([^"]*)"$/ do |arg1|
  click_on 'apply'
end

Then /^the application form should be displayed$/ do
  find('form').should be_visible
end