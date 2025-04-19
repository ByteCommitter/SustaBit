import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.deepPurple.shade50],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.psychology, 
                        color: Colors.white, 
                        size: 32,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Sereine',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Mental wellness, simplified',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            // Take Personalised Quiz (renamed from "Retake Onboarding Quiz")
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.quiz, color: Colors.amber),
              ),
              title: const Text('Take Personalised Quiz'),
              subtitle: const Text('Customize your experience'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                _retakeOnboardingQuiz();
              },
            ),
            
            const Divider(),
            
            // Dark mode toggle - styled
            SwitchListTile(
              secondary: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Colors.purple,
                ),
              ),
              title: const Text('Dark Mode'),
              subtitle: Text(_isDarkMode ? 'Switch to light theme' : 'Switch to dark theme'),
              value: _isDarkMode,
              onChanged: _toggleDarkMode,
            ),
            
            // Notifications toggle - styled
            SwitchListTile(
              secondary: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _notificationsEnabled ? Icons.notifications_active : Icons.notifications_off,
                  color: Colors.blue,
                ),
              ),
              title: const Text('Notifications'),
              subtitle: Text(_notificationsEnabled ? 'Notifications are enabled' : 'Notifications are disabled'),
              value: _notificationsEnabled,
              onChanged: _toggleNotifications,
            ),
            
            const Divider(),
            
            // Section header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                'HELP & INFORMATION',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Guide - styled
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.menu_book, color: Colors.green),
              ),
              title: const Text('User Guide'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const GuidePage())
                );
              },
            ),
            
            // Privacy - styled
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.privacy_tip, color: Colors.indigo),
              ),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening privacy policy...')),
                );
              },
            ),
            
            // About - styled
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.info, color: Colors.teal),
              ),
              title: const Text('About Sereine'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening about page...')),
                );
              },
            ),
            
            const Divider(),
            
            // Sign out - styled
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton.icon(
                icon: const Icon(Icons.logout, size: 18),
                label: const Text('Sign Out'),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Signing out...')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red[700],
                  side: BorderSide(color: Colors.red[200]!),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            
            const Divider(),
            
            // Developer section (only for demo purposes)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                'DEVELOPER OPTIONS',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Moderator mode toggle
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.admin_panel_settings, color: Colors.red),
              ),
              title: const Text('Moderator Mode (Demo)'),
              subtitle: const Text('View community with moderator permissions'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                
                // Navigate to the community page with moderator permissions
                Get.to(() => const CommunityPage(isModerator: true));
              },
            ),
          ],
        ),
      ),
    );
  }
}


