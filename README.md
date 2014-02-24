Redit-Search-and-Share
======================

Sample app for Rocksauce

Technologies used:
- CocoaPods
- Asynchronous web requests/JSON serialization
	- AFNetworking
- Core Data
	- Magical Record
- ARC
- Storyboards
	
Features:
- Search
	- Can be used to find other subreddits. Also saves previous searches.
- Pull-to-Refresh
	- Refreshes current subreddit
- Save favorite tweets
	- Clicking on a post in Feed saves it to Favorites
- Sharing with UIActivityControl
	- Clicking on a post in Favorites shows sharing options
	- Share via SMS, Mail, Twitter, Facebook, etc.
- Post score shows on cell

Decisions I made:
- Use of Storyboards
	- I'm sorry I had to use this. I had another sample project to complete for another
	company so I was extremely time-strapped. Storyboards allowed me to create the app the
	quickest, but I am also familiar with creating interfaces with xib files or
	programmatically, I just haven't built entire applications that way before.
- Favorites
	- I wanted to extend the functionality of the app in some way so this is what I chose
- Tabbed Controller
	- At first I wanted to implement a custom navigation controller where the bar would
	slide down when a button on the bar was pressed, but I cut this for the sake of time.
- Sharing posts from Favorites
	- I originally wanted to be able to share or favorite posts by sliding over on the
	cell to reveal the edit accessory, which I could then replace with my own custom view.
	After I played around with this for a half hour or so, the view still wouldn't replace
	the stock edit view so I cut this feature and decided on the current implementation.
- Not including the overlay or given share card
	- Neither looked very iOS 7 like. For sharing, the UIActivityControl provided more
	sharing options as well.
	
Total Time: ~7 hours

Loading in Posts: 1.5 hours
	- Getting the response was extremely simple. Then I had to figure out how the response
	needed to be parsed out, modeled with a class, and saved to CoreData.
Setting up custom post cells: 1 hour
	- I wanted the images to sit flush with the edges of the cell but there was space at
	the bottom of the cell that kept appearing. It took me a half hour to realize I had
	changed the cell size for the UITableView. Dumb.
Getting Favorites working: .5 hours
Implementing UI Pieces: 1 hour
	- Setting the background was easy. Adding the custom font took ~30 minutes. I also
	had to find images for the tab bar controller and app icon.
Search Bar: 1.5 hours
	- Because of how I set up the web requests, getting the response took ~20 minutes.
	Then I had to add all the logic for saving previous searches, showing them in the
	search controller table view, and differentiating between the two table views (since
	both the search and feed table views are handled in the same view controller).
Various UI things that I cut: 1.5 hours

Answers:
- Was 3 days/12 hours enough time? Why or why not?
	- Yes, I thought so. My biggest trouble was finding time to put in the hours, not the
	project itself. As I stated before, I had more ambitious plans that I had to cut. If
	I had 5 more hours to put into it, the app would look much more polished. The next
	thing I would add is a view to see the images in full size.
- How many hours would you estimate you spent total on the project?
	- I spent ~7 hours on it. The breakdown is detailed above.
- Did you encounter any struggles while completing this? How did you overcome them?
	- Almost everything that caught me up was on the UI/UX end. Making asynchronous web
	requests is something I have done many times before so getting the data was very
	simple. There were a few times that things in the table view cells weren't rendering
	as I expected. I then had to go through and check how I was setting each property,
	whether the data I was passing the cell was valid, and checking the table view 
	properties. To do this I used break points and NSLogged different properties.
	- I also struggled with the scope of the project. I knew I wanted to add in a couple
	features to show what I could figure out, but that comes at the expense of other
	things. That forced me to scale back on UX, which I was willing to do since this isn't
	going to be released. Typically, I would cut features for polish, but without a
	designer I figured any custom UI I did would require custom UI pieces, which would
	very quickly balloon the amount of time to complete the app.
- On a scale of 1-10, rate the complexity of this project.
	- The baseline spec is around a 2 or 3. That's about as simple as an app that's making
	web requests can get. The complexity comes with presenting the data in the best way
	and determining what features would be most useful.