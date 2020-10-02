Feature: Checkout
  Background:
    Given there are the following products:
     | code  | name                   | price  |
     | 001   | Lavender heart         | £9.25  |
     | 002   | Personalised cufflinks | £45.00 |
     | 003   | Kids T-shirt           | £19.95 |
    And there is a promotion giving 10% off when you spend over £60
    And there is a promotion reducing the price of lavender hearts/001 down to £8.50 when buying 2 or more
  Scenario: 10% off promotion is applied
    When the basket the following product codes 001, 002, 003
    Then the total price should be £66.78
  Scenario: Lavender hearts are reduced
    When the basket the following product codes 001, 003, 001
    Then the total price should be £36.95
  Scenario: Both promotions are applied
    When the basket the following product codes 001, 002, 001, 003
    Then the total price should be £73.73
