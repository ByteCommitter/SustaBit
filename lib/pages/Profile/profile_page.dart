import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Mock user data
  final Map<String, dynamic> _userData = {
    'name': 'Alex Johnson',  // Real name
    'anonymousName': 'SereneSpirit42',  // Anonymous username for community
    'email': 'alex.johnson@example.com',
    'joinDate': 'March 2023',
    'points': 1250,
    'completedQuests': 42,
    'achievements': [
      {
        'name': 'Eco Warrior',
        'description': 'Completed 10 sustainability challenges',
        'icon': Icons.nature_people,
        'color': Colors.green,
        'level': 2,
      },
      {
        'name': 'Mindfulness Master',
        'description': 'Practiced mindfulness for 30 days',
        'icon': Icons.self_improvement,
        'color': Colors.blue,
        'level': 3,
      },
      {
        'name': 'Community Leader',
        'description': 'Helped 5 other community members',
        'icon': Icons.people,
        'color': Colors.orange,
        'level': 1,
      },
      {
        'name': 'Knowledge Seeker',
        'description': 'Completed all educational modules',
        'icon': Icons.school,
        'color': Colors.purple,
        'level': 2,
      },
    ],
    'interests': ['Meditation', 'Sustainability', 'Mental Health'],
    'avatarColor': Colors.deepPurple,
  };

  // For editing profile
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _anonymousNameController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _userData['name']);
    _anonymousNameController = TextEditingController(text: _userData['anonymousName']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _anonymousNameController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      if (_isEditing) {
        // Save changes
        if (_formKey.currentState!.validate()) {
          _userData['anonymousName'] = _anonymousNameController.text;
          
          Get.snackbar(
            'Profile Updated',
            'Your anonymous username has been updated successfully.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green[100],
            colorText: Colors.green[800],
            margin: const EdgeInsets.all(16),
            borderRadius: 8,
            duration: const Duration(seconds: 3),
          );
        } else {
          // Return without toggling if validation fails
          return;
        }
      } else {
        // Reset controllers when entering edit mode
        _anonymousNameController.text = _userData['anonymousName'];
      }
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header with real name
            _buildProfileHeader(),
            
            const SizedBox(height: 24),
            
            // Anonymous username section
            _buildAnonymousUsernameSection(),
            
            const SizedBox(height: 24),
            
            // Statistics section
            _buildStatisticsSection(),
            
            const SizedBox(height: 24),
            
            // Enhanced Achievements section
            _buildEnhancedAchievementsSection(),
            
            const SizedBox(height: 24),
            
            // Interests section
            _buildInterestsSection(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileHeader() {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 40,
          backgroundColor: _userData['avatarColor'],
          child: Text(
            _userData['name'].substring(0, 1).toUpperCase(),
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20),
        
        // Real name and points
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Real name
              Text(
                _userData['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Points display
              Row(
                children: [
                  const Icon(Icons.stars, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${_userData['points']} points',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // New method for anonymous username section
  Widget _buildAnonymousUsernameSection() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_outline, color: Colors.deepPurple),
                    const SizedBox(width: 8),
                    const Text(
                      'Community Username',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: _toggleEditMode,
                  icon: Icon(
                    _isEditing ? Icons.save : Icons.edit,
                    color: Colors.deepPurple,
                  ),
                  tooltip: 'Change anonymous username',
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Anonymous name display or edit form
            if (_isEditing)
              _buildEditForm()
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.shield, size: 16, color: Colors.deepPurple),
                            const SizedBox(width: 6),
                            Text(
                              _userData['anonymousName'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.withOpacity(0.3)),
                        ),
                        child: const Text(
                          'Anonymous',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'This is your anonymous identity in the community section.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Anonymous username field
          TextFormField(
            controller: _anonymousNameController,
            decoration: InputDecoration(
              labelText: 'Anonymous Username',
              helperText: 'This name will be visible in the community tab',
              prefixIcon: const Icon(Icons.person_outline),
              suffixIcon: IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Generate random username',
                onPressed: () {
                  // Generate a random username
                  final options = [
                    'MindfulWanderer',
                    'SereneSpirit',
                    'CalmExplorer',
                    'PeacefulJourney',
                    'GentleSoul',
                    'TransquilThinker',
                    'QuietObserver',
                    'ZenPathfinder'
                  ];
                  final random = DateTime.now().millisecondsSinceEpoch % options.length;
                  final randomNum = DateTime.now().second % 100;
                  setState(() {
                    _anonymousNameController.text = '${options[random]}$randomNum';
                  });
                },
              ),
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          // Privacy note
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.privacy_tip_outlined, 
                  color: Colors.blue, 
                  size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Your real name is never shown to other community members',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Save button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _toggleEditMode,
              icon: const Icon(Icons.check),
              label: const Text('Save Username'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatisticsSection() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Progress',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(Icons.task_alt, 'Quests\nCompleted', _userData['completedQuests'].toString()),
                _buildStatItem(Icons.stars, 'Total\nPoints', _userData['points'].toString()),
                _buildStatItem(Icons.emoji_events, 'Achievements', _userData['achievements'].length.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.deepPurple),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
  
  Widget _buildEnhancedAchievementsSection() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Achievements',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.grid_view, size: 16),
                  label: const Text("View All"),
                  onPressed: () {
                    // Future enhancement: Navigate to full achievements page
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Enhanced badges
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _userData['achievements'].length,
              itemBuilder: (context, index) {
                final achievement = _userData['achievements'][index];
                return _buildAchievementBadge(achievement);
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAchievementBadge(Map<String, dynamic> achievement) {
    return Container(
      decoration: BoxDecoration(
        color: achievement['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: achievement['color'].withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Badge Icon with Level indicator
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: achievement['color'].withOpacity(0.2),
                  border: Border.all(
                    color: achievement['color'],
                    width: 2,
                  ),
                ),
                child: Icon(
                  achievement['icon'],
                  color: achievement['color'],
                  size: 32,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: achievement['color'],
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    achievement['level'].toString(),
                    style: TextStyle(
                      color: achievement['color'],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            achievement['name'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              achievement['description'],
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInterestsSection() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Interests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _userData['interests']
                  .map<Widget>((interest) => Chip(
                        avatar: const Icon(Icons.favorite, color: Colors.deepPurple, size: 16),
                        label: Text(interest),
                        backgroundColor: Colors.deepPurple.withOpacity(0.1),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
