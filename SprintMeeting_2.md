# Sprint Planning Meeting 2
### Summary
For this meeting, we discussed the remaining tasks that need to be taken care of
(most of which requires us to actually create our models) but established that
we want to know more about what information an [Edamam](https://www.edamam.com/) API call returns
to us before making a solid model outline--this will be the main goal for the
upcoming week. We also finalized the functionality of the recipe view
controller, limiting it to simply generating a random recipe and having a drop
down of that recipe's ingredients. Lastly, due to resources like this [tutorial](https://www.appcoda.com/simple-barcode-reader-app-swift/) in
addition to the swift documentation for AVFoundation, we determined the barcode
should be manageable.

### Trello Link
The team trello board can be found [here](https://trello.com/b/KZggYtj1/master-189e-board).

# Individual Reports
## Adam Ali
### Accomplishments
Worked on Settings View Controller, focused on UI layout. The Recipe View 
Controller dropdown is done, just need to add the [Edamam](https://www.edamam.com/) API random
recipe search functionality.

### Issues
Experiencing merge conflicts when trying to merge branch.

### Planned
For the upcoming week, plans on adding random recipes using the [Edamam](https://www.edamam.com/) API
and implementing the contact us and feedback function on the settings view
controller.

### Links
- [RecipesViewController](https://github.com/ECS189E/Can-I-graduate-already-LLC/blob/master/App/App/Controllers/RecipesViewController.swift)

- [SettingsViewController](https://github.com/ECS189E/Can-I-graduate-already-LLC/blob/master/App/App/Controllers/SettingsViewController.swift)

And the views for Settings and Recipes in Main.Storyboard.

## Will Chilcote
### Accomplishments
Worked on adding the table list for the individual list controller. Looked into
using iCloud, however it requires a published app/about to be published app. If
we publish the app, we would use __key value pairs__ for things like settings
and would save our actual grocery/pantry lists as a __document__. Switched the bottom tab bar to use Tab Bar Controller and integrated independent Navigation Controllers as necessary. Also added constraints to various views, primarily in Settings.

### Planned
For the upcoming week, will resolve bugs (such as the Recipes view) and refine inter-application navigation, as the Tab Bar is somewhat rudimentary currently.

### Issues
The Recipes view crashes whenever it is loaded, likely from a missing outlet or misnamed class. This seems to be the result of attempting to resolve the merge conflict. For now it has been omitted from the Tab Bar Controller.


### Links
- [Tab Bar Controller](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/4dced91dca1efc23208895c3583f5d178f75d300)

## Mark Nickerson
### Accomplishments
Worked on the barcode scanner view and understanding the [Edamam](https://www.edamam.com/)
barcode functionality. The barcode view currently displays video of what the
camera is capturing on screen, outputs metadata from the capture device, and
processes the metadata as an EAN13 barcode number. This number is then processed
 to be used as a UPC number. Also worked on understanding how to use the
[Edamam](https://www.edamam.com/) API to make a call for a barcode. Noted that Edamam uses cUrl 
notation in its documentation, so I researched how to use cUrl syntax with
swift.

### Issues
Ran into issues with getting access to camera on the device, however, was able
to figure out permission management.

### Planned
For the upcoming week, will work on a delegate to update shopping list contents,
assist in the creation of a food list model, and  finish up barcode scanner with
API functionality.


### Links
_Resources:_
- [Barcode tutorial](https://www.appcoda.com/simple-barcode-reader-app-swift/)
- [AVFoundation documentation](https://developer.apple.com/documentation/avfoundation/avmetadatamachinereadablecodeobject/machine_readable_object_types)

_Commits:_
- [Barcode View Controller](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/fdf7c3eaa54cd88897bcbeb1e2e806cca263bbd1)



## Sydney Schiller
### Accomplishments
Worked on understanding ingredient search API using [Edamam](https://www.edamam.com/)  and noted that
we have a 25 calls per minute limit for ingredient search. Worked on setting up
a view controller for adding items to the pantry via a delegate.

## Issues
currently, I am having trouble getting my prototype cells to appear in the editItemView. I will need to 
follow a tutorial to fix this issue, or possibly switch to a tableViewController rather than the standard 
view controller.

### Planned
For the upcoming week, plans on finishing the pantry view controller, work on
the pantry model (determined we may just need a “food” model), and finish up
[Edamam](https://www.edamam.com/) API work.

### Links
- [Product Model Work](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/cca08a97bf491962e06e4e97d8199e9c229b9e89)
- [Set up edit item view controller](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/a33b1a1f36549f0ec2332fde1659ef057c32c900)
