import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sa_library_page.dart';
import 'post_thread_page.dart';

class CommunityPage extends StatefulWidget {
  final String? prefilledPost;
  
  const CommunityPage({super.key, this.prefilledPost});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
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
    // Initialize controller with prefilled text if available
    _postController = TextEditingController(text: widget.prefilledPost);
  }
  
  @override
  void dispose() {
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
      body: Stack(
        children: [
          // Main content - Post list
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Community header with points
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "The Yodan Army",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    //   decoration: BoxDecoration(
                    //     color: Colors.deepPurple.withOpacity(0.1),
                    //     borderRadius: BorderRadius.circular(16),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       const Icon(
                    //         Icons.stars,
                    //         color: Colors.deepPurple,
                    //         size: 18,
                    //       ),
                    //       const SizedBox(width: 4),
                    //       Text(
                    //         '$_userPoints points',
                    //         style: const TextStyle(
                    //           color: Colors.deepPurple,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              
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
                                  commentsCount: 0,
                                ));
                                _postController.clear();
                              });
                            }
                            
                            Get.snackbar(
                              'Success',
                              'Your post has been shared with the community!',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green[100], // Solid light green background
                              colorText: Colors.green[800], // Dark green text for contrast
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
              
              // Bottom padding to make room for the floating button
              const SizedBox(height: 80),
            ],
          ),
          
          // Support Assistant floating button - updated to navigate to SA Library
          Positioned(
            left: 20,
            bottom: 20,
            child: FloatingActionButton.extended(
              onPressed: _navigateToSALibrary,
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.message),
              label: const Text(
                'SA',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
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
