# AC3.2-Tableviews Part 4: **Title Goes Here**

---
### Readings

 1. [General Reference on Xcode (very useful)](http://help.apple.com/xcode/mac/8.0)
 2. [Configuring a Segue in Storyboard - Apple](http://help.apple.com/xcode/mac/8.0/#/deve5fc2eb19)
 3. [Using Segues (lots of great info here)](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html)
 4. [Navigation Controller Implementation - tuts+ (helpful reference and example)](https://code.tutsplus.com/tutorials/ios-from-scratch-with-swift-navigation-controllers-and-view-controller-hierarchies--cms-25462)

#### References

1. [Using Segues - Apple](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html)

---
### Vocabulary

1. **MVP (Minimum Viable Product)** - rapidly building a minimum set of features that is enough to deploy a product and test key assumptions about customers’ interactions with the product. [Quora](https://www.quora.com/What-is-a-minimum-viable-product/answer/Suren-Samarchyan?srid=dpgi)
2. **Segue** - A segue defines a transition between two view controllers in your app’s storyboard file. [Apple](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html)

---
### 0. Objectives

1. Understand segues in storyboard to transition between view controllers
2. Futher our understanding of `UITableViewController` delegate functions
3. Create a new custom `UIViewController` to display a single `Movie` object's data

---

### 1. Revealing the MVP to Reel Good

<img src="./Images/first_mvp.png" alt="First MVP" width="400">

"Stunning!" - Reel Good, CEO

"... this app is becoming so beatiful..." - Reel Good, Lead Designer

"How much is this costing us?" - Reel Good, CFO

"The board will be thrilled" - Reel Good, Investor Relations

"It's OK." - Reel Good, Crusty iOS Engineer


Great work on this MVP, but now Reel Good is expecting a lot more out of the next iteration. They want a full screen detail view on the movie and some design tweaks. On top of this, your engineering team has decided that the code base needs some clean up before it gets to large! The next stage of this project will be even more challenging and there's no time to rest on laurels.

Reel Good took our latest prototype and presented it to their board of investors as the cornerstone of their mobile initiative. The extra work we put behind the design of the app must have really sold it, because Reel Good now needs one more set of changes before they take the app into beta.

For the next [MVP](https://www.quora.com/What-is-a-minimum-viable-product/answer/Suren-Samarchyan?srid=dpgi), Reel Good wants to be able to tap on the movie cell to display full details of the movie on a different screen.

#### Planning

After the meeting with Reel Good, we sat down with our engineering team and sketched out the necessary requirements of this next task and broke them down:

1. We have to create a new view controller to present a full screen version of the movie data
2. We need to make sure that navigation works to go to and from one of these view controllers.
3. The proper movie data has to be transferred from one view controller to the next, so we need to do some data handling

> Developer's note: A huge part of development is being able to translate feature requests from clients into actual programming work. Taking some time to plan out a course of action before starting to code will likely save you a lot of time in the course of your project. Though even with the best planning, there absolutely will be unforseen problems that you will encounter. But that's just part of the fun of programming.

---
### 1. Adding a new `UIViewController` to Display a single `Movie`

#### Storyboard Changes **(Use iPhone 6s for your simulation)**
1. Drag in a `UIViewController` into `Main.storyboard` from the *Objects Library* in the *Utilities Pane* and place it next to the `MovieTableViewController`
  - <img src="./Images/added_new_view_controller.png" width="500" alt="Placing a new VC on storyboard">
2. Select the `MovieTableViewCell` prototype cell (make sure you have the actual `cell` selected and not one of its subviews) and `ctrl`-Drag to the new `UIViewController`
3. On the outlet menu that pops up, select "`Selection Segue > Show`"
  - <img src="./Images/choosing_selection_segue.png" width="400" alt="Choosing the connection outlet type for a segue">
  - Note: "Accessory Selection" is the action to perform when adding an "accessory view." An example of an accessory view is the `>` (called a "chevron") you see all the way to the right on a cell in the Mail or Messages app on an iPhone.
  - The "Selection" type of segue refers to the action to take when the cell itself is tapped/selected.
  - <img src="./Images/single_segue_to_vc.png" width="500" alt="Single connected segue to VC">
4. Select the segue object in storyboard (the -> arrow), and in the *Attribute Inspector*, set it's identifier to `MovieDetailViewSegue`
5. Drag in a `UIImageView` into the view controller, giving it the following attributes:
  - `8pt` margins at the top, left, and right
  - A height of `240pt`
  - _Before adding these constraints, make sure the checkmark box for "Constrain to margins" is selected_
  - Switch the image view's `Content Mode` to `Aspect Fit`
6. Drag in 4 `UILabel`s below the `UIImageView` in a vertical row
  - Label them (in order): `Genre`, `Location`, `Summary` and `Summary Text`
  - Set their fonts to `System - 17pt`, except for `Summary Text` which will be `System - Light - 14pt`
  - Set the number of lines for `Summary Text` to 0
7. Select **all** of the `UILabel`s at once, by holding down the Command (⌘) Key while clicking on them
  - Select *Pin* and set it to **8pt margins**, also making sure that the checkmark for "Constrain to margins" is selected
  - Set the `Vertical Content Hugging Priority` to 1000 for all labels except `Summary Text`. Instead, set the *Vertical Compression Resistance* of `Summary Text` to 1000
8. Your view controller should resemble:

<img src="./Images/movie_vc_ui_storyboard.png" width="400" alt="Setting up the Movie VC UI">

Being able to set constraints in this batching form is one of the nice advantages of using storyboards.

#### Storyboard linking
1. Add a new file named `MovieDetailViewController` that subclasses `UIViewController` and place it in the correct folder and Xcode group
2. In `Main.storyboard` change the custom class of the view controller we just added to be `MovieDetailViewController`
3. Create outlets for each of the labels and the imageView. Name them:
  - `moviePosterImageView`, `genreLabel`, `locationLabel`, `summaryLabel`, and `summaryFullTextLabel`
4. Additionally, give `MovieDetailViewController` an instance variable of type `Movie`
  - `internal var selectedMovie: Movie!`
  - This property will hold a reference to the `Movie` from the cell that was tapped.

#### Preparing for Segue
A `UINavigationController` is unique in that it manages a _navigation stack_, which is a hierarchy of view controllers.

You can think of each view controller as being a card in a stack of cards.  When you **push** a view controller onto the stack, you're putting a new card on top of the _stack_ of cards. That top-most card is what is currently visible on screen. When you **pop** a view controller, you're taking a card off the top of the _stack_, and revealing the card/view controller just below it.

> It's important to know that all view controllers currently on the stack can be accessed through the navigation controller

The `prepare(for:sender:)` method is where we get things ready for displaying a new view controller that has been set up in storyboard.

As mentioned in the documentation for [`prepare(for:sender:)`](https://developer.apple.com/reference/appkit/nssegueperforming/1409583-performsegue), the `sender` parameter refers to the object that has requested the segue. In our case, the `sender` is expected to be a `MovieTableviewCell`. But because the `sender` is defined as being of type `Any?`, we should do a check to confirm our assumptions. Moreover, we'll need the cell to determine which movie cell was tapped.

```swift
  // 1. check sender for the cell that was tapped
  if let tappedMovieCell: MovieTableViewCell = sender as? MovieTableViewCell {

  }
```

The `segue` object is an instance of [`UIStoryboardSegue`](https://developer.apple.com/reference/uikit/uistoryboardsegue), which has an instance property of `indentifier` that refers to the identifier string we gave to the segue earlier in `Main.storyboard` (we used `MovieDetailViewSegue`). In order to make sure that we have the correct segue (a storyboard can have many segues), we need to check that the identifier matches one that we expect:

```swift
  // 1. check sender for the cell that was tapped
  if let tappedMovieCell: MovieTableViewCell = sender as? MovieTableViewCell {

    // 2. check for the right storyboard segue
    if segue.identifier == "MovieDetailViewSegue" {

    }
  }
```

While generally you should avoid force unwrapping, because we're certain of both the `sender` and the storyboard `segue` we can say with some certainty that the `segue.destination` is going to be a `MovieDetailViewController`:

`let movieDetailViewController: MovieDetailViewController = segue.destination as! MovieDetailViewController`

We now have the tapped cell (`sender`) and the instance of `MovieDetailViewController` (`segue.destination`), but how do we get the `Movie` object that corresponds to the cell we selected?

We already wrote a piece of code in `cellForRow` that arranged our `movieData` by genre, but that required having the current `indexPath`. Fortunately, we can get that index path using a function of `UITableview` called `indexPath(for:)`. Using that function, along with our code from `cellForRow` we have:

```swift
  // 1. check sender for the cell that was tapped
  if let tappedMovieCell: MovieTableViewCell = sender as? MovieTableViewCell {

    // 2. check for the right storyboard segue
    if segue.identifier == "MovieDetailViewSegue" {

      // 3. get reference to the destination view controller
      let movieDetailViewController: MovieDetailViewController = segue.destination as! MovieDetailViewController

      // 4. get our cell's indexPath
      let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedMovieCell)!

      // 5. get our cell's Movie
      guard let genre = Genre.init(rawValue: cellIndexPath.section),
       let data = byGenre(genre) else {
         return
      }

      // 6. set the destionation's selectedMovie property
      let selectedMovie: Movie = data[cellIndexPath.row]
      movieDetailViewController.selectedMovie = selectedMovie
    }
  }
```

Now that the destination `MovieDetailViewController` has its `Movie` object reference, let's populate the labels:

```swift
  movieDetailViewController.moviePosterImageView.image = UIImage(named: selectedMovie.poster)
  movieDetailViewController.genreLabel.text = "Genre: " + selectedMovie.genre.capitalized
  movieDetailViewController.locationLabel.text = "Locations: " + selectedMovie.locations.joined(separator: ", ")
  movieDetailViewController.summaryFullTextLabel.text = selectedMovie.summary
```

Go ahead and run the poject at this point to see if the data gets passed along properly...

`fatal error: unexpectedly found nil while unwrapping an Optional value`

> **Discuss & Debug**:
Why are we getting force unwrapping errors?

#### Updating `MovieDetailViewController` with a `Movie`

Let's move our code into `MovieDetailViewController` in a new function, `updateViews(for:)`:

```swift
  internal func updateViews(for movie: Movie) {
    self.moviePosterImageView.image = UIImage(named: movie.poster)!
    self.genreLabel.text = "Genre: " + movie.genre.capitalized
    self.locationLabel.text = "Locations: " + movie.locations.joined(separator: ", ")
    self.summaryFullTextLabel.text = movie.summary
  }
```

And lastly, let's call `updateViews(for:)` in `viewDidLoad`

```swift
  override func viewDidLoad() {
    super.viewDidLoad()

    self.updateViews(for: self.selectedMovie)
  }
```

And re-run the project now. You should see

![Detail View Controller Full](http://i.imgur.com/7xu5KJ2l.png)

---

### 2. Exercise

You may have noticed that we didn't add in a label for `Movie.cast`.

What we'd like to do is be able to present a view controller of just the `Actor`s for each movie when you tap on an accessory view of the `MovieTableviewCell`.

To acheive that goal, here are a few pointers:

1. Create a new `UIViewController` sublcass called `MovieCastDetailViewController`
2. Drag a `UIViewController` into storyboard, and change its custom class to `MovieCastDetailViewController`
3. Add two labels to this view with the following details (screen shot):
  - `castTitleLabel`:
    - `Roboto - Bold, 24pt`, Number of Lines = 1, `8pt` margins to top, left, right. `Vertical Content Hugging - 1000`
  - `castListLabel`:
    - `Roboto - Regular, 18pt`, Number of Lines = 0, `8pt` top margin to `castTitleLabel`, `24pt` left margin, `8pt` right margin.
  - ![Cast List VC Storyboard](http://i.imgur.com/wCuTQo6l.png)
3. Create a segue between `MovieTableviewCell` and `MovieCastDetailViewController`, though instead of chosing a segue of type "Selection Segue" you'll be using "Accessory Action". Give the segue and identifier of `MovieCastDetailSegue`
  - Creating the segue of type "Accessory Action" should automatically add a "Disclosure Indicator" accesory view to the `MovieTableviewCell`, but be sure to switch it to "Detail"
  - Storyboard will look something like this:
  - ![Full Storyboard for Exercise 2](http://i.imgur.com/a3OGYpBl.png)
5. Update your code in `MovieTableViewController.prepare(for:sender:)` to recognize the new segue identifier
6. Populate your `castListLabel` with the `Actor` names so that your final product looks like
![Table View Controller w/ Detail Accessory](http://i.imgur.com/uv8HuXQl.png)
![Cast List Detail VC](http://i.imgur.com/V5lLLSLl.png)

#### Other Optional Exercises
1. Update the title of the `UINavigationController` of `MovieDetailViewController` to have the name of the `Movie` being viewed
2. Same as the above, but for the `MovieCastDetailViewController`
3. You may have noticed that some of the labels get hidden when viewing the project on an iPhone 5s. Swap the `summaryText` `UILabel` with a `UITextView` to allow for this portion of the text to be scrollable. Then under “behavior” in attributes, uncheck both Editable and Selectable.
