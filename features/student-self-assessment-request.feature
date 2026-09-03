Feature: Student self-assessment request

  As a professor responsible for a class
  I want to request self-assessment only from students who have not yet submitted it
  So that I can charge pending students without resending the request to those who already responded

  Scenario: request self-assessment only from pending students
    Given I am logged in as the professor "Paulo Borba", responsible for the class "ESS 2025.1"
    And "ESS 2025.1" has only the students "Bruno Tavares", "Ana Ribeiro" and "Diego Alves"
    And "Bruno Tavares" has the self-assessment "MA, MPA, MANA" registered in "ESS 2025.1"
    And "Ana Ribeiro" and "Diego Alves" do not have a self-assessment registered in "ESS 2025.1"
    And no student in "ESS 2025.1" has received a self-assessment request today
    And I am on the "Self-assessment status" page of "ESS 2025.1"
    When I request self-assessment from the pending students of "ESS 2025.1"
    Then I remain on the "Self-assessment status" page of "ESS 2025.1"
    And I see a confirmation message that the request was sent to "2" students
    And I see "Ana Ribeiro" with a self-assessment request sent today
    And I see "Diego Alves" with a self-assessment request sent today
    And I do not see "Bruno Tavares" with a self-assessment request sent today
    And I see "Bruno Tavares" in the list of students with self-assessment sent
    And I see the count "1" of students with self-assessment sent