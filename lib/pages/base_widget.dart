import 'package:flutter/material.dart';
import 'package:mentalsustainability/pages/Home/home_page.dart';
import '../services/auth_service.dart';
import 'Profile/profile_page.dart';
import 'Community/community_page.dart';
import 'Quests/quest_page.dart';
import 'package:mentalsustainability/pages/guide_page.dart';

class BaseScreen extends StatefulWidget{
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final AuthService _authService = AuthService();
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  
  @override
  void initState(){
    super.initState();
  }

  // Default selected index is Home (0)
  int _selectedIndex = 0;
  
  void _onItemTapped(int index) {
    // Limit index to 0-3
    if (index > 3) return;
    
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    
    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isDarkMode 
          ? 'Dark mode enabled' 
          : 'Light mode enabled'),
        duration: const Duration(seconds: 2),
      ),
    );
    
    // TODO: Implement actual dark mode theme switching
  }
  
  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
    
    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_notificationsEnabled 
          ? 'Notifications enabled' 
          : 'Notifications disabled'),
        duration: const Duration(seconds: 2),
      ),
    );
    
    // TODO: Implement actual notification preference saving
  }
  
  void _retakeOnboardingQuiz() {
    // TODO: Implement navigation to onboarding quiz
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Starting onboarding quiz...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.deepPurple),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: null, // No title in the middle
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded , color: Colors.deepPurple, size: 32),
            onPressed: () {
              // Navigate to the guide page when help icon is tapped
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const GuidePage())
              );
            },
          )
        ],
      ),
      
      // Add drawer with the specified features
      drawer: _buildDrawer(),

      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          // Home Page
          const HomePage(),
          
          // Quests Page
          const QuestPage(),
          
          // Community Page
          const CommunityPage(),
          
          // Profile Page
          const ProfilePage(),
        ],
      ),
      
      //Bottom Navigation Bar:
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedIconTheme: const IconThemeData(color: Colors.deepPurple),
        iconSize: 34,
        selectedItemColor: const Color.fromARGB(255, 248, 213, 16),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0, 
        items: const <BottomNavigationBarItem>[
          // Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          
          // Quests
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: "Quests",
          ),
          
          // Community
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Community',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
  
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SustaBit Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Customize your experience',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Retake onboarding quiz
          ListTile(
            leading: const Icon(Icons.replay, color: Colors.deepPurple),
            title: const Text('Retake Onboarding Quiz'),
            onTap: () {
              Navigator.pop(context); // Close the drawer first
              _retakeOnboardingQuiz();
            },
          ),
          
          const Divider(),
          
          // Dark mode toggle
          SwitchListTile(
            secondary: Icon(
              _isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.deepPurple,
            ),
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: _toggleDarkMode,
          ),
          
          // Notifications toggle
          SwitchListTile(
            secondary: Icon(
              _notificationsEnabled ? Icons.notifications_active : Icons.notifications_off,
              color: Colors.deepPurple,
            ),
            title: const Text('Notifications'),
            value: _notificationsEnabled,
            onChanged: _toggleNotifications,
          ),
          
          const Divider(),
          
          // Guide
          ListTile(
            leading: const Icon(Icons.menu_book, color: Colors.deepPurple),
            title: const Text('User Guide'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to user guide
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening user guide...')),
              );
            },
          ),
          
          // Privacy
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.deepPurple),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to privacy policy
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening privacy policy...')),
              );
            },
          ),
          
          // About
          ListTile(
            leading: const Icon(Icons.info, color: Colors.deepPurple),
            title: const Text('About SustaBit'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to about page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening about page...')),
              );
            },
          ),
          
          const Divider(),
          
          // Sign out (optional)
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement sign out functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signing out...')),
              );
            },
          ),
        ],
      ),
    );
  }
}


