import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Profiles API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> _users = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users')).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        setState(() {
          _users = decodedData.map((json) => User.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw HttpException('Server responded with status code ${response.statusCode}');
      }
    } on SocketException {
      setState(() {
        _errorMessage = 'No Internet connection. Please check your network.';
        _isLoading = false;
      });
    } on HttpException catch (e) {
      setState(() {
        _errorMessage = 'Failed to find the data: ${e.message}';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API User Directory'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          key: const ValueKey('error-state'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _fetchUsers,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple.shade50,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(user.email),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TASK 2: Navigate to User Profile Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(user: user),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// TASK 2: User Profile Screen
class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'avatar-${user.id}',
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.deepPurple.shade50,
                  backgroundImage: NetworkImage(user.avatarUrl),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                user.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '@${user.username}',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              // Details List
              _buildProfileRow(Icons.email, 'Email', user.email),
              _buildProfileRow(Icons.phone, 'Phone', user.phone),
              _buildProfileRow(Icons.web, 'Website', user.website),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}