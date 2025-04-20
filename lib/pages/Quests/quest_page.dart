import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentalsustainability/theme/app_colors.dart'; // Add theme import
import 'package:mentalsustainability/pages/Community/community_page.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({super.key});

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  // Controller for adding new quests
  final TextEditingController _questController = TextEditingController();
  
  // List of active quests
  final List<Quest> _activeQuests = [
    Quest(
      id: '1',
      title: 'Meditate for 10 minutes',
      description: 'Find a quiet place and practice mindfulness meditation',
      points: 50,
      isCompleted: false,
    ),
    Quest(
      id: '2',
      title: 'Take a nature walk',
      description: 'Spend at least 20 minutes walking outdoors',
      points: 40,
      isCompleted: false,
    ),
    Quest(
      id: '3',
      title: 'Journal your thoughts',
      description: 'Write down your feelings and reflections for the day',
      points: 30,
      isCompleted: false,
    ),
  ];
  
  // List of personalized quest suggestions
  final List<Quest> _personalizedQuests = [
    Quest(
      id: 'p1',
      title: 'Practice deep breathing exercises',
      description: 'Take 5 minutes to practice deep breathing techniques',
      points: 25,
      isCompleted: false,
      isSuggestion: true,
    ),
    Quest(
      id: 'p2',
      title: 'Reduce screen time before bed',
      description: 'Avoid screens for 30 minutes before sleeping',
      points: 35,
      isCompleted: false,
      isSuggestion: true,
    ),
    Quest(
      id: 'p3',
      title: 'Stay hydrated',
      description: 'Drink at least 8 glasses of water today',
      points: 20,
      isCompleted: false,
      isSuggestion: true,
    ),
  ];

  // Add a new quest to active quests
  void _addQuest(String title) {
    if (title.isNotEmpty) {
      setState(() {
        _activeQuests.add(
          Quest(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: title,
            description: 'User-added quest',
            points: 30, // Default points for user-added quests
            isCompleted: false,
          ),
        );
      });
      _questController.clear();
      
      // Show success message with solid background for better visibility
      Get.snackbar(
        'Quest Added',
        'Your quest has been added successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success.withOpacity(0.1), // Use theme color
        colorText: AppColors.success, // Use theme color
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
    }
  }
  
  // Add suggested quest to active quests
  void _addSuggestedQuest(Quest quest) {
    setState(() {
      // Remove from suggestions
      _personalizedQuests.removeWhere((q) => q.id == quest.id);
      
      // Add to active quests (with a new ID to avoid confusion)
      _activeQuests.add(
        Quest(
          id: 'a${quest.id}',
          title: quest.title,
          description: quest.description,
          points: quest.points,
          isCompleted: false,
          isSuggestion: false,
        ),
      );
    });
    
    // Show success message with solid background
    Get.snackbar(
      'Quest Added',
      'The suggested quest has been added to your active quests!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success.withOpacity(0.1), // Use theme color
      colorText: AppColors.success, // Use theme color
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }
  
  // Delete a quest
  void _deleteQuest(String id) {
    setState(() {
      _activeQuests.removeWhere((quest) => quest.id == id);
    });
    
    // Show success message with solid background
    Get.snackbar(
      'Quest Deleted',
      'Quest has been removed from your list',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error.withOpacity(0.1), // Use theme color
      colorText: AppColors.error, // Use theme color
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }
  
  // Verify a quest (mark as completed)
  void _verifyQuest(String id) {
    final questIndex = _activeQuests.indexWhere((quest) => quest.id == id);
    if (questIndex != -1) {
      final completedQuest = _activeQuests[questIndex];
      
      // Show dialog instead of directly navigating
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Quest Completed'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Congratulations on completing "${completedQuest.title}"!'),
              const SizedBox(height: 8),
              const Text('Would you like to share your achievement with the community to verify and gain points?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Just mark as complete without sharing
                setState(() {
                  _activeQuests[questIndex] = _activeQuests[questIndex].copyWith(isCompleted: true);
                });
                Navigator.pop(context); // Close dialog
                
                Get.snackbar(
                  'Quest Completed',
                  'Well done! You\'ve earned 10 points!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.info.withOpacity(0.1), // Use theme color
                  colorText: AppColors.info, // Use theme color
                  margin: const EdgeInsets.all(16),
                  borderRadius: 8,
                  duration: const Duration(seconds: 3),
                );
              },
              child: const Text('Just Complete'),
            ),
            ElevatedButton(  
              onPressed: () {
                // Mark as complete and share
                setState(() {
                  _activeQuests[questIndex] = _activeQuests[questIndex].copyWith(isCompleted: true);
                });
                Navigator.pop(context); // Close dialog
                
                // Navigate to community page to share accomplishment
                Get.to(() => CommunityPage(
                  prefilledPost: "I just completed the quest: ${completedQuest.title}! Share your thoughts and verify my achievement. 🎉",
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary, // Use theme color
                foregroundColor: AppColors.white, // Use theme color
              ),
              child: const Text('Share & Complete'),
            ),
          ],
        ),
      );
    }
  }

  // Show dialog to create a new quest
  void _showAddQuestDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Create New Quest',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: _questController,
          decoration: InputDecoration(
            hintText: 'Enter your quest title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
            ),
            filled: true,
            fillColor: AppColors.cardBackground,
            contentPadding: const EdgeInsets.all(16),
          ),
          maxLines: 2,
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel', 
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addQuest(_questController.text);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Add Quest'),
          ),
        ],
      ),
    );
  }
  
  // Show suggestions dialog
  void _showSuggestionsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Quest Suggestions',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: _personalizedQuests.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.notifications_off,
                      size: 48,
                      color: AppColors.textSecondary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No suggestions available',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    Text(
                      'Check back later!',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _personalizedQuests.length,
                itemBuilder: (context, index) {
                  final quest = _personalizedQuests[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.lightbulb,
                          color: AppColors.warning,
                          size: 24,
                        ),
                      ),
                      title: Text(
                        quest.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(quest.description),
                          const SizedBox(height: 8),
                          Text(
                            "${quest.points} points",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        onPressed: () {
                          _addSuggestedQuest(quest);
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: AppColors.primary,
                        ),
                        tooltip: 'Add to My Quests',
                      ),
                    ),
                  );
                },
              ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _questController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate progress of completed quests
    final int totalQuests = _activeQuests.length;
    final int completedQuests = _activeQuests.where((quest) => quest.isCompleted).length;
    final double progressPercentage = totalQuests > 0 ? completedQuests / totalQuests : 0.0;
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0), // Add bottom padding for FAB
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with progress
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Quests',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Progress text and bar
                      Row(
                        children: [
                          Text(
                            '$completedQuests of $totalQuests completed',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${(progressPercentage * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Suggestions button - replaces the large box at the bottom
                OutlinedButton.icon(
                  onPressed: _showSuggestionsDialog,
                  icon: Icon(Icons.lightbulb_outline, color: AppColors.warning),
                  label: const Text("View Suggestions"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Progress bar
            LinearProgressIndicator(
              value: progressPercentage,
              backgroundColor: AppColors.cardBackground,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            
            const SizedBox(height: 16),
            
            // List of active quests
            Expanded(
              child: _activeQuests.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.hourglass_empty, 
                          size: 64, 
                          color: AppColors.textSecondary.withOpacity(0.5)
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'No active quests yet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add a new quest using the + button\nor check out our suggestions',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 32),
                        OutlinedButton.icon(
                          onPressed: _showSuggestionsDialog,
                          icon: Icon(Icons.lightbulb_outline, color: AppColors.warning),
                          label: const Text("Browse Quest Suggestions"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: BorderSide(color: AppColors.primary),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _activeQuests.length,
                    padding: const EdgeInsets.only(bottom: 8),
                    itemBuilder: (context, index) {
                      final quest = _activeQuests[index];
                      return _buildQuestCard(
                        quest,
                        onVerify: () => _verifyQuest(quest.id),
                        onDelete: () => _deleteQuest(quest.id),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
      
      // Add floating action button for creating new quests
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddQuestDialog,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        tooltip: 'Create New Quest',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Build a quest card for active quests
  Widget _buildQuestCard(Quest quest, {required Function onVerify, required Function onDelete}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: quest.isCompleted ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: quest.isCompleted ? AppColors.cardBackground : AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quest Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.task_alt,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Quest details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quest.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: quest.isCompleted ? TextDecoration.lineThrough : null,
                          color: quest.isCompleted ? AppColors.textSecondary : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        quest.description,
                        style: TextStyle(
                          color: quest.isCompleted ? AppColors.textSecondary : AppColors.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${quest.points} points',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          
                          if (quest.isCompleted)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.check, size: 12, color: AppColors.success),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Completed',
                                    style: TextStyle(
                                      color: AppColors.success,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
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
            
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 8),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Complete button (renamed from Verify)
                if (!quest.isCompleted)
                  TextButton.icon(
                    onPressed: () => onVerify(),
                    icon: const Icon(Icons.check_circle, size: 18),
                    label: const Text('Complete'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.success,
                    ),
                  )
                else
                  const SizedBox.shrink(),
                  
                const SizedBox(width: 8),
                
                // Delete button
                TextButton.icon(
                  onPressed: () => onDelete(),
                  icon: const Icon(Icons.delete, size: 18),
                  label: const Text('Delete'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Quest model
class Quest {
  final String id;
  final String title;
  final String description;
  final int points;
  final bool isCompleted;
  final bool isSuggestion;

  Quest({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.isCompleted,
    this.isSuggestion = false,
  });

  // Copy with method to create new instances with modified properties
  Quest copyWith({
    String? id,
    String? title,
    String? description,
    int? points,
    bool? isCompleted,
    bool? isSuggestion,
  }) {
    return Quest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      points: points ?? this.points,
      isCompleted: isCompleted ?? this.isCompleted,
      isSuggestion: isSuggestion ?? this.isSuggestion,
    );
  }
}