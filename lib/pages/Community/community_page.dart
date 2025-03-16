import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sa_library_page.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final List<CommunityPost> _posts = [
    CommunityPost(
      id: '1',
      username: 'MindfulUser42',
      content: 'Just completed a 7-day mindfulness streak. Feeling much more centered and focused!',
      timeAgo: '2h ago',
      likesCount: 15,
      commentsCount: 3,
    ),
    CommunityPost(
      id: '2',
      username: 'CalmMind88',
      content: 'Does anyone have suggestions for dealing with exam anxiety? I have finals coming up next week and feeling overwhelmed.',
      timeAgo: '5h ago',
      likesCount: 8,
      commentsCount: 12,
    ),
    CommunityPost(
      id: '3',
      username: 'SerenitySeeker',
      content: 'I found this amazing resource for free guided meditations. Highly recommend for anyone looking to start meditation: https://example.com/meditations',
      timeAgo: '1d ago',
      likesCount: 42,
      commentsCount: 7,
    ),
    CommunityPost(
      id: '4',
      username: 'MentalHealthMatters',
      content: 'Reminder: It\'s okay to take breaks. Sometimes the most productive thing you can do is rest.',
      timeAgo: '2d ago',
      likesCount: 105,
      commentsCount: 15,
    ),
    CommunityPost(
      id: '5',
      username: 'WellnessJourney',
      content: 'Just had a great therapy session today. If you\'ve been thinking about trying therapy, this is your sign to give it a shot!',
      timeAgo: '3d ago',
      likesCount: 27,
      commentsCount: 6,
    ),
  ];

  void _navigateToSALibrary() {
    Get.to(() => const SALibraryPage());
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
              // Community header
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Community',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
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
                            Get.snackbar(
                              'Success',
                              'Your post has been shared with the community!',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green.withOpacity(0.1),
                              colorText: Colors.green,
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
              ..._posts.map((post) => _buildPostCard(post)).toList(),
              
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
            
            const SizedBox(height: 12),
            
            // Post actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.red,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      iconSize: 20,
                    ),
                    const SizedBox(width: 4),
                    Text('${post.likesCount}'),
                  ],
                ),
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
  final int commentsCount;

  CommunityPost({
    required this.id,
    required this.username,
    required this.content,
    required this.timeAgo,
    required this.likesCount,
    required this.commentsCount,
  });
}
