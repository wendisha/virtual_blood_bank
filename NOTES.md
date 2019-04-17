Description:
    -Virtual Blood Bank only handles whole blood donations for now, not Platelet, Plasma or Double Red Blood Cells donations. (freq: 56 days)
    -A user is able to log in as an donor (individual) or recipient (health care center)
    -As a donor:
        -A user will create a profile with info pertaining to personal info and donor's criteria:
            -Personal and contact info
            -Bloodtype (choose from dropdown menu)
            -Overall_Health (choose from good, fair, bad)
            -Location (zipcode)
        -Will be able to edit the form to choose whether or not they are available to donate. (freq: 56 days)

    -As a recipient:
        -A user will create a profile with info pertaining to its name and location.
        -Will be able to see the list of all available donors (sorted by distance?, bloodtype)
        -Will be able to post request than can either be fufilled right away (if bloodtype donor is available), or marked as pending.

Associations:
    -Donor belongs_to a bloodtype, has_many recipients, through bloodtype
    -Bloodtype has_many donors, has_many recipients
    -Recipient has_many bloodtypes, has_many donors, through bloodtype
     #join table for bloodtype and recipient (bloodtype_recipients)
     #ex: recipe, ingredients, recipe_ingredients (summittable attr: quantity)

Schema:
    -Donors Table:  
    #taking into consideration that donors go through a Pre-donation Screening at the Donations Center.
        -Username
        -Password
        -Name
        -Age
        -Overall_health 
        -Bloodtype
        -Zipcode
        -Bloodtype_id
        #contact column

    -Bloodtypes Table:
        -Type (A+, O+, B+, AB+, A-, O-, B-, AB-)

    -Recipients Table: #facility/center that requests the blood.
        -Username
        -Password
        -Name
        -Zip_Code #proximity to donor

Navigation Flow:
    •Homepage:
    -Greeting/Description
    -Option to sign up/sign in as a Donor or a Recipient
    If Signed In as a donor:
        •DONOR Signup/Signin links
        -Option to login with Facebook or Gmail #not to signup???
            •User's Homepage
            -Link to Create a Profile (new user) or to Edit Profile (existing user)
            -Logout option
    If Signed In as a recipient:
        •RECIPIENT Signup/Signin links
            •Recipient's Homepage
            -Link to Create a Profile (new user) or to Edit Profile (existing user)
            -Logout option

Clarifications:
    • Include a many-to-many relationship implemented with has_many :through associations. The join table must include a user-submittable attribute — that is to say, some attribute other than its foreign keys that can be submitted by the app's user
    • You must include at least one class level ActiveRecord scope method. 
        a. Your scope method must be chainable, meaning that you must use ActiveRecord Query methods within it (such as .where and .order) rather than native ruby methods (such as #find_all or #sort). #define the relationship between recipients and bloodtype (remember boolean example)
    • You must include a nested new route with form that relates to the parent resource
    • You must include a nested index or show route


  Nested route example:
    #recipients/1/bloodtype
