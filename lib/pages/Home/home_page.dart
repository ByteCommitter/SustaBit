import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentalsustainability/theme/app_colors.dart';
import 'package:mentalsustainability/pages/Quests/quest_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Hardcoded events for sustainability
  final List<Event> _events = [
    Event(
      id: '1',
      title: 'Community Blood Donation Drive',
      description: 'Join us for our quarterly blood donation camp at City Park',
      date: 'May 15, 2023',
      location: 'City Park, Main Avenue',
      imageUrl: 'assets/images/blood_donation.jpg',
    ),
    Event(
      id: '2',
      title: 'Clothes Donation Campaign',
      description: 'Donate your unused clothes to help those in need',
      date: 'May 20, 2023',
      location: 'Community Center',
      imageUrl: 'assets/images/clothes_donation.jpg',
    ),
    Event(
      id: '3',
      title: 'Beach Cleanup Day',
      description: 'Help clean our local beaches and protect marine life',
      date: 'May 28, 2023',
      location: 'Sunny Beach',
      imageUrl: 'assets/images/beach_cleanup.jpg',
    ),
  ];

  // Hardcoded recently completed quests
  final List<Quest> _recentlyCompletedQuests = [
    Quest(
      id: 'r1',
      title: 'Daily Meditation',
      description: '10 minutes of mindfulness meditation',
      points: 30,
      isCompleted: true,
      completedDate: 'Today',
    ),
    Quest(
      id: 'r2',
      title: 'Reduce Plastic Usage',
      description: 'Used reusable containers instead of single-use plastic',
      points: 50,
      isCompleted: true,
      completedDate: 'Yesterday',
    ),
  ];

  // Sample badges earned
  final List<Badge> _badges = [
    Badge(
      id: 'b1',
      title: 'Mindfulness Beginner',
      description: 'Completed 5 mindfulness activities',
      imageUrl: 'assets/images/badges/mindfulness_beginner.png',
    ),
    Badge(
      id: 'b2',
      title: 'Eco Warrior',
      description: 'Participated in 3 environmental activities',
      imageUrl: 'assets/images/badges/eco_warrior.png',
    ),
    Badge(
      id: 'b3',
      title: 'Community Helper',
      description: 'Engaged in community activities',
      imageUrl: 'assets/images/badges/community_helper.png',
    ),
  ];

  // Daily sustainability tip
  final Tip _dailyTip = Tip(
    id: 't1',
    shortText: 'Try using a reusable water bottle today instead of buying bottled water.',
    longText: 'Plastic water bottles contribute significantly to environmental pollution. By using a reusable water bottle, you can save money and reduce plastic waste. A single reusable bottle can replace hundreds of plastic bottles per year!',
    questTitle: 'Use Reusable Water Bottle',
    questDescription: 'Use a reusable water bottle for a week and track how many plastic bottles you save',
    questPoints: 40,
  );

  // Points collected in the last 10 days
  final List<DailyPoints> _dailyPoints = [
    DailyPoints(day: 'May 1', points: 45),
    DailyPoints(day: 'May 2', points: 30),
    DailyPoints(day: 'May 3', points: 60),
    DailyPoints(day: 'May 4', points: 15),
    DailyPoints(day: 'May 5', points: 0),
    DailyPoints(day: 'May 6', points: 50),
    DailyPoints(day: 'May 7', points: 35),
    DailyPoints(day: 'May 8', points: 40),
    DailyPoints(day: 'May 9', points: 20),
    DailyPoints(day: 'May 10', points: 75),
  ];

  // Add event to quests
  void _addEventToQuests(Event event) {
    // Create a new quest from the event
    final quest = Quest(
      id: 'e${event.id}',
      title: 'Participate in ${event.title}',
      description: '${event.description} on ${event.date} at ${event.location}',
      points: 100, // Higher points for event participation
      isCompleted: false,
    );

    // In a real app, this would be added to the user's quests list in a service or database
    // For now, we'll just show a confirmation message
    Get.snackbar(
      'Event Added',
      '${event.title} has been added to your quests!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success.withOpacity(0.1), // Use theme color
      colorText: AppColors.success, // Use theme color
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  // Add tip to quests
  void _addTipToQuests(Tip tip) {
    // Create a new quest from the tip
    final quest = Quest(
      id: tip.id,
      title: tip.questTitle,
      description: tip.questDescription,
      points: tip.questPoints,
      isCompleted: false,
    );

    // In a real app, this would be added to the user's quests list in a service or database
    Get.snackbar(
      'Tip Added',
      '${tip.questTitle} has been added to your quests!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success.withOpacity(0.1), // Use theme color
      colorText: AppColors.success, // Use theme color
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );

    // Close the dialog
    Navigator.of(context).pop();
  }

  // Show detailed tip dialog
  void _showTipDialog(Tip tip) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sustainability Tip'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tip.longText,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Want to make this a quest?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Quest: ${tip.questTitle}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('Description: ${tip.questDescription}'),
                const SizedBox(height: 4),
                Text(
                  'Points: ${tip.questPoints}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Maybe Later'),
            ),
            ElevatedButton(
              onPressed: () => _addTipToQuests(tip),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Add to Quests'),
            ),
          ],
        );
      },
    );
  }

  // Show detailed event dialog
  void _showEventDialog(Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event.title),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Event image placeholder
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.event,
                      size: 50,
                      color: AppColors.primary.withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Event details
                const Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                
                // Event date and location
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Date: ${event.date}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Location: ${event.location}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                
                // Quest info
                const Text(
                  'Add this as a quest?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Quest: Participate in ${event.title}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('Description: ${event.description} on ${event.date} at ${event.location}'),
                const SizedBox(height: 4),
                Text(
                  'Points: 100',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Not Now'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addEventToQuests(event);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Add to Quests'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total points from the last 10 days
    final int totalRecentPoints = _dailyPoints.fold(0, (sum, item) => sum + item.points);
    
    // Calculate quest progress
    const int totalQuests = 10; // Assuming there are 10 quests in total
    const int completedQuests = 2; // From the _recentlyCompletedQuests list
    const double progressPercentage = completedQuests / totalQuests;

    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.cardBackground,
        onRefresh: () async {
          // In a real app, this would refresh data from an API
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Here\'s your sustainability dashboard for today.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary, // Use theme color
                ),
              ),
              const SizedBox(height: 20),
              
              // Daily Tip Card
              _buildTipCard(_dailyTip),
              const SizedBox(height: 24),
              
              // Upcoming Events Section
              const Text(
                'Upcoming Events',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              // FIXED: Completely redesigned event list to prevent overflow
              SizedBox(
                height: 200, // Fixed, smaller height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _events.length,
                  itemBuilder: (context, index) {
                    return _buildEventCard(_events[index]);
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Dashboard Section
              const Text(
                'Your Dashboard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Progress Card
              _buildProgressCard(progressPercentage, completedQuests, totalQuests),
              const SizedBox(height: 16),
              
              // Points in the Last 10 Days
              _buildPointsCard(totalRecentPoints, _dailyPoints),
              const SizedBox(height: 16),
              
              // Recently Completed Quests
              _buildRecentQuestsCard(_recentlyCompletedQuests),
              const SizedBox(height: 16),
              
              // Badges Earned
              _buildBadgesCard(_badges),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // Build tip card widget
  Widget _buildTipCard(Tip tip) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1), // Use theme color
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.tips_and_updates,
                    color: AppColors.warning, // Use theme color
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Today\'s Sustainability Tip',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _showTipDialog(tip),
                  icon: const Icon(Icons.info_outline),
                  color: AppColors.primary, // Use theme color
                  tooltip: 'Learn more',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              tip.shortText,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _showTipDialog(tip),
                icon: const Icon(Icons.add_circle_outline, size: 16),
                label: const Text('Add as Quest'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary, // Use theme color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FIXED: Completely redesigned event card
  Widget _buildEventCard(Event event) {
    return Container(
      height: 150,
      width: 250, // Reduced width
      margin: const EdgeInsets.only(right: 8), // Reduced margin
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () => _showEventDialog(event),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event image (placeholder color if image not available)
              Container(
                height: 80, // Reduced height
                color: AppColors.primary.withOpacity(0.1),
                child: Center(
                  child: Icon(
                    Icons.image_outlined ,
                    size: 30, // Reduced size
                    color: AppColors.primary.withOpacity(0.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8), // Reduced padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13, // Reduced font size
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Combine date and location in a more compact way
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 10, // Reduced size
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          event.date,
                          style: TextStyle(
                            fontSize: 10, // Reduced size
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // View Details button
                    Center(
                      child: TextButton(
                        onPressed: () => _showEventDialog(event),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'View Details',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build progress card widget
  Widget _buildProgressCard(double progressPercentage, int completedQuests, int totalQuests) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quest Progress',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value: progressPercentage,
                        backgroundColor: AppColors.cardBackground,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$completedQuests of $totalQuests quests completed',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: CircularProgressIndicator(
                                  value: progressPercentage,
                                  backgroundColor: AppColors.cardBackground,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                  strokeWidth: 6,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${(progressPercentage * 100).toInt()}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // FIXED: Completely redesigned points card with fixed inverted bar issue
  Widget _buildPointsCard(int totalPoints, List<DailyPoints> dailyPoints) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Points in Last 10 Days',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$totalPoints total',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // FIXED: Fixed chart implementation to ensure consistent direction of bars
            SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: dailyPoints.take(10).map((day) {
                  final maxPoints = dailyPoints.map((d) => d.points).reduce((a, b) => a > b ? a : b);
                  final double percentage = maxPoints > 0 ? day.points / maxPoints : 0.0;
                  final double height = percentage * 60; // Maximum bar height of 60
                  
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Bar container with fixed height calculation
                          Container(
                            height: height,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            day.points.toString(),
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            day.day.split(' ')[1], // Only day number
                            style: TextStyle(
                              fontSize: 8,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build recently completed quests card widget
  Widget _buildRecentQuestsCard(List<Quest> quests) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recently Completed',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: quests.length,
              itemBuilder: (context, index) {
                final quest = quests[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quest.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              quest.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  quest.completedDate!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  '+${quest.points} points',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.success,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (quests.isEmpty)
              Center(
                child: Text(
                  'No completed quests yet',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Build badges earned card widget
  Widget _buildBadgesCard(List<Badge> badges) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Badges Earned',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: badges.map((badge) {
                return Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          _getBadgeIcon(badge.title),
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 80,
                      child: Text(
                        badge.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get the appropriate icon for badge types
  IconData _getBadgeIcon(String badgeTitle) {
    if (badgeTitle.contains('Mind')) {
      return Icons.spa;
    } else if (badgeTitle.contains('Eco')) {
      return Icons.eco;
    } else if (badgeTitle.contains('Community')) {
      return Icons.people;
    } else {
      return Icons.star;
    }
  }
}

// Model classes

class Event {
  final String id;
  final String title;
  final String description;
  final String date;
  final String location;
  final String? imageUrl;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    this.imageUrl,
  });
}

class Quest {
  final String id;
  final String title;
  final String description;
  final int points;
  final bool isCompleted;
  final bool isSuggestion;
  final String? completedDate;

  Quest({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.isCompleted,
    this.isSuggestion = false,
    this.completedDate,
  });
}

class Badge {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;

  Badge({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
  });
}

class Tip {
  final String id;
  final String shortText;
  final String longText;
  final String questTitle;
  final String questDescription;
  final int questPoints;

  Tip({
    required this.id,
    required this.shortText,
    required this.longText,
    required this.questTitle,
    required this.questDescription,
    required this.questPoints,
  });
}

class DailyPoints {
  final String day;
  final int points;

  DailyPoints({
    required this.day,
    required this.points,
  });
}
