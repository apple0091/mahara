@javascript @core @blocktype @blocktype_notes
Feature: Add a note which copies the contents
from an existing note using the "Use content from another note" option

Background:

Given the following "users" exist:
  | username | password | email | firstname | lastname | institution | authname | role |
  | userA | Kupuhipa1 | userA@example.com | Angela | User | mahara | internal | member |
And the following "pages" exist:
  | title | description| ownertype | ownername |
  | Page 1 | Test page 1 | user | userA |

Scenario: Use content from another note (Bug 1710988)
  Given I log in as "userA" with password "Kupuhipa1"
  And I follow "Page 1"
  And I follow "Edit this page"
  And I expand "General" node
  And I follow "Note" in the "div#general" "css_element"
  And I press "Add"
  And I set the following fields to these values:
  | Block title | Note block 1 |
  | Block content | This is a test |
  And I press "Save"
  And I follow "Note" in the "div#general" "css_element"
  And I press "Add"
  And I follow "Use content from another note"
  And I select the radio "Note block 1"
  # Set title after selection as selection updates the title with original one
  And I set the following fields to these values:
  | Block title | Note block 2 |
  And I press "Save"
  And I should see "This is a test" in the block "Note block 2"