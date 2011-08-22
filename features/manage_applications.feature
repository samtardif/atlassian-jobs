Feature: Application

  @javscript
  Scenario:
  	Given I want to apply for a job
  	When I go to the home page
  	And I press "apply"
  	Then I should see the application form

  @javascript
  Scenario:
    Given I want to apply for a job
    And   I have a github.com account
    When  I go to the home page
    And   I press "apply"
    And   I type "github.com/chrislloyd" into ".site input[name=url]"
    Then  I should see my followers
