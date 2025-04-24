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
      title: 'Clothes Donation Campaign',
      description: 'Donate your unused clothes to help those in need',
      date: 'May 20, 2023',
      location: 'Community Center',
      imageUrl: 'assets/images/cloth_donation.jpg',
    ),
    Event(
      id: '2',
      title: 'Community Blood Donation Drive',
      description: 'Join us for our quarterly blood donation camp at City Park',
      date: 'May 15, 2023',
      location: 'City Park, Main Avenue',
      imageUrl: 'assets/images/blooddonationdrive.jpg',
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
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.background,
                AppColors.background.withOpacity(0.95),
              ],
            ),
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome message with enhanced styling
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.eco_rounded,
                        color: AppColors.primary,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Here\'s your sustainability dashboard for today.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Enhanced Daily Tip Card
                _buildEnhancedTipCard(_dailyTip),
                const SizedBox(height: 28),
                
                // Section headers with decorative elements
                _buildSectionHeader('Upcoming Events', Icons.event_available_rounded),
                const SizedBox(height: 16),
                
                // Enhanced event list with reduced height
                SizedBox(
                  height: 190, // Reduced from 210 to 190
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      return _buildEnhancedEventCard(_events[index]);
                    },
                  ),
                ),
                
                const SizedBox(height: 28),
                
                // Dashboard Section with enhanced header
                _buildSectionHeader('Your Dashboard', Icons.dashboard_rounded),
                const SizedBox(height: 16),
                
                // Enhanced Progress Card
                _buildEnhancedProgressCard(progressPercentage, completedQuests, totalQuests),
                const SizedBox(height: 20),
                
                // Enhanced Points Card
                _buildEnhancedPointsCard(totalRecentPoints, _dailyPoints),
                const SizedBox(height: 20),
                
                // Enhanced Recently Completed Quests
                _buildEnhancedRecentQuestsCard(_recentlyCompletedQuests),
                const SizedBox(height: 20),
                
                // Enhanced Badges Earned
                _buildEnhancedBadgesCard(_badges),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Section header with icon and divider
  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 22,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.5),
                  AppColors.primary.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Enhanced tip card with better styling
  Widget _buildEnhancedTipCard(Tip tip) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primary.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cardBackground,
              AppColors.cardBackground.withOpacity(0.95),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.warning.withOpacity(0.15),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.tips_and_updates,
                    color: AppColors.warning,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
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
                  color: AppColors.primary,
                  tooltip: 'Learn more',
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              tip.shortText,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () => _showTipDialog(tip),
                icon: const Icon(Icons.add_circle_outline, size: 16),
                label: const Text('Add as Quest'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primary,
                  elevation: 2,
                  shadowColor: AppColors.primary.withOpacity(0.4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Enhanced event card with better visuals and reduced size
  Widget _buildEnhancedEventCard(Event event) {
    return Container(
      height: 190,
      width: 240,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        shadowColor: AppColors.blackOpacity10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () => _showEventDialog(event),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event image with overlay gradient
              Stack(
                children: [
                  Container(
                    height: 100, // Reduced height to prevent overflow
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      image: _getEventImage(event.title),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.cardBackground.withOpacity(0.9),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Date badge
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            event.date,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Event details with compact layout to avoid overflow
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 6), // Further reduced padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13, // Reduced size
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2), // Minimized spacing
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 12,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              event.location,
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4), // Fixed spacing
                      // Compact button row with minimized height
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => _showEventDialog(event),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              padding: EdgeInsets.zero, // Remove padding completely
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact, // Make button more compact
                            ),
                            child: const Text('Details', style: TextStyle(fontSize: 12)),
                          ),
                          IconButton(
                            onPressed: () => _addEventToQuests(event),
                            icon: const Icon(Icons.add_task_rounded, size: 16), // Even smaller icon
                            tooltip: 'Add to Quests',
                            style: IconButton.styleFrom(
                              foregroundColor: AppColors.success,
                              backgroundColor: AppColors.success.withOpacity(0.1),
                              padding: const EdgeInsets.all(3), // Minimal padding
                              visualDensity: VisualDensity.compact,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: const Size(24, 24), // Smaller minimum size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Enhanced progress card with animations
  Widget _buildEnhancedProgressCard(double progressPercentage, int completedQuests, int totalQuests) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primary.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.assignment_turned_in_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Quest Progress',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          // Background track
                          Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          // Progress indicator
                          Container(
                            height: 12,
                            width: MediaQuery.of(context).size.width * 0.5 * progressPercentage,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.primary.withOpacity(0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: '$completedQuests ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(text: 'of '),
                            TextSpan(
                              text: '$totalQuests ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(text: 'quests completed'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 65,
                  width: 65,
                  child: Stack(
                    children: [
                      // Circular progress background
                      Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.cardBackground,
                        ),
                      ),
                      // Circular progress indicator
                      Center(
                        child: SizedBox(
                          height: 65,
                          width: 65,
                          child: CircularProgressIndicator(
                            value: progressPercentage,
                            backgroundColor: AppColors.cardBackground,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                            strokeWidth: 8,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                      ),
                      // Percentage text
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${(progressPercentage * 100).toInt()}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
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

  // Enhanced points card with better visualizations
  Widget _buildEnhancedPointsCard(int totalPoints, List<DailyPoints> dailyPoints) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primary.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.timeline_rounded,
                    color: AppColors.warning,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Points in Last 10 Days',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: AppColors.primary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$totalPoints total',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Enhanced chart with decorative elements
            Container(
              height: 120,
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: dailyPoints.take(10).map((day) {
                  final maxPoints = dailyPoints.map((d) => d.points).reduce((a, b) => a > b ? a : b);
                  final double percentage = maxPoints > 0 ? day.points / maxPoints : 0.0;
                  final double height = percentage * 70; // Maximum bar height
                  
                  // Color gradient based on points value
                  Color barColor;
                  if (day.points > 50) {
                    barColor = AppColors.success;
                  } else if (day.points > 20) {
                    barColor = AppColors.primary;
                  } else if (day.points > 0) {
                    barColor = AppColors.warning;
                  } else {
                    barColor = AppColors.textSecondary.withOpacity(0.3);
                  }
                  
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Bar container with enhanced styling
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            height: height,
                            decoration: BoxDecoration(
                              color: barColor,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: barColor.withOpacity(0.3),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            day.points.toString(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: day.points > 0 ? Colors.black87 : AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            day.day.split(' ')[1], // Only day number
                            style: TextStyle(
                              fontSize: 9,
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

  // Enhanced recently completed quests card
  Widget _buildEnhancedRecentQuestsCard(List<Quest> quests) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primary.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.task_alt_rounded,
                    color: AppColors.success,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Recently Completed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (quests.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quests.length,
                itemBuilder: (context, index) {
                  final quest = quests[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: index < quests.length - 1 ? 14 : 0),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.success.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.success,
                            size: 18,
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
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                quest.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      quest.completedDate!,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.success.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: AppColors.success,
                                          size: 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '+${quest.points}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: AppColors.success,
                                            fontWeight: FontWeight.bold,
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
                      ],
                    ),
                  );
                },
              )
            else
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.hourglass_empty_rounded,
                        size: 40,
                        color: AppColors.textSecondary.withOpacity(0.5),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'No completed quests yet',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Enhanced badges earned card with better visuals
  Widget _buildEnhancedBadgesCard(List<Badge> badges) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primary.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.amber[700],
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Badges Earned',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: badges.map((badge) {
                // Get specific color for each badge type
                Color badgeColor = _getBadgeColor(badge.title);
                
                return Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            badgeColor.withOpacity(0.2),
                            badgeColor.withOpacity(0.05),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: badgeColor.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                        border: Border.all(
                          color: badgeColor.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          _getBadgeIcon(badge.title),
                          color: badgeColor,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 90,
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      decoration: BoxDecoration(
                        color: badgeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: badgeColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        badge.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: badgeColor.withOpacity(0.8),
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
  
  // Helper method to get appropriate color for badge types
  Color _getBadgeColor(String badgeTitle) {
    if (badgeTitle.contains('Mind')) {
      return Colors.purple;
    } else if (badgeTitle.contains('Eco')) {
      return Colors.green[700]!;
    } else if (badgeTitle.contains('Community')) {
      return Colors.blue[700]!;
    } else {
      return Colors.amber[700]!;
    }
  }

  // Helper method to get event icon based on title
  IconData _getEventIcon(String title) {
    if (title.contains('Blood')) {
      return Icons.favorite;
    } else if (title.contains('Clothes')) {
      return Icons.checkroom;
    } else if (title.contains('Beach')) {
      return Icons.beach_access;
    } else {
      return Icons.event;
    }
  }

  // Helper method to get event images based on title
  DecorationImage? _getEventImage(String title) {
    String imagePath;
    
    if (title.contains('Blood')) {
      imagePath = 'assets/images/blooddonationdrive.jpg';
    } else if (title.contains('Clothes')) {
      imagePath = 'assets/images/cloth_donation.jpeg';
    } else if (title.contains('Beach')) {
      imagePath = 'assets/images/beach_cleanup.jpg';
    } else {
      // Default to wooden_shelf for other events
      imagePath = 'assets/images/wooden_shelf.png';
    }
    
    return DecorationImage(
      image: AssetImage(imagePath),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.15),
        BlendMode.darken,
      ),
    );
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
