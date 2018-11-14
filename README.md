# Can I Graduate Already, LLC
__Contents__
1. Group Information  
2. Design  
3. Libraries & APIs  
    3.1 Third Party Libraries  
    3.2 Native Libraries  
4. Server Support  
5. Models  
    5.1 List Model  
    5.2 Pantry Model  
6. View Controllers  
    6.1 ShoppingListViewController  
    6.2 IndividualListViewController  
    6.3 AddItemViewController  
    6.4 PantryViewController  
    6.5 RecipesViewController  
    6.6 SettingsViewController  
7. Week Long Tasks  
    7.1 Week 1  
    7.2 Week 2  
    7.3 Week 3  
    7.4 Week 4  
8. Trello Board  
9. Github Classroom  
10. Testing Plan   


## 1. Group Information
Team:
[Adam Ali](https://github.com/adam-a)
[Will Chilcote](https://github.com/willchil)
[Mark Nickerson](https://github.com/MarkNickerson)
[Sydney Schiller](https://github.com/SydneySchiller)

## 2. Design
The following are the planned designs of the various screens/views:
- Splash/loading screen
- Master shopping list screen
- Individual shopping list
- Add item to list view
- Pantry view
- BarCode scanning view
- Random recipe view
- Settings view

![](https://i.imgur.com/ChM6wKS.png)

## 3. Libraries & APIs
### 3.1 Third Party Libraries
Most of the third party libraries and APIs we'll be relying on revolve around
accessing large databases of either foods or recipes. These are:
- Recipe & food database, found at [Edamam](https://www.edamam.com/).
- Food database with associated barcodes found at [Open food facts](https://world.openfoodfacts.org/).
- To make things look nice, various UI Design/Formatting cocoapods.
### 3.2 Native Libraries
- AVFoundation framework, used for real-time barcode scanning.

## 4. Server Support
To save the user's login and data, we will attempt to make use of iCloud for our
serialization--wherein the user account will simply use the user's apple ID.
However, if this becomes too much of a hassle, or is unreliable, we will
implement Google login and Firebase as our means of handling the login/signup
process and storing of user data. 

## 5. Models
The tentative outline of the models planned are a grocery list model and a
pantry model.
### 5.1 List Model
The list model will contain all data relevant to the shopping list. Including:
- Item struct 
- Name
- Expiration data
- Price
### 5.2 Pantry Model
The list model will contain all data relevant to the pantry. Including:
- Expiration date flagging
- The date the item was added

## 6. View Controllers
### 6.1 ShoppingListViewController
__Variables:__
- Table view containing list of shopping lists (serializable)

__View:__
- A table view containing a list of the grocery lists you have made
- An add list button (creates list that the user can rename)
- An edit list button (delete buttons pop up near list items)
- Buttons to navigate to the _PantryViewController_, _RecipesViewController_, and
the _SettingsViewController_

### 6.2 IndividualListViewController
__Delegates/Protocols:__
- When an item is marked off/purchased, update list of items the user has over
in the _PantryViewController_
- Deleting a list here will remove it from the list of shopping lists in the
_ShoppingListViewController_

__Variables:__
- Items to purchase, entered into table view
- Table view

__View:__
- Back button (returns user to _ShoppingListViewController_)
- Edit button to add items to the list (takes user to _AddItemViewController_)
- Table view of items

### 6.3 AddItemViewController
__Delegates/Protocols:__
- Items added/removed here are added or removed to/from the
_IndividualListViewController_/_PantryViewController_ tableview
- Populates items on this view controller from _IndividualListViewController_ or
from the _PantryViewController_

__Variables:__
- List of items on relevant grocery list

__View:__
- Done button (returns user to that specific _IndividualListViewController_)
- Back button (returns user to that specific _IndividualListViewController_)
- Custom keyboard with name of item and amount to purchase
- Scan barcode button (takes user to _BarcodeScannerViewController_)

### 6.4 PantryViewController
__Delegates/Protocols:__
- Items here are updated either manually or through _IndividualListViewController_
input

__Variables:__
- List of items in pantry
- Table view of items in pantry

__View:__
- Manual add button (takes user to a _AddItemViewController_ populated with with
items from the pantry)
- Buttons to navigate to the _ShoppingListViewController_, _RecipesViewController_,
and the _SettingsViewController_
- Table view containing the list of items in the pantry

### 6.5 RecipesViewController
__View:__
- Generate a random recipe when a button is pressed
- Buttons to navigate to the _PantryViewController_, _ShoppingListViewController_,
and the _SettingsViewController_

### 6.6 SettingsViewController
__Delegates/Protocols:__
- Update the settings that apply to the specific view controller

__View:__
- A few text labels with buttons for the different settings

### 6.7 BarcodeScannerViewController
__Delegates/Protocols:__
- Return relevant information to _AddItemViewController_

__Variables:__
- An Image or whatever information returns from the API call

__View:__
- Standard camera view stuff
- Data flow: (scan barcode) -> (retrieve item from openfoodsfactDB using barcode
match) -> (return food item name/info to user)

## 7. Week Long Tasks
### 7.1 Week 1
Set up main navigation and views.
### 7.2 Week 2
Implement barcode scanning and shopping list support, ensuring shopping list
serialization.
### 7.3 Week 3
Add pantry view and details, ensuring cross-view updates.
### 7.4 Week 4
Add recipe support if possible, hopefully base recipes off of what the user has
in their pantry.

## 8. Trello Board
The team's Trello board can be found [here](https://trello.com/b/KZggYtj1/master-189e-board).
## 9. Github Classroom
The team's Github classroom can be found [here](https://github.com/ECS189E/Can-I-graduate-already-LLC).
## 10. Testing Plan 
For the testing of the app, we determined that the testing group types could be
broken up as: 
- Holding focus groups (pizza supplied) to get people to try out the app
- Family, friend, classmate testing

The three (_more questions to come, surly_) basic questions to ask we concluded
were:
- rate the usefulness of the app
- rate the ease of use (signup/login and general use of the app)
- clarity of app purpose/use (gathered with or without prior instruction)

Lastly, the other miscellaneous things to keep an eye out for during testing
sessions are:
- user suggestions
- observations we make while users used app
