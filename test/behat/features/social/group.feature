@javascript @core @group
Feature: Mahara users can participate in groups
  As a mahara user
  I need to participate in groups

Background:
    Given the following "users" exist:
       | username | password | email | firstname | lastname | institution | authname | role |
       | UserA | Kupuh1pa! | UserA@example.org | Angela | User | mahara | internal | member |
       | UserB | Kupuh1pa! | UserB@example.org | Bob | User | mahara | internal | member |
       | UserC | Kupuh1pa! | UserC@example.org | Cecilia | User | mahara | internal | member |
       | UserD | Kupuh1pa! | UserD@example.org | Dmitri | User | mahara | internal | member |
       | UserE | Kupuh1pa! | UserE@example.org | Evonne | User | mahara | internal | member |
    And the following "groups" exist:
       | name | owner | description | grouptype | open | invitefriends | editroles | submittableto | allowarchives | members | staff |
       | GroupA | UserA | GroupA owned by UserA | standard | ON | ON | all | ON | ON | UserB, UserC | UserD |

Scenario: Join a group
    Given I log in as "UserE" with password "Kupuh1pa!"
    And I choose "Find groups" in "Engage" from main menu
    When I click on "GroupA"
    Then I should see "About"
    When I press "Join this group"
    Then I should see "You are now a group member."

Scenario: Group owner sets up forum
    Given I log in as "UserA" with password "Kupuh1pa!"
    And I follow "GroupA"
    And I follow "Forums (tab)"
    And I click on "New forum"
    And I fill in the following:
    | Title | My new forum title |
    And I fill in "My new forum description" in first editor
    When I press "Save"
    Then I should see "Edit forum"
    And I should see "Delete forum"

Scenario: Verify group Staff can see Edit forum or Delete forum
    Given I log in as "UserD" with password "Kupuh1pa!"
    And I follow "GroupA"
    And I follow "Forums (tab)"
    Then I should see "Unsubscribe" in the "General discussion" row
    And I should see 'Edit "General discussion"' in the "General discussion" row
    And I should see 'Delete "General discussion"' in the "General discussion" row

Scenario: Verify group member can not see Edit forum or Delete forum only New topic and Unsubscribe from forum
    Given I log in as "UserB" with password "Kupuh1pa!"
    And I follow "GroupA"
    And I follow "Forums (tab)"
    Then I should see "Unsubscribe" in the "General discussion" row
    And I should not see 'Edit "General discussion"' in the "General discussion" row
    And I should not see 'Delete "General discussion"' in the "General discussion" row