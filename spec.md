# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
        ~> Generated app by using the "rails new" command
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)  
        ~> Donor has many appointments. Clinic has many appointments.
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
        ~> An appointment belongs to a donor and a clinic.
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
        ~> Donor has many clinics throught appoinments. Clinic has many donors through appointments. 
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
        ~> Donor has many clinics throught appoinments. Clinic has many donors through appointments.
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
        ~> "Datetime" on the Appointments table.
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
        ~> For example, a user cannot be created without a username
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)   
        ~> Donors are able to see clinics in their state, through a scope method
- [x] Include signup (how e.g. Devise)
        ~> User signs up through the signup form rendered by the signup route, and handled by the donors new/create actions.
- [x] Include login (how e.g. Devise)
        ~> User signs in through the sign in form rendered by the sign in route, and handled by the sessions new/create actions.
- [x] Include logout (how e.g. Devise)
        ~> User signs out by clearing session when clicking the signout button in different templates, handled by the sessions destroy action.
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
        ~> OmniAuth strategy for Facebook login.
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
        ~> donors/2/appointments/9
        ~> clinics/4/appointments/1
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
        ~> donors/2/appointment/new
        ~> clinics/4/appointments/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
        ~> Validation errors are displayed by highlighting the text field in a red border and changin placeholder message

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate