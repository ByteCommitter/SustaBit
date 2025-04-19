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
    'name': 'Alex Johnson',
    'email': 'alex.johnson@example.com',
    'joinDate': 'March 2023',
    'points': 1250,
    'completedQuests': 42,
    'achievements': ['Eco Warrior', 'Mindfulness Master', 'Community Leader'],
    'interests': ['Meditation', 'Sustainability', 'Mental Health'],
    'avatarColor': Colors.deepPurple,
  };

  // For editing profile
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _userData['name']);
    _emailController = TextEditingController(text: _userData['email']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      if (_isEditing) {
        // Save changes
        if (_formKey.currentState!.validate()) {
          _userData['name'] = _nameController.text;
          _userData['email'] = _emailController.text;
          
          Get.snackbar(
            'Profile Updated',
            'Your profile information has been updated successfully.',
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
        _nameController.text = _userData['name'];
        _emailController.text = _userData['email'];
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
            // Profile header
            _buildProfileHeader(),
            
            const SizedBox(height: 24),
            
            // Profile info
            _isEditing ? _buildEditForm() : _buildProfileInfo(),
            
            const SizedBox(height: 24),
            
            // Statistics section
            _buildStatisticsSection(),
            
            const SizedBox(height: 24),
            
            // Achievements section
            _buildAchievementsSection(),
            
            const SizedBox(height: 24),
            
            // Interests section
            _buildInterestsSection(),
            
            const SizedBox(height: 36),
            
            // Temporarily hidden logout button - remove Firebase dependency
            // Center(
            //   child: ElevatedButton.icon(
            //     onPressed: _signOut,
            //     icon: const Icon(Icons.logout),
            //     label: const Text('Sign Out'),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.red[400],
            //       foregroundColor: Colors.white,
            //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //     ),
            //   ),
            // ),
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
        
        // Name and points
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _userData['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
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
        
        // Edit button
        IconButton(
          onPressed: _toggleEditMode,
          icon: Icon(
            _isEditing ? Icons.save : Icons.edit,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
  
  Widget _buildProfileInfo() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.email, 'Email', _userData['email']),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.calendar_today, 'Member Since', _userData['joinDate']),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEditForm() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Email field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Save button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _toggleEditMode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.deepPurple),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
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
              'Statistics',
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
  
  Widget _buildAchievementsSection() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Achievements',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _userData['achievements']
                  .map<Widget>((achievement) => Chip(
                        avatar: const Icon(Icons.emoji_events, color: Colors.amber, size: 16),
                        label: Text(achievement),
                        backgroundColor: Colors.amber.withOpacity(0.1),
                      ))
                  .toList(),
            ),
          ],
        ),
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
              'Interests',
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
