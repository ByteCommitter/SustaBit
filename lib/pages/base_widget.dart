import 'package:flutter/material.dart';
import 'package:mentalsustainability/pages/Home/home_page.dart';
import '../services/auth_service.dart';
import 'Profile/profile_page.dart';
import 'Community/community_page.dart';
import 'Quests/quest_page.dart';

class BaseScreen extends StatefulWidget{
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final AuthService _authService = AuthService();
  
  @override
  void initState(){
    super.initState();
  }

  // Default selected index is Home (0)
  int _selectedIndex = 0;
  
  void _onItemTapped(int index) {
    // Limit index to 0-2 since we've temporarily removed Profile tab
    if (index > 3) return;
    
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.deepPurple),
          onPressed: () {
            // Drawer functionality will be added later
          },
        ),
        title: null, // No title in the middle
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded , color: Colors.deepPurple,size: 32,),
            onPressed: () {
              // Question mark functionality will be added later
            },
          )
        ],
      ),

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
}


