import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        backgroundColor: Colors.green[100], // Solid light green background
        colorText: Colors.green[800], // Dark green text for contrast
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
      backgroundColor: Colors.green[100], // Solid light green background
      colorText: Colors.green[800], // Dark green text for contrast
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
      backgroundColor: Colors.red[100], // Solid light red background
      colorText: Colors.red[800], // Dark red text for contrast
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
                  backgroundColor: Colors.blue[100], 
                  colorText: Colors.blue[800],
                  margin: const EdgeInsets.all(16),
                  borderRadius: 8,
                  duration: const Duration(seconds: 3),
                );
              },
              child: const Text('Just Complete'),
            ),
            TextButton(
              onPressed: () {
                // Just mark as complete without sharing
                setState(() {
                  _activeQuests[questIndex] = _activeQuests[questIndex].copyWith(isCompleted: true);
                });
                Navigator.pop(context); // Close dialog
                
                Get.snackbar(
                  'Quest Completed',
                  'Posted on Community! You\'ve earned 30 points!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.blue[100], 
                  colorText: Colors.blue[800],
                  margin: const EdgeInsets.all(16),
                  borderRadius: 8,
                  duration: const Duration(seconds: 3),
                );
              },
              child: const Text('Just Complete'),
            ),
          ],
        ),
      );
    }
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // More compact header section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quests',
                  style: TextStyle(
                    fontSize: 20, // Reduced font size from 24
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), // Smaller padding
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8), // Smaller radius
                  ),
                  child: Text(
                    '${(progressPercentage * 100).toInt()}% Complete',
                    style: TextStyle(
                      fontSize: 11, // Smaller font
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4), // Reduced space
            
            // More compact progress bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: progressPercentage,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                  minHeight: 6, // Reduced from 10 to 6
                  borderRadius: BorderRadius.circular(3), // Smaller radius
                ),
                const SizedBox(height: 2), // Reduced from 4 to 2
                Text(
                  '$completedQuests of $totalQuests quests completed',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 10, // Reduced from 12 to 10
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8), // Reduced spacing
            
            // Add new quest section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(10), // Reduced padding further
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Your Own Quest',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14, // Reduced font size
                      ),
                    ),
                    const SizedBox(height: 6), // Reduced spacing
                    TextField(
                      controller: _questController,
                      decoration: InputDecoration(
                        hintText: 'Enter a new quest',
                        isDense: true, // More compact TextField
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        suffixIcon: IconButton(
                          onPressed: () => _addQuest(_questController.text),
                          icon: const Icon(Icons.add_circle, size: 20), // Smaller icon
                          color: Colors.deepPurple,
                          padding: EdgeInsets.zero, // No padding for icon
                          constraints: const BoxConstraints(), // Minimize constraints
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 12), // Reduced spacing
            
            // Active quests section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Active Quests',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Add scroll indicator text
                Text(
                  'Scroll to see all',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Reduced spacing
            
            // List of active quests
            Expanded(
              flex: 3, // Give more space to active quests
              child: _activeQuests.isEmpty
                  ? Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.hourglass_empty, size: 40, color: Colors.grey),
                            SizedBox(height: 8),
                            Text(
                              'No active quests yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Add one above or from suggestions below',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder( // Replaced the ShaderMask with a simple ListView
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
            
            const SizedBox(height: 12), // Reduced spacing
            
            // Personalized suggestions section - now in a box
            Container(
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.05),
                border: Border.all(
                  color: Colors.amber.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with scroll indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Personalized Quest Suggestions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Add scroll indicator text
                      Text(
                        'Scroll to see all',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), // Reduced spacing
                  
                  // List of personalized suggestions
                  SizedBox(
                    height: 200, // Fixed height for suggestions section
                    child: _personalizedQuests.isEmpty
                        ? Center(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.notifications_off, size: 40, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text(
                                    'No more suggestions',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    'Check back later!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _personalizedQuests.length,
                            padding: const EdgeInsets.only(bottom: 8),
                            itemBuilder: (context, index) {
                              final quest = _personalizedQuests[index];
                              return _buildSuggestionCard(
                                quest,
                                onAdd: () => _addSuggestedQuest(quest),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            
            // Add some bottom padding
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // Build a quest card for active quests
  Widget _buildQuestCard(Quest quest, {required Function onVerify, required Function onDelete}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: quest.isCompleted ? Colors.grey[100] : Colors.white,
      elevation: quest.isCompleted ? 0 : 1,
      child: Padding(
        padding: const EdgeInsets.all(12), // Reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quest Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.task_alt,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(width: 12),
                
                // Quest details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quest.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: quest.isCompleted ? TextDecoration.lineThrough : null,
                          color: quest.isCompleted ? Colors.grey : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        quest.description,
                        style: TextStyle(
                          color: quest.isCompleted ? Colors.grey : Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4), // Reduced spacing
                      Text(
                        '${quest.points} points',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8), // Reduced spacing
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Complete button (renamed from Verify)
                if (!quest.isCompleted)
                  ElevatedButton.icon(
                    onPressed: () => onVerify(),
                    icon: const Icon(Icons.check_circle, size: 16),
                    label: const Text('Complete'), // Changed from "Verify" to "Complete"
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  )
                else
                  const Chip(
                    label: Text('Completed'),
                    backgroundColor: Colors.green,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  
                const SizedBox(width: 8),
                
                // Delete button
                ElevatedButton.icon(
                  onPressed: () => onDelete(),
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build a suggestion card for personalized quests
  Widget _buildSuggestionCard(Quest quest, {required Function onAdd}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12), // Reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quest Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.lightbulb,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(width: 12),
                
                // Quest details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quest.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        quest.description,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${quest.points} points',
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Add button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () => onAdd(),
                icon: const Icon(Icons.add_circle, size: 16),
                label: const Text('Add to My Quests'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
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