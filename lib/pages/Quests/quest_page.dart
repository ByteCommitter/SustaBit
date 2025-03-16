import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      
      // Show success message
      Get.snackbar(
        'Quest Added',
        'Your quest has been added successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
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
    
    // Show success message
    Get.snackbar(
      'Quest Added',
      'The suggested quest has been added to your active quests!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
    );
  }
  
  // Delete a quest
  void _deleteQuest(String id) {
    setState(() {
      _activeQuests.removeWhere((quest) => quest.id == id);
    });
    
    // Show success message
    Get.snackbar(
      'Quest Deleted',
      'Quest has been removed from your list',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.1),
      colorText: Colors.red,
    );
  }
  
  // Verify a quest (mark as completed)
  void _verifyQuest(String id) {
    setState(() {
      final questIndex = _activeQuests.indexWhere((quest) => quest.id == id);
      if (questIndex != -1) {
        _activeQuests[questIndex] = _activeQuests[questIndex].copyWith(isCompleted: true);
      }
    });
    
    // Show success message
    Get.snackbar(
      'Quest Completed',
      'Congratulations! You earned ${_activeQuests.firstWhere((quest) => quest.id == id).points} points',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withOpacity(0.1),
      colorText: Colors.blue,
    );
  }

  @override
  void dispose() {
    _questController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quests',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Add new quest section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Your Own Quest',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _questController,
                      decoration: InputDecoration(
                        hintText: 'Enter a new quest',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        suffixIcon: IconButton(
                          onPressed: () => _addQuest(_questController.text),
                          icon: const Icon(Icons.add_circle),
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Active quests section
            const Text(
              'My Active Quests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            // List of active quests
            Expanded(
              child: _activeQuests.isEmpty
                  ? const Center(
                      child: Text(
                        'No active quests. Add one above or from suggestions below.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _activeQuests.length,
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
            
            const SizedBox(height: 20),
            
            // Personalized suggestions section
            const Text(
              'Personalized Quest Suggestions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            // List of personalized suggestions
            SizedBox(
              height: 200, // Fixed height for suggestions
              child: _personalizedQuests.isEmpty
                  ? const Center(
                      child: Text(
                        'No more suggestions. Check back later!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _personalizedQuests.length,
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
    );
  }

  // Build a quest card for active quests
  Widget _buildQuestCard(Quest quest, {required Function onVerify, required Function onDelete}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: quest.isCompleted ? Colors.grey[100] : Colors.white,
      elevation: quest.isCompleted ? 0 : 1,
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
                      const SizedBox(height: 8),
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
            
            const SizedBox(height: 12),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Verify button (only if not completed)
                if (!quest.isCompleted)
                  ElevatedButton.icon(
                    onPressed: () => onVerify(),
                    icon: const Icon(Icons.check_circle, size: 16),
                    label: const Text('Verify'),
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
        padding: const EdgeInsets.all(16),
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