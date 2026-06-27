import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // Initialized to 0 immediately to prevent late initialization errors
  int counted = 0;

  @override
  void initState() {
    super.initState();
    _loadNumber();
  }

  Future<void> _loadNumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      counted = pref.getInt("count") ?? 0;
    });
  }

  Future<void> _saveNumber(int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt("count", value);
    // Setting state directly updates the UI smoothly
    setState(() {
      counted = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Aman Ali"),
              accountEmail: Text("Aman@123"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_box),
              title: const Text("Counter App"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("List App"),
              onTap: () {
                Navigator.pop(context); // Close drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListApp()),
                );
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total Counted Number is $counted",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _saveNumber(counted + 1),
                  child: const Text("+", style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _saveNumber(counted - 1),
                  child: const Text("-", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- TASK 3: SIMPLE LIST APP ---
class ListApp extends StatefulWidget {
  const ListApp({super.key});

  @override
  State<ListApp> createState() => ListAppState();
}

class ListAppState extends State<ListApp> {
  final List<String> _todoList = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Load string list from shared preferences
  Future<void> _loadTasks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _todoList.addAll(pref.getStringList("tasks") ?? []);
    });
  }

  // Save string list to shared preferences
  Future<void> _saveTasks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList("tasks", _todoList);
  }

  void _addTask() {
    if (_textController.text.trim().isNotEmpty) {
      setState(() {
        _todoList.add(_textController.text.trim());
      });
      _textController.clear();
      _saveTasks();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
    _saveTasks();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List App"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: "Enter a new task...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  onPressed: _addTask,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _todoList.isEmpty
                  ? const Center(child: Text("No tasks added yet!"))
                  : ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(_todoList[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTask(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}