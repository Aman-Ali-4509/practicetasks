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