# Foodini: Your Grocery Codex
__An app brought to you by Can I Graduate Already, LLC.__

_Special note: In order to make use of the barcode scanning functionality and
the "contact us" functionality, the app needs to be ran on a physical device._

# Individual Contributions
## Adam Ali
### Accomplishments

### Links
_Please add links here!_

## Will Chilcote
### Accomplishments

### Links
_Please add links here!_

## Mark Nickerson
### Accomplishments
My contributions include creating the ShoppingListViewController, which contains
a list of the various shopping lists the user has created. Here the user can add
lists, delete lists, and reset a list which "un checks" the items that have been
purchased. 

I implemented the BarcodeViewController where the user can scan a barcode--which
then auto populates the EditItemViewController's various values. For the barcode
scanning, I used the Edamam API, however, the day before demoing the project the
Edamam servers were down and the Edamam API was unresponsive. Therefore, I made
the decision that if an Edamam API request timed out, or if it couldn't find the
item you scanned, then the barcode scanner would make a request using the
UPCitemdb API. This ended up being good for demoing as the Edamam API has a
fairly small selection of items however the free plan allows 25 calls a minute
--whereas the UPCitemdb API has a much larger database, but we are limited to
only 100 calls a day. It should be noted that if this app were to be distributed
on the app store, we would stick with just one API and would select a plan that
allows for more calls to be made a day--which would require us to pay monthly
for the API usage.

After implementing the barcode scanner, I added it to the EditItemViewController
flow. I implemented local data storage for the pantry list and the shopping
lists making use of the PantryModel for easy serialization. Lastly, I integrated
the EditItemViewController flow for when a user adds an item to an individual
shopping list in the IndividualShoppingListViewController, and made a delegate
function to update the pantry when a user "buys" something on their shopping
list.

### Links
- [ShoppingListViewController](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/3b151240c84ea9e6de4fdda6ef1ecd912a46d8e7)
- [BarcodeViewController](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/929816bd786a5c33a066048b3016e80ddf7f1ce6)
- [Edamam API](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/ed3527ea5190b5305a406be339d76ac0a07aefa7)
- [UPCitemdb "backup" API](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/f303ef476cceb4269e174aa115137d2033346163)
- [Barcode integration with EditItemViewController](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/eb890cce30c538760e19989344111bdb0c3ec148)
- [Local data storage for the pantry list](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/bb0045c1b6fd8e4dc66474af47bf45a207f5f724)
- [Local data storage for the shopping lists](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/90b0733c686efd158ffe2bd9870800b5e4594df0)
- ["Buying" an item adds it to the pantry](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/90b0733c686efd158ffe2bd9870800b5e4594df0)
- [Barcode integration with IndividualShoppingListViewController](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/a1cd123c20cf2233e9947358e542705b2aec5122)



## Sydney Schiller
### Accomplishments
For Foodini, I was in charge of the pantryViewController, the  editItemViewController, and our model (productModel). The pantryViewController was the simplest part, consisting of just a table view which contains various products the user owns. The editItemViewController is where the user can enter in more detailed information about the product, like price, quantity, expirations, and allergen flags. Here, the price is auto-formatted and the expiration date is compared to the current date to determine if the item is expired. This information can also be filled out based on information received when someone scans a barcode. All of this information is then stored in the productModel This model also holds the information needed for the individualListViewController and the ShoppingListViewController.

### Links
- [Pantry View Controller PR](https://github.com/ECS189E/Can-I-graduate-already-LLC/pull/2)
- [File Organization for Project](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/dd69943ac7aad926bebb258d7282a7c36abdf19f)
- [Product Model Work](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/cca08a97bf491962e06e4e97d8199e9c229b9e89)
- [Set up edit item view controller](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/a33b1a1f36549f0ec2332fde1659ef057c32c900)
- [ProductModel integration for EditItem and PantryView VCs](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/01ebf5cc48b3bfc5bc3e446e03a6af38debcb54b)
- [Added saving for allergens in the EditItem VC](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/5e43acd88a53992cfd2ef1e7601dcd7d2d5275c8)
