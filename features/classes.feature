Feature: Class management
	In order to sell training classes
	As a manager
	I want to manage classes

	Scenario: Add new class
		Given I am on the add new class page
		And I enter new class data
		When I press add
		Then the new class should be displayed