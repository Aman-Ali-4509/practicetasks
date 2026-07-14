Code 1 is your Login Screen. It acts as a secure entrance to your app.
It uses a Form widget to check if the user entered a valid email (making sure it contains an "@" symbol) and a secure password 
(making sure it is at least 6 characters long). If the inputs pass these checks, 
it lets the user click "Login" to slide forward to a simple welcome screen.

Code 2 is your Counter and Drawer List App. This is your first step into saving data directly to the phone's memory. 
It displays a number on the screen that goes up or down when you tap the plus or minus buttons. 
It uses a tool called SharedPreferences to remember that number even if you close and restart the app. 
It also features a slide-out sidebar menu (a Drawer) that lets you switch over to a basic page where you can type text 
to add items to a simple checklist.

Code 3 is your Advanced Task Manager. This takes the checklist idea from Code 2 and makes it much smarter. 
Instead of just saving raw text, it creates a custom "Task object" that tracks both the description of your chore and whether
it is checked off or not. Because phones can't save complex objects directly, this code translates your tasks into a text format 
called JSON to save them, and converts them back when the app opens. It also gives you a modern pop-up menu from the bottom of the screen 
to add tasks, visually crosses out finished tasks with a line through the text, and lets you delete tasks when you are done.

Code 4 is your **API User Directory**. This is your gateway to the internet, moving past local storage to fetch real-world data from an external web server (JSONPlaceholder). 
It uses the `http` package to safely request a list of users, maps the incoming JSON response into structured Dart objects, and elegantly handles real-world issues—like showing 
a loading wheel while waiting, or displaying a custom offline screen with a "Try Again" button if your connection drops. When you tap a user's card, it passes their complete profile 
to a dedicated details screen, complete with a smooth **Hero animation** that dynamically grows their avatar image as you transition.

Code 5 is your Auth & Firestore Manager. This is your transition into production-grade cloud services, moving from simulated APIs to a real-time, production-ready backend.
It implements a secure Firebase Authentication system featuring email login and registration alongside Cloud Firestore. Instead of manually routing the user, it uses a reactive 
StreamBuilder that automatically listens to the user's login state and swaps screens the second they sign out or log in. When a new user registers, it instantly provisions a custom 
profile document in the cloud database and fetches those details—like their name and email—using a live Firestore stream to keep their profile page updated in real time.
