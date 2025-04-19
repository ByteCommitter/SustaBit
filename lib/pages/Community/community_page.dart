import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sa_library_page.dart';
import 'post_thread_page.dart';
import 'sa_chat_page.dart'; // Add this import

class CommunityPage extends StatefulWidget {
  final String? prefilledPost;
  
  const CommunityPage({super.key, this.prefilledPost});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with SingleTickerProviderStateMixin {
  // Add TabController for managing tabs
  late TabController _tabController;
  
  // Add text controller for post content
  late TextEditingController _postController;
  
  // Add a map to track posts that the user has already liked
  final Map<String, bool> _likedPosts = {};
  
  // Add a map to track posts that the user has saved
  final Map<String, bool> _savedPosts = {};
  
  // Track total user points
  int _userPoints = 0;

  final List<CommunityPost> _posts = [
    CommunityPost(
      id: '1',
      username: 'DuckMyHeader42',
      content: 'Just completed a 7-day mindfulness streak. Feeling much more centered and focused!',
      timeAgo: '2h ago',
      likesCount: 15,
      commentsCount: 3,
      comments: [
        Comment(
          username: 'MindfulnessFan',
          content: 'That\'s awesome! Did you notice any specific improvements?',
          timeAgo: '1h ago',
        ),
        Comment(
          username: 'ZenMaster',
          content: 'I\'ve been wanting to try this. Any tips for beginners?',
          timeAgo: '45m ago',
        ),
        Comment(
          username: 'DuckMyHeader42',
          content: 'Start small with just 5 minutes a day. Consistency is key!',
          timeAgo: '30m ago',
        ),
      ],
    ),
    CommunityPost(
      id: '2',
      username: 'CalmMind88',
      content: 'Completed my Quests for the Week - planter project using repurposed plastic bottles. Small steps toward sustainability!',
      timeAgo: '5h ago',
      likesCount: 24,
      commentsCount: 4,
      imageUrl: 'assets/images/repurposed_plastic.png',
      comments: [
        Comment(
          username: 'GreenThumb',
          content: 'This looks amazing! What kind of plants did you put in them?',
          timeAgo: '4h ago',
        ),
        Comment(
          username: 'EcoWarrior',
          content: 'Great job repurposing! Did you have any issues with drainage?',
          timeAgo: '3h ago',
        ),
        Comment(
          username: 'CalmMind88',
          content: 'Thanks! I used herbs for the kitchen and added small holes at the bottom for drainage.',
          timeAgo: '2h ago',
        ),
        Comment(
          username: 'PlantLover22',
          content: 'I\'m totally going to try this over the weekend!',
          timeAgo: '1h ago',
        ),
      ],
    ),
    CommunityPost(
      id: '3',
      username: 'SerenitySeeker',
      content: 'I found this amazing resource for free guided meditations. Highly recommend for anyone looking to start meditation: https://example.com/meditations',
      timeAgo: '1d ago',
      likesCount: 42,
      commentsCount: 5,
      comments: [
        Comment(
          username: 'MeditationNewbie',
          content: 'Thanks for sharing! Just tried the beginner one and it was perfect.',
          timeAgo: '20h ago',
        ),
        Comment(
          username: 'AnxietyFighter',
          content: 'Do they have any specific ones for anxiety?',
          timeAgo: '18h ago',
        ),
        Comment(
          username: 'SerenitySeeker',
          content: 'Yes! Check the "Anxiety Relief" section. There are 5-minute quick ones and longer sessions.',
          timeAgo: '17h ago',
        ),
        Comment(
          username: 'AnxietyFighter',
          content: 'Found them, thank you so much!',
          timeAgo: '16h ago',
        ),
        Comment(
          username: 'SleepStruggler',
          content: 'The sleep meditations changed my life. I\'ve been sleeping better for the first time in years.',
          timeAgo: '12h ago',
        ),
      ],
    ),
    CommunityPost(
      id: '4',
      username: 'MentalHealthMatters',
      content: 'Reminder: It\'s okay to take breaks. Sometimes the most productive thing you can do is rest.',
      timeAgo: '2d ago',
      likesCount: 0,
      commentsCount: 15,
      comments: [],
    ),
    CommunityPost(
      id: '5',
      username: 'WellnessJourney',
      content: 'Just had a great therapy session today. If you\'ve been thinking about trying therapy, this is your sign to give it a shot!',
      timeAgo: '3d ago',
      likesCount: 0,
      commentsCount: 6,
      comments: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize tab controller with 3 tabs
    _tabController = TabController(length: 3, vsync: this);
    
    // Initialize controller with prefilled text if available
    _postController = TextEditingController(text: widget.prefilledPost);
    
    // If post is prefilled, ensure we start on the Threads tab
    if (widget.prefilledPost != null && widget.prefilledPost!.isNotEmpty) {
      _tabController.animateTo(0); // Switch to Threads tab
    }
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _postController.dispose();
    super.dispose();
  }

  void _navigateToSALibrary() {
    Get.to(() => const SALibraryPage());
  }

  void _handleLike(String postId) {
    // Toggle like status
    if (_likedPosts[postId] ?? false) {
      _likedPosts[postId] = false;
      setState(() {
        final postIndex = _posts.indexWhere((post) => post.id == postId);
        if (postIndex != -1) {
          _posts[postIndex] = _posts[postIndex].copyWith(
            likesCount: _posts[postIndex].likesCount - 1
          );
        }
      });
    } else {
      _likedPosts[postId] = true;
      setState(() {
        final postIndex = _posts.indexWhere((post) => post.id == postId);
        if (postIndex != -1) {
          _posts[postIndex] = _posts[postIndex].copyWith(
            likesCount: _posts[postIndex].likesCount + 1
          );
        }
      });
      
      // Show appreciation message for likes
      Get.snackbar(
        'Thanks for the Love!',
        'Your support means a lot to the community.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.pink[100],
        colorText: Colors.pink[800],
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    }
  }
  
  void _toggleSavePost(String postId) {
    setState(() {
      _savedPosts[postId] = !(_savedPosts[postId] ?? false);
    });
    
    // Show confirmation for saved/unsaved
    Get.snackbar(
      _savedPosts[postId]! ? 'Post Saved' : 'Post Unsaved',
      _savedPosts[postId]! 
        ? 'You can find this post in your saved collection.'
        : 'This post has been removed from your saved collection.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: _savedPosts[postId]! ? Colors.blue[100] : Colors.grey[200],
      colorText: _savedPosts[postId]! ? Colors.blue[800] : Colors.grey[800],
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }
  
  void _openPostThread(CommunityPost post) {
    Get.to(() => PostThreadPage(post: post));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Community header with tabs
          Container(
            color: Colors.white,
            child: Column(
              children: [
                // App bar with title - search button removed
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      const Text(
                        "Community",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Search button removed
                    ],
                  ),
                ),
                
                // Tab bar
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.deepPurple,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.deepPurple,
                  tabs: const [
                    Tab(text: "Threads"),
                    Tab(text: "Sereine Team"),
                    Tab(text: "Seremate"),
                  ],
                ),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Threads Tab
                _buildThreadsTab(),
                
                // Sereine Team Tab
                _buildSereineTeamTab(),
                
                // Seremate Tab
                _buildSeremateTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build the Threads tab content (current community functionality)
  Widget _buildThreadsTab() {
    return Stack(
      children: [
        // Main content - Post list
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Post creation card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Share with the community',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _postController, // Use the controller
                      decoration: InputDecoration(
                        hintText: 'What\'s on your mind?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add the new post to the top of the list
                          if (_postController.text.isNotEmpty) {
                            setState(() {
                              _posts.insert(0, CommunityPost(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                username: 'You',
                                content: _postController.text,
                                timeAgo: 'Just now',
                                likesCount: 0,
                                commentsCount: 0,
                                comments: [],
                              ));
                              _postController.clear();
                            });
                          }
                          
                          Get.snackbar(
                            'Success',
                            'Your post has been shared with the community!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green[100],
                            colorText: Colors.green[800],
                            margin: const EdgeInsets.all(16),
                            borderRadius: 8,
                            duration: const Duration(seconds: 3),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Post'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Community posts
            ..._posts.map((post) => _buildPostCard(post)),
            
            // Bottom padding
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  // Build the Sereine Team tab content (SA Team connection)
  Widget _buildSereineTeamTab() {
    return Column(
      children: [
        // Header section
        Container(
          padding: const EdgeInsets.all(20),
          color: Colors.deepPurple.withOpacity(0.1),
          child: const Column(
            children: [
              Text(
                'The Human Library',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Our peers act as a human library, helping with mental health by listening and providing support to everyone on campus.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Click on a book to connect with a peer supporter',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Bookshelf with 3 rows of 3 books
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                // Row 1 of bookshelf
                _buildBookshelfRow(
                  [_saTeamMembers[0], _saTeamMembers[1], _saTeamMembers[2]],
                  Colors.brown.shade800,
                ),
                
                // Row 2 of bookshelf
                _buildBookshelfRow(
                  [_saTeamMembers[3], _saTeamMembers[4], _saTeamMembers[5]],
                  Colors.brown.shade700,
                ),
                
                // Row 3 of bookshelf
                _buildBookshelfRow(
                  [_saTeamMembers[6], _saTeamMembers[7], _saTeamMembers[8]],
                  Colors.brown.shade600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  // Helper method to build a row of the bookshelf
  Widget _buildBookshelfRow(List<SATeamMember> rowMembers, Color shelfColor) {
    return Expanded(
      child: Column(
        children: [
          // Books container
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: rowMembers.map((member) => _buildBook(member)).toList(),
            ),
          ),
          
          // Shelf
          Container(
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: shelfColor,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          
          // Space below shelf
          const SizedBox(height: 16),
        ],
      ),
    );
  }
  
  // Helper method to build an individual book
  Widget _buildBook(SATeamMember member) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          // Navigate to chat with this team member
          Get.to(() => SAChatPage(teamMember: member));
        },
        child: Container(
          width: 70,
          height: double.infinity,
          decoration: BoxDecoration(
            color: member.bookColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(6),
              bottomLeft: Radius.circular(2),
              bottomRight: Radius.circular(2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3,
                offset: const Offset(2, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rotated text for book spine
              RotatedBox(
                quarterTurns: 1, // Rotate 90 degrees
                child: Text(
                  member.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // Specialty text (smaller and also rotated)
              RotatedBox(
                quarterTurns: 1, // Rotate 90 degrees
                child: Text(
                  member.specialty,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the Seremate tab content (student connections)
  Widget _buildSeremateTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header with info button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Connect with Fellow Students",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.deepPurple),
              onPressed: () => _showSeremateInfoDialog(context),
              tooltip: "About Seremate",
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Activity-based connection options
        const Text(
          "How would you like to connect?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Grid of activity cards
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
          children: [
            _buildActivityCard(
              "Let's Chat",
              "Have a casual conversation about anything",
              Icons.chat_bubble_outline,
              Colors.blue,
            ),
            _buildActivityCard(
              "Go for a Walk",
              "Find a walking buddy around campus",
              Icons.directions_walk,
              Colors.green,
            ),
            _buildActivityCard(
              "Meal Together",
              "Share a meal at the cafeteria or nearby",
              Icons.restaurant,
              Colors.orange,
            ),
            _buildActivityCard(
              "Study Session",
              "Find someone to study with in the library",
              Icons.book,
              Colors.purple,
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // User preferences section
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Connection Preferences",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Available times
                const Text(
                  "I'm usually available:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTimeChip("Mornings", false),
                    _buildTimeChip("Afternoons", true),
                    _buildTimeChip("Evenings", true),
                    _buildTimeChip("Weekends", true),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Conversation topics
                const Text(
                  "Topics I enjoy discussing:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildInterestChip("Movies & TV", Colors.indigo),
                    _buildInterestChip("Music", Colors.pink),
                    _buildInterestChip("Sports", Colors.amber),
                    _buildInterestChip("Technology", Colors.blue),
                    _buildInterestChip("Art", Colors.teal),
                    _buildInterestChip("+ Add more", Colors.grey),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Update preferences button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.snackbar(
                        'Preferences Updated',
                        'Your connection preferences have been saved',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green[100],
                        colorText: Colors.green[800],
                        margin: const EdgeInsets.all(16),
                        borderRadius: 8,
                        duration: const Duration(seconds: 2),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Update Preferences'),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Active Seremates - modified to show ongoing conversations
        const Text(
          "Your Active Connections",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        // Sample connection in progress
        Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.teal.withOpacity(0.2),
                      child: const Text(
                        "A",
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Anonymous Student",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Studying: Computer Science",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.circle, size: 8, color: Colors.green[700]),
                          const SizedBox(width: 4),
                          Text(
                            "Online",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.restaurant, size: 16, color: Colors.orange[700]),
                    const SizedBox(width: 8),
                    const Text(
                      "Lunch at University Cafeteria",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.blue[700]),
                    const SizedBox(width: 8),
                    const Text(
                      "Today at 1:00 PM",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble_outline, size: 16),
                      label: const Text("Chat"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.snackbar(
                          'Meeting Confirmed',
                          'Your meetup has been confirmed. Enjoy!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green[100],
                          colorText: Colors.green[800],
                          margin: const EdgeInsets.all(16),
                          borderRadius: 8,
                          duration: const Duration(seconds: 3),
                        );
                      },
                      icon: const Icon(Icons.check_circle, size: 16),
                      label: const Text("Confirm Meeting"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        // Placeholder for when no active connections
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.people_outline, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text(
                "No other active connections",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Try joining an activity to meet more students",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Safety tips footer
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.05),
            border: Border.all(color: Colors.blue.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.shield, color: Colors.blue[700], size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    "Safety Tips",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "• Always meet in public, campus locations during daytime",
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 4),
              const Text(
                "• Share your meetup details with a trusted friend",
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 4),
              const Text(
                "• Report any concerns through the app immediately",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Show information dialog about Seremate
  void _showSeremateInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  "Finding connection in a sea of people",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Description
                const Text(
                  "Many students feel lonely despite being surrounded by others. Seremate helps you connect anonymously with fellow students for walks, meals, study sessions, or just conversations.",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                
                // Benefits
                Row(
                  children: [
                    Icon(Icons.check_circle, 
                      size: 16, 
                      color: Colors.green[700]
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        "Start anonymously, share contact info only when comfortable",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.check_circle, 
                      size: 16, 
                      color: Colors.green[700]
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        "Connect based on activities and shared interests",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.check_circle, 
                      size: 16, 
                      color: Colors.green[700]
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        "Meet in safe campus locations for peace of mind",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Close button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                    ),
                    child: const Text("Got it"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method for building activity cards
  Widget _buildActivityCard(String title, String description, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          'Looking for Matches',
          'We\'ll notify you when we find someone for: $title',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: color.withOpacity(0.1),
          colorText: color,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for building time preference chips
  Widget _buildTimeChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {},
      backgroundColor: Colors.grey[100],
      selectedColor: Colors.deepPurple.withOpacity(0.15),
      checkmarkColor: Colors.deepPurple,
      labelStyle: TextStyle(
        color: isSelected ? Colors.deepPurple : Colors.grey[800],
        fontSize: 12,
      ),
    );
  }

  // Helper method for building interest chips
  Widget _buildInterestChip(String label, Color color) {
    return Chip(
      label: Text(label),
      labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
  
  // Helper method for building team member cards
  Widget _buildTeamMemberCard(TeamMember member) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Profile image
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.deepPurple.withOpacity(0.2),
              child: Text(
                member.name.substring(0, 1),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Member details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    member.role,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    member.specialty,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            
            // Contact button
            IconButton(
              onPressed: () {
                Get.snackbar(
                  'Connecting',
                  'Opening chat with ${member.name}...',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green[100],
                  colorText: Colors.green[800],
                  margin: const EdgeInsets.all(16),
                  borderRadius: 8,
                  duration: const Duration(seconds: 3),
                );
              },
              icon: const Icon(Icons.chat_bubble_outline),
              color: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for building library category sections
  Widget _buildLibraryCategory({
    required String title,
    required IconData icon,
    required Color color,
    required List<ResourceItem> resources,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            
            // Resource items
            ...resources.map((resource) => _buildResourceItem(resource, color)),
          ],
        ),
      ),
    );
  }
  
  // Helper method for building individual resource items
  Widget _buildResourceItem(ResourceItem resource, Color categoryColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resource type icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: categoryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getResourceTypeIcon(resource.type),
              color: categoryColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          
          // Resource details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resource.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  resource.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        resource.type,
                        style: TextStyle(
                          fontSize: 11,
                          color: categoryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.access_time, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      resource.duration,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Access button
          IconButton(
            onPressed: () {
              // Access the resource
              Get.snackbar(
                'Opening Resource',
                'Loading ${resource.title}...',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.blue[100],
                colorText: Colors.blue[800],
                margin: const EdgeInsets.all(16),
                borderRadius: 8,
                duration: const Duration(seconds: 2),
              );
            },
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
  
  // Helper method to get appropriate icon for resource type
  IconData _getResourceTypeIcon(String type) {
    switch (type) {
      case 'Guide': return Icons.menu_book;
      case 'Article': return Icons.article;
      case 'Audio': return Icons.headphones;
      case 'Video': return Icons.video_library;
      case 'Workshop': return Icons.build;
      case 'Info': return Icons.info;
      default: return Icons.description;
    }
  }

  Widget _buildPostCard(CommunityPost post) {
    final bool isLiked = _likedPosts[post.id] ?? false;
    final bool isSaved = _savedPosts[post.id] ?? false;
    
    return GestureDetector(
      onTap: () => _openPostThread(post),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Post header
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple.withOpacity(0.2),
                    child: Text(
                      post.username.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        post.timeAgo,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Post content
              Text(post.content),
              
              // Post image (if available)
              if (post.imageUrl != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      post.imageUrl!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              
              // Post actions with hearts and save
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Heart/Like button
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _handleLike(post.id),
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : null,
                        ),
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                      ),
                      const SizedBox(width: 4),
                      Text('${post.likesCount}'),
                    ],
                  ),
                  
                  // Comments
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _openPostThread(post),
                        icon: const Icon(Icons.comment_outlined),
                        color: Colors.blue,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                      ),
                      const SizedBox(width: 4),
                      Text('${post.commentsCount}'),
                    ],
                  ),
                  
                  // Share
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    iconSize: 20,
                  ),
                  
                  // Save post
                  IconButton(
                    onPressed: () => _toggleSavePost(post.id),
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: isSaved ? Colors.deepPurple : null,
                    ),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    iconSize: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommunityPost {
  final String id;
  final String username;
  final String content;
  final String timeAgo;
  final int likesCount;
  final int commentsCount;
  final String? imageUrl;
  final List<Comment> comments;

  CommunityPost({
    required this.id,
    required this.username,
    required this.content,
    required this.timeAgo,
    this.likesCount = 0,
    required this.commentsCount,
    this.imageUrl,
    this.comments = const [],
  });

  // Add copyWith method for updating post properties
  CommunityPost copyWith({
    String? id,
    String? username,
    String? content,
    String? timeAgo,
    int? likesCount,
    int? commentsCount,
    String? imageUrl,
    List<Comment>? comments,
  }) {
    return CommunityPost(
      id: id ?? this.id,
      username: username ?? this.username,
      content: content ?? this.content,
      timeAgo: timeAgo ?? this.timeAgo,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      imageUrl: imageUrl ?? this.imageUrl,
      comments: comments ?? this.comments,
    );
  }
}

class Comment {
  final String username;
  final String content;
  final String timeAgo;

  Comment({
    required this.username,
    required this.content,
    required this.timeAgo,
  });
}

// New class for Sereine Team Members
class TeamMember {
  final String name;
  final String role;
  final String specialty;
  final String? imageUrl; // Optional profile image

  TeamMember({
    required this.name,
    required this.role,
    required this.specialty,
    this.imageUrl,
  });
}

// Sample team members data
final List<TeamMember> sereineTeamMembers = [
  TeamMember(
    name: "Dr. Sarah Williams",
    role: "Mental Health Specialist",
    specialty: "Specializes in anxiety, stress management, and mindfulness",
  ),
  TeamMember(
    name: "Alex Rodriguez",
    role: "Sustainability Advisor",
    specialty: "Expert in sustainable living practices and eco-friendly habits",
  ),
  TeamMember(
    name: "Jamie Chen",
    role: "Student Support Coordinator",
    specialty: "Helps with academic challenges and campus resources",
  ),
];

// New class for library resources
class ResourceItem {
  final String title;
  final String description;
  final String type; // Guide, Article, Audio, Video, etc.
  final String duration;
  
  ResourceItem({
    required this.title,
    required this.description,
    required this.type,
    required this.duration,
  });
}

// Adding the SATeamMember class and data to community_page.dart
// for direct use in the Sereine Team tab
class SATeamMember {
  final String id;
  final String name;
  final String specialty;
  final String bio;
  final Color bookColor;
  final List<String> presetMessages;

  const SATeamMember({
    required this.id,
    required this.name,
    required this.specialty,
    required this.bio,
    required this.bookColor,
    required this.presetMessages,
  });
}

// Team members data - same as in sa_library_page.dart
final List<SATeamMember> _saTeamMembers = [
  SATeamMember(
    id: 'sa1',
    name: 'Alisa',
    specialty: 'Anxiety & Stress',
    bio: 'Peer supporter with experience helping fellow students manage anxiety and stress.',
    bookColor: Colors.deepPurple,
    presetMessages: [
      "Hi there! I'm Alisa. How can I support you today?",
      "Remember that feeling anxious is a normal response to stress. Let's talk about it.",
      "Would you like to learn some breathing techniques that can help in moments of stress?",
    ],
  ),
  SATeamMember(
    id: 'sa2',
    name: 'Rohan',
    specialty: 'Peer Support',
    bio: 'Student who has personal experience with overcoming depression and wants to help others.',
    bookColor: Colors.teal,
    presetMessages: [
      "Hey! I'm Rohan. I'm here to listen without judgment.",
      "As someone who's been through similar struggles, I understand how overwhelming things can get.",
      "Would you like to share what's been on your mind lately?",
    ],
  ),
  SATeamMember(
    id: 'sa3',
    name: 'Misha',
    specialty: 'Academic Pressure',
    bio: 'Student mentor specializing in helping peers navigate academic stress and expectations.',
    bookColor: Colors.indigo,
    presetMessages: [
      "Hi, I'm Misha. Feeling overwhelmed with coursework?",
      "Let's discuss some strategies to balance your academic responsibilities.",
      "Remember that your worth isn't determined by your grades or achievements.",
    ],
  ),
  SATeamMember(
    id: 'sa4',
    name: 'Jorge',
    specialty: 'Grief & Loss',
    bio: 'Peer supporter trained to help individuals process grief and navigate significant life changes.',
    bookColor: Colors.amber.shade800,
    presetMessages: [
      "Hello, I'm Jorge. I create a safe space for discussing difficult emotions.",
      "Grief can come in many forms. How has your experience been?",
      "It's okay to not be okay. I'm here to support you through this process.",
    ],
  ),
  SATeamMember(
    id: 'sa5',
    name: 'Neela',
    specialty: 'Cultural Adaptation',
    bio: 'International student who helps peers navigate cultural transitions and identity challenges.',
    bookColor: Colors.pink.shade700,
    presetMessages: [
      "Hi, I'm Neela. Adjusting to a new environment can be challenging.",
      "I'd love to hear about your experiences and how you've been coping.",
      "What aspects of the transition have been most difficult for you?",
    ],
  ),
  SATeamMember(
    id: 'sa6',
    name: 'Danny',
    specialty: 'LGBTQ+ Support',
    bio: 'Student advocate for LGBTQ+ peers, focusing on identity, acceptance, and community building.',
    bookColor: Colors.blue.shade800,
    presetMessages: [
      "Hello! I'm Danny. This is a judgment-free zone where you can be yourself.",
      "How have you been feeling about your identity and place in the community?",
      "Would you like to discuss resources or support groups available on campus?",
    ],
  ),
  SATeamMember(
    id: 'sa7',
    name: 'Layla',
    specialty: 'Relationship Issues',
    bio: 'Peer supporter trained in interpersonal relationships, communication skills, and boundary setting.',
    bookColor: Colors.red.shade700,
    presetMessages: [
      "Hi, I'm Layla. Navigating relationships can be complex.",
      "How have your connections with others been affecting your well-being?",
      "Let's talk about healthy boundaries and communication strategies.",
    ],
  ),
  SATeamMember(
    id: 'sa8',
    name: 'Kevin',
    specialty: 'Substance Use',
    bio: 'Student who provides non-judgmental support for peers dealing with substance use concerns.',
    bookColor: Colors.green.shade800,
    presetMessages: [
      "Hey there, I'm Kevin. I'm here to listen and support, not to judge.",
      "Would you like to talk about how substance use has been impacting your life?",
      "There are many paths to wellness. Let's explore what might work for you.",
    ],
  ),
  SATeamMember(
    id: 'sa9',
    name: 'Sonia',
    specialty: 'Self-Esteem',
    bio: 'Peer mentor focused on building self-worth, resilience, and personal strengths.',
    bookColor: Colors.purple.shade800,
    presetMessages: [
      "Hello! I'm Sonia. I believe in your inherent worth and potential.",
      "How has your relationship with yourself been lately?",
      "Let's explore the unique strengths you possess that you might not fully recognize yet.",
    ],
  ),
];
