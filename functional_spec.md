# CRM Lite CLI app: functional specification

CRM Lite is a user-friendly command-line interface app designed to help small businesses and entrepreneurs efficiently manage customer relationships right from their terminal.

## User stories

### Customer management

- As a user, I want to add new customers entries to the database with the following details: company name, contact full name, contact email, and business opportunity stage.
- As a user, I want to update specific fields of an existing customer.
- As a user, I want to delete an existing customer entry from the database.
- As a user, I want to receive immediate confirmation when a customer is added, updated, or deleted.

### Workflow

- As a user, I want to perform multiple actions without restarting the app.
- As a user, I want visual and color-coded instructions and feedback so I know clearly what action I'm performing.

## Functional requirements

- The app must validate user input
- The app must display the result of an action
- The app must provide error messages for invalid menu selection and non-existent customer IDs
- The app must support adding, updating, and deleteing customers
- The app must generate unique customer IDs automatically
- The app must timestamp customers entries with creation date
- The app must provide a view of all current customers
- The app must allow the user to perform another action after one completes
- The app must test customer creation and customer updating
