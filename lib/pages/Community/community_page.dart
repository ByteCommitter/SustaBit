import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sa_library_page.dart';

class CommunityPage extends StatefulWidget {
  final String? prefilledPost;
  
  const CommunityPage({super.key, this.prefilledPost});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  // Add text controller for post content
  late TextEditingController _postController;
  
  // Add a map to track posts that the user has already voted on
  final Map<String, bool> _votedPosts = {};
  
  // Track total user points
  int _userPoints = 0;

  final List<CommunityPost> _posts = [
    CommunityPost(
      id: '1',
      username: 'DuckMyHeader42',
      content: 'Just completed a 7-day mindfulness streak. Feeling much more centered and focused!',
      timeAgo: '2h ago',
      likesCount: 15,
      downvotesCount: 1,
      commentsCount: 3,
    ),
    CommunityPost(
      id: '2',
      username: 'CalmMind88',
      content: 'Completed my Quests for the Week - planter project using repurposed plastic bottles. Small steps toward sustainability!',
      timeAgo: '5h ago',
      likesCount: 24,
      downvotesCount: 2,
      commentsCount: 12,
      imageUrl: 'assets/images/repurposed_plastic.png',
    ),
    CommunityPost(
      id: '3',
      username: 'SerenitySeeker',
      content: 'I found this amazing resource for free guided meditations. Highly recommend for anyone looking to start meditation: https://example.com/meditations',
      timeAgo: '1d ago',
      likesCount: 42,
      downvotesCount: 3,
      commentsCount: 7,
    ),
    CommunityPost(
      id: '4',
      username: 'MentalHealthMatters',
      content: 'Reminder: It\'s okay to take breaks. Sometimes the most productive thing you can do is rest.',
      timeAgo: '2d ago',
      likesCount: 105,
      downvotesCount: 8,
      commentsCount: 15,
    ),
    CommunityPost(
      id: '5',
      username: 'WellnessJourney',
      content: 'Just had a great therapy session today. If you\'ve been thinking about trying therapy, this is your sign to give it a shot!',
      timeAgo: '3d ago',
      likesCount: 27,
      downvotesCount: 2,
      commentsCount: 6,
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

  // Handle post voting
  void _handleVote(String postId, bool isUpvote) {
    // If user has already voted on this post, don't award points again
    if (_votedPosts.containsKey(postId)) {
      Get.snackbar(
        'Already Voted',
        'You have already voted on this post',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange[100], // Solid light orange background
        colorText: Colors.orange[800], // Dark orange text for contrast
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
      return;
    }
    
    // Mark post as voted
    _votedPosts[postId] = true;
    
    // Update post likes/downvotes
    setState(() {
      final postIndex = _posts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        if (isUpvote) {
          _posts[postIndex] = _posts[postIndex].copyWith(
            likesCount: _posts[postIndex].likesCount + 1
          );
        } else {
          _posts[postIndex] = _posts[postIndex].copyWith(
            downvotesCount: _posts[postIndex].downvotesCount + 1
          );
        }
      }
      
      // Award points to the current user for voting
      _userPoints += 3;
    });
    
    // Show point notification with solid background
    Get.snackbar(
      '+3 Points',
      'You earned 3 points for ${isUpvote ? "upvoting" : "downvoting"} content!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green[100], // Solid light green background
      colorText: Colors.green[800], // Dark green text for contrast
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
    
    // If it's an upvote, inform about the poster earning points with solid background
    if (isUpvote) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.snackbar(
          'Community Impact',
          'The poster earned 10 points from your upvote!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue[100], // Solid light blue background
          colorText: Colors.blue[800], // Dark blue text for contrast
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );
      });
    }
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
                                  likesCount: 0,
                                  downvotesCount: 0,
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
    return Card(
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
            
            // Post actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Likes
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _handleVote(post.id, true),
                      icon: const Icon(Icons.thumb_up_outlined),
                      color: Colors.green,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      iconSize: 20,
                    ),
                    const SizedBox(width: 4),
                    Text('${post.likesCount}'),
                  ],
                ),
                
                // Downvotes
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _handleVote(post.id, false),
                      icon: const Icon(Icons.thumb_down_outlined),
                      color: Colors.red,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      iconSize: 20,
                    ),
                    const SizedBox(width: 4),
                    Text('${post.downvotesCount}'),
                  ],
                ),
                
                // Comments
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
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
              ],
            ),
          ],
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
  final int downvotesCount;  // Added downvotes count
  final int commentsCount;
  final String? imageUrl;    // Optional image URL for posts with images

  CommunityPost({
    required this.id,
    required this.username,
    required this.content,
    required this.timeAgo,
    required this.likesCount,
    required this.commentsCount,
    this.downvotesCount = 0,  // Default value
    this.imageUrl,            // Optional parameter
  });

  // Add copyWith method for updating post properties
  CommunityPost copyWith({
    String? id,
    String? username,
    String? content,
    String? timeAgo,
    int? likesCount,
    int? downvotesCount,
    int? commentsCount,
    String? imageUrl,
  }) {
    return CommunityPost(
      id: id ?? this.id,
      username: username ?? this.username,
      content: content ?? this.content,
      timeAgo: timeAgo ?? this.timeAgo,
      likesCount: likesCount ?? this.likesCount,
      downvotesCount: downvotesCount ?? this.downvotesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
