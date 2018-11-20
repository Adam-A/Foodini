# Sprint Planning Meeting 1
### Summary
For this meeting, we whittled our API usage down to just the [Edamam](https://www.edamam.com/) API. 
We determined the barcode may be out of scope given the time frame, but needs
further investigation before completely ruling it out. Most of the view
controllers are on track with being completed (with basic functionality at least).

### Trello Link
The team trello board can be found [here](https://trello.com/b/KZggYtj1/master-189e-board).

# Individual Reports
## Adam Ali
### Accomplishments
Researched sketch resources, tried to get food related ones that were more
lighthearted and fresh. Decided on using [Sketch App Sources](https://www.sketchappsources.com/).

### Issues
Had an issue with the cocoapod ViewAnimator, is trying to fix the issue but has
delayed progress.

### Planned
For the upcoming week, plans on finishing the recipe view controller and the
settings view controller. If finished early, will lend a hand where needed.

### Links
Found some resources we could use:

- [Resource 1](https://www.sketchappsources.com/free-source/2669-sample-recipes-desserts-app-sketch-freebie-resource.html)
- [Resource 2](https://www.sketchappsources.com/free-source/3222-caterfood-app-sample-sketch-freebie-resource.html)
- [Resource 3](https://www.sketchappsources.com/free-source/3148-to-do-app-template-sketch-freebie-resource.html)
- [Resource 4 (Our most relevant resource)](https://www.sketchappsources.com/free-source/3222-caterfood-app-sample-sketch-freebie-resource.html)



## Will Chilcote
### Accomplishments
Completed the IndividualListViewController, which contains embedded functionality to create a new item and append it to the current list, as well as swipe-to-delete on individual list items. The View has also been linked to the table cells in ShoppingListViewController.

### Planned
For the upcoming week, I am planning on looking into iCloud support for saving user information.


### Links
- [Individual List View Controller](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/66d704d8caae14a2946d68fba427e960995151e5)

## Mark Nickerson
### Accomplishments
Set up workspace and completed the shopping list view controller.

### Issues
Had originally planned on using the Chameleon cocoapod for color and
beautification, however it turned out to be unsupported past swift 3.

### Planned
For the upcoming week, plans on looking into the [Edamam](https://www.edamam.com/) API.
Will also dedicate time to working on the bar code view controller to determine
if it is feasible give the project scope. Plans to complete the shopping list
model.

### Links
- [Environment setup commit](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/73de3859c9c2e731b4e489f5a672da2993221f14)
- [Shopping List View Controller PR](https://github.com/ECS189E/Can-I-graduate-already-LLC/pull/1)


## Sydney Schiller
### Accomplishments
Completed most of the pantry view controller, had encountered an issue with
ingredients stacking which needs to be addressed. Set up project organization.

### Planned
For the upcoming week, plans on finishing the pantry view controller, the pantry
model, and looking into ingredient searching using the [Edamam](https://www.edamam.com/) API.

### Issues
Ingredients bought on two different dates may be able to stack into the same
pantry object, so is devising a solution.

### Links
- [Pantry View Controller PR](https://github.com/ECS189E/Can-I-graduate-already-LLC/pull/2)
- [File Organization for Project](https://github.com/ECS189E/Can-I-graduate-already-LLC/commit/dd69943ac7aad926bebb258d7282a7c36abdf19f)
