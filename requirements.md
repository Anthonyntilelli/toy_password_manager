# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
   - User has_many Membership
   - Keychain has_many Membership, accounts
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
   - Accounts belongs_to keychain
   - Membership belongs_to Keychain,User
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
   - User has_many ketychains throught membership
   - keychains has_many users thougth membership
- [ ] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
  - via membership <- ???
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
  - User can manage their invite and admin status in membership
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
  - All models have a level of validation
- [ ] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
- [x] Include signup
- [x] Include login
- [x] Include logout
- [ ] Include third party signup/login (how e.g. Devise/OmniAuth)
- [ ] Include nested resource show or index (URL e.g. users/2/recipes)
- [ ] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
    - Flash is used extensively

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [x] Views use helper methods if appropriate
    - `keychain_admin?` (keychain_helper)
    - `logged_in?` (application_helper)
- [ ] Views use partials if appropriate
