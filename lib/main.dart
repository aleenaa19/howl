import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(HowlApp());
}

class HowlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOWL',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFFF6B35),
        scaffoldBackgroundColor: Color(0xFF1A1A1A),
      ),
      home: AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// AUTHENTICATION SCREEN
class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _signupNameController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();

  Map<String, String> currentUser = {};

  void _login() {
    if (_loginEmailController.text.isNotEmpty &&
        _loginPasswordController.text.isNotEmpty) {
      setState(() {
        currentUser = {
          'name': _loginEmailController.text.split('@')[0],
          'email': _loginEmailController.text
        };
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => AddMembersScreen(currentUser: currentUser)));
    } else {
      _showAlert('Please enter both email and password');
    }
  }

  void _signup() {
    if (_signupNameController.text.isNotEmpty &&
        _signupEmailController.text.isNotEmpty &&
        _signupPasswordController.text.isNotEmpty) {
      setState(() {
        currentUser = {
          'name': _signupNameController.text,
          'email': _signupEmailController.text
        };
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => AddMembersScreen(currentUser: currentUser)));
    } else {
      _showAlert('Please fill in all fields');
    }
  }

  void _showAlert(String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Alert'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width: 400,
          decoration: BoxDecoration(
            color: Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'HOWL',
                style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFFFF6B35),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Connect with your pack. Ride as one.',
                style: TextStyle(color: Colors.grey[400]),
              ),
              SizedBox(height: 20),
              if (isLogin) ...[
                TextField(
                  controller: _loginEmailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Color(0xFF1A1A1A),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _loginPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Color(0xFF1A1A1A),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF6B35),
                      minimumSize: Size(double.infinity, 50)),
                  child: Text('Sign In'),
                ),
                TextButton(
                    onPressed: () => setState(() => isLogin = false),
                    child: Text('Don\'t have an account? Sign up',
                        style: TextStyle(color: Colors.orange))),
              ] else ...[
                TextField(
                  controller: _signupNameController,
                  decoration: InputDecoration(
                      hintText: 'Full Name',
                      filled: true,
                      fillColor: Color(0xFF1A1A1A),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _signupEmailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Color(0xFF1A1A1A),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _signupPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Color(0xFF1A1A1A),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF6B35),
                      minimumSize: Size(double.infinity, 50)),
                  child: Text('Create Account'),
                ),
                TextButton(
                    onPressed: () => setState(() => isLogin = true),
                    child: Text('Already have an account? Sign in',
                        style: TextStyle(color: Colors.orange))),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ADD MEMBERS SCREEN
class AddMembersScreen extends StatefulWidget {
  final Map<String, String> currentUser;

  AddMembersScreen({required this.currentUser});

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  List<Map<String, String>> availableRiders = [
    {'name': 'Alpha Wolf', 'email': 'alpha@howl.com'},
    {'name': 'Beta Rider', 'email': 'beta@howl.com'},
    {'name': 'Gamma Biker', 'email': 'gamma@howl.com'},
    {'name': 'Delta Cruiser', 'email': 'delta@howl.com'},
    {'name': 'Epsilon Rider', 'email': 'epsilon@howl.com'},
    {'name': 'Zeta Explorer', 'email': 'zeta@howl.com'},
    {'name': 'Theta Adventurer', 'email': 'theta@howl.com'},
    {'name': 'Sigma Traveler', 'email': 'sigma@howl.com'},
  ];

  Set<int> addedIndexes = {};
  final _searchController = TextEditingController();
  List<int> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults = List.generate(availableRiders.length, (index) => index);
  }

  void _addMember(int index) {
    setState(() {
      addedIndexes.add(index);
    });
  }

  void _removeMember(int index) {
    setState(() {
      addedIndexes.remove(index);
    });
  }

  void _search(String query) {
    setState(() {
      searchResults = [];
      for (int i = 0; i < availableRiders.length; i++) {
        final rider = availableRiders[i];
        if (rider['name']!.toLowerCase().contains(query.toLowerCase()) ||
            rider['email']!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(i);
        }
      }
    });
  }

  void _proceedToGroup() {
    if (addedIndexes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Add at least one member!')));
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => GroupScreen(
                members:
                    addedIndexes.map((i) => availableRiders[i]).toList())));
  }

  Color _randomColor(int index) {
    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.purple,
      Colors.cyan,
      Colors.amber,
      Colors.pink
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pack Members'),
        backgroundColor: Color(0xFF2D2D2D),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                  hintText: 'Search riders by name or email',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Color(0xFF1A1A1A),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, i) {
                    final index = searchResults[i];
                    final rider = availableRiders[index];
                    final isAdded = addedIndexes.contains(index);
                    return ListTile(
                      title: Text(rider['name']!),
                      subtitle: Text(rider['email']!),
                      trailing: ElevatedButton(
                        onPressed: isAdded
                            ? () => _removeMember(index)
                            : () => _addMember(index),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: isAdded
                                ? Colors.grey
                                : Color(0xFFFF6B35)),
                        child: Text(isAdded ? 'Added' : 'Add'),
                      ),
                    );
                  })),
          Padding(
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: _proceedToGroup,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6B35),
                  minimumSize: Size(double.infinity, 50)),
              child: Text('Proceed'),
            ),
          )
        ],
      ),
    );
  }
}

// GROUP SCREEN
class GroupScreen extends StatelessWidget {
  final List<Map<String, String>> members;

  GroupScreen({required this.members});

  Color _randomColor(int index) {
    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.purple,
      Colors.cyan,
      Colors.amber,
      Colors.pink
    ];
    return colors[index % colors.length];
  }

  String _getInitials(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return parts[0][0] + parts[1][0];
    } else {
      return name.substring(0, min(2, name.length));
    }
  }

  void _startRide(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Ride Started! 🐺')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Pack'),
        backgroundColor: Color(0xFF2D2D2D),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, i) {
                  final member = members[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _randomColor(i),
                      child: Text(_getInitials(member['name']!)),
                    ),
                    title: Text(member['name']!),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () => _startRide(context),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6B35),
                  minimumSize: Size(double.infinity, 50)),
              child: Text('Start Ride'),
            ),
          )
        ],
      ),
    );
  }
}
