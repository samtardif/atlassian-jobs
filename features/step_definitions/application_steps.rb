Given /^I want to apply for a job$/ do
  # visit '/'
  # pending # express the regexp above with the code you wish you had
end

Then /^I should see the application form$/ do
  page.has_css?('form#jobs-app', :visible => true)
end

Given /^I have a github\.com account$/ do
end

When /^I type "([^"]*)" into "([^"]*)"$/ do |arg1, arg2|
  page.has_css?('form#jobs-app .site', :visible => true)
  within('form#jobs-app .site') do
    fill_in 'url', :with => 'github.com/chrislloyd'
  end
end

Then /^I should see my followers$/ do
  page.has_css?('.site .followers', :visible => true)
end