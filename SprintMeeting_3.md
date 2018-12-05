# Sprint Planning Meeting 3
### Summary
For this meeting, we discussed the current state of each view, and assessed what
was left to be done. Both Mark and Adam looked into the Edamam Recipe API and
determined it wasn't worth the hassle, so Adam is now looking for a better API
to suit the needs of the app. We discussed the Pantry Model that Sydney
developed and how to use it for the IndividualListViewController. We also
decided to cut the "large text" setting as it would lead to extraneous
formatting.

### Trello Link
The team trello board can be found [here](https://trello.com/b/KZggYtj1/master-189e-board).

# Individual Reports
## Adam Ali
### Accomplishments
Worked on implementing the Edamam Recipe API, however may use a different API as
the Edamam Recipe API is fairly convoluted. 

### Planned
For the remainder of the time left, will work on finishing up the settings view
and implementing the RecipeViewController functionality.

### Links
- [Recipe View Controller Recipe Roulette](https://github.com/ECS189E/Can-I-graduate-already-LLC/blob/master/App/App/Controllers/RecipesViewController.swift)

Recipe roulette somewhat works -- Looks horrible and the codebase makes me wanna cry but oh well -- Still not fully done, need to clean up how it looks.

## Will Chilcote
### Accomplishments
Found some nice icons/assets to use in the design of the app, will apply them shortly
In addition to the existing tapping functionality, the user can now swipe left-to-right on list items to increment the quantity, which is also now displayed as a right-side detail on the cell.
Minor adjustments to Tab Bar
Designed and added App home screen icon

### Planned
For the remainder of the time left, will work on integrating the Pantry and List data

### Links
- [Individual List Enhancements](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/1fdc4ed0f948a83287a79af2ced36e796b7c346c)

## Mark Nickerson
### Accomplishments
Worked on finishing the BarcodeViewController and integrating it into the
PantryViewController flow. The barcode scanning runs on a background thread.
Added a decently fleshed out API file which contains functions used to access
data returned from an API call. Added allergen flagging when scanning a barcode.
Added pantry saving to the local device instead of using a remote server or
iCloud (as iCloud usage requires a developer's license).

### Planned
For the remainder of the time left, will work on testing the app for edge case
errors, will make sure the ShoppingListController has complete functionality
(adding items, displaying price, etc.).

### Links
- [Initial barcode PR](https://github.com/ECS189E/Can-I-graduate-already-LLC/tree/newBarcode)
- [Barcode refinements & `API.swift` addition](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/ed3527ea5190b5305a406be339d76ac0a07aefa7)
- [Pantry list saving](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/bb0045c1b6fd8e4dc66474af47bf45a207f5f724)
- [Ingredient flagging](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/56bc59086bee672ae4449ee8954fc09b63bd783d)



## Sydney Schiller
### Accomplishments
Worked on the functionality of the EditItemViewController. It is ready to be
integrated into the IndividualListViewController (used when adding an item to a
shopping list). Also finished the basics for the Product Model which can also be
integrated into the IndividualListController and the ShoppingListViewController.
Also has been gathering some resources so that we can make the app look better.

### Planned
For the remainder of the time left, going to work on app design and finish up
some functions for the product model (setting expiration, etc).

### Links
- [ProductModel integration for EditItem and PantryView VCs](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/01ebf5cc48b3bfc5bc3e446e03a6af38debcb54b)
- [Added saving for allergens in the EditItem VC](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/5e43acd88a53992cfd2ef1e7601dcd7d2d5275c8)
