import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/profile_model.dart';
import '../../services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileService _profileService = ProfileService();
  late Future<ProfileModel> _profileFuture;
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    _profileFuture = _profileService.getUserProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _showChangeUsernameDialog(ProfileModel profile) {
    if (!profile.canChangeAnonymousUsername()) {
      Get.snackbar(
        'Cannot Change Username',
        'You can only change your anonymous username once every 7 days. '
        '${profile.daysUntilUsernameChangeAllowed()} days remaining.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.1),
        colorText: Colors.orange[800],
      );
      return;
    }

    _usernameController.text = profile.anonymousUsername;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Anonymous Username'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'You can only change your anonymous username once every 7 days.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'New Anonymous Username',
                border: OutlineInputBorder(),
              ),
              maxLength: 20,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newUsername = _usernameController.text.trim();
              if (newUsername.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Username cannot be empty',
                  snackPosition: SnackPosition.BOTTOM,
                );
                return;
              }

              final success = await _profileService.updateAnonymousUsername(newUsername);
              Navigator.pop(context);

              if (success) {
                setState(() {
                  _loadProfile();
                });
                Get.snackbar(
                  'Success',
                  'Anonymous username updated successfully',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.withOpacity(0.1),
                  colorText: Colors.green[800],
                );
              } else {
                Get.snackbar(
                  'Error',
                  'Failed to update anonymous username',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.withOpacity(0.1),
                  colorText: Colors.red[800],
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProfileModel>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // If there's an error or no data, we'll still show a hardcoded profile
          final ProfileModel profile = snapshot.hasData 
              ? snapshot.data!
              : ProfileModel(
                  id: 'default123',
                  displayName: 'Jamie Smith',
                  email: 'jamie.smith@example.com',
                  age: 24,
                  anonymousUsername: 'CalmMind88',
                  lifetimePoints: 950,
                  badges: [
                    UserBadge(
                      id: 'default1',
                      name: 'New User',
                      description: 'Joined the app',
                      iconPath: 'assets/images/badges/newuser.png',
                      earnedDate: DateTime.now().subtract(const Duration(days: 1)),
                    ),
                  ],
                );

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile header with avatar and basic info
                Container(
                  width: double.infinity, // Make container take full width
                  padding: const EdgeInsets.all(20),
                  color: Colors.deepPurple.withOpacity(0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Center the contents horizontally
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.deepPurple.withOpacity(0.2),
                        backgroundImage: profile.photoURL != null 
                            ? NetworkImage(profile.photoURL!) 
                            : null,
                        child: profile.photoURL == null
                            ? const Icon(Icons.person, size: 50, color: Colors.deepPurple)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      
                      // Display name
                      Text(
                        profile.displayName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center, // Center align text
                      ),
                      
                      // Email
                      Text(
                        profile.email,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center, // Center align text
                      ),
                      
                      // Age
                      Text(
                        'Age: ${profile.age}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center, // Center align text
                      ),
                    ],
                  ),
                ),
                
                // Anonymous username section
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Anonymous Username',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            profile.anonymousUsername,
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _showChangeUsernameDialog(profile),
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white, // Make the icon white
                            ),
                            label: const Text(
                              'Change',
                              style: TextStyle(color: Colors.white), // Ensure text is also white
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: profile.canChangeAnonymousUsername()
                                  ? Colors.deepPurple
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      if (!profile.canChangeAnonymousUsername())
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'You can change your username in ${profile.daysUntilUsernameChangeAllowed()} days',
                            style: TextStyle(
                              color: Colors.orange[800],
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                
                const Divider(),
                
                // Lifetime points
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Lifetime Points',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          profile.lifetimePoints.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Achievements/Badges
                Padding(
                  padding: const EdgeInsets.all(20),
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
                      
                      // Display badges in a grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: profile.badges.length,
                        itemBuilder: (context, index) {
                          final badge = profile.badges[index];
                          return Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Use a placeholder icon until badge images are available
                                  Icon(
                                    Icons.emoji_events,
                                    color: Colors.amber,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    badge.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    badge.description,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
