import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Map<String, dynamic>> _userResponses = [];
  
  // Questions and options for the quiz
  final List<QuizQuestion> _questions = [
    QuizQuestion(
      question: "What is your main goal for sustainability?",
      options: [
        "Reducing stress and anxiety",
        "Improving focus and productivity",
        "Building better relationships",
        "Finding more joy and purpose in daily life"
      ],
    ),
    QuizQuestion(
      question: "Which sustainable practice are you most interested in?",
      options: [
        "Reducing waste and recycling",
        "Energy conservation",
        "Mindful consumption (buying less, choosing eco-friendly products)",
        "Community engagement and volunteering"
      ],
    ),
    QuizQuestion(
      question: "How often do you currently engage in self-care activities?",
      options: [
        "Rarely - I struggle to make time for self-care",
        "Sometimes - a few times a month",
        "Regularly - a few times a week",
        "Daily - it's part of my routine"
      ],
    ),
    QuizQuestion(
      question: "What's your biggest challenge in maintaining mental well-being?",
      options: [
        "Finding time in a busy schedule",
        "Consistency in healthy habits",
        "External pressures and expectations",
        "Lack of support or resources"
      ],
    ),
  ];
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  void _nextPage() {
    if (_currentPage < _questions.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _selectOption(int questionIndex, int optionIndex) {
    // Store or update the user's response
    if (_userResponses.length > questionIndex) {
      _userResponses[questionIndex] = {
        'question': _questions[questionIndex].question,
        'answer': _questions[questionIndex].options[optionIndex],
        'answerIndex': optionIndex,
      };
    } else {
      _userResponses.add({
        'question': _questions[questionIndex].question,
        'answer': _questions[questionIndex].options[optionIndex],
        'answerIndex': optionIndex,
      });
    }
    
    setState(() {});
    
    // Move to next question after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      // Check if this is the last question
      if (questionIndex == _questions.length - 1) {
        // If it's the last question, go to the summary page
        _pageController.animateToPage(
          _questions.length + 1, // Summary page is after all questions
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        // Otherwise, go to the next question
        _nextPage();
      }
    });
  }
  
  void _finishOnboarding() {
    // In a real app, you'd save these responses to a user profile or preferences
    print('User responses:');
    for (var response in _userResponses) {
      print('Q: ${response['question']}');
      print('A: ${response['answer']}');
    }
    
    // Show confirmation dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Profile Updated'),
        content: const Text(
          'Thank you for completing the quiz! Your responses will help us personalize your experience.',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              
              // Instead of using named route, use Get.offAll to ensure proper navigation
              // This will remove all previous routes and go back to the base page
              Get.offAllNamed('/'); // Navigate to root which should show the base page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Continue to App'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: _currentPage > 0 ? Colors.deepPurple : Colors.grey,
                    ),
                    onPressed: _currentPage > 0 ? _previousPage : null,
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (_currentPage + 1) / (_questions.length + 2), // +2 to account for welcome and summary pages
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            ),
            
            // Quiz content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  // Welcome page
                  _buildWelcomePage(),
                  
                  // Question pages
                  ..._questions.asMap().entries.map((entry) {
                    int idx = entry.key;
                    QuizQuestion question = entry.value;
                    return _buildQuestionPage(idx, question);
                  }),
                  
                  // Summary page
                  _buildSummaryPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.psychology,
            size: 80,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 40),
          const Text(
            'Welcome to R N B',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'Let\'s take a quick quiz to understand your goals and preferences. This will help us personalize your experience.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Start Quiz',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuestionPage(int questionIndex, QuizQuestion question) {
    final bool hasAnswered = _userResponses.length > questionIndex;
    final int? selectedIndex = hasAnswered ? _userResponses[questionIndex]['answerIndex'] : null;
    
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${questionIndex + 1} of ${_questions.length}',
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            question.question,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: question.options.length,
              itemBuilder: (context, optionIndex) {
                final bool isSelected = selectedIndex == optionIndex;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: () => _selectOption(questionIndex, optionIndex),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? Colors.deepPurple : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                        color: isSelected ? Colors.deepPurple.withOpacity(0.1) : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? Colors.deepPurple : Colors.grey,
                                width: 2,
                              ),
                              color: isSelected ? Colors.deepPurple : Colors.transparent,
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              question.options[optionIndex],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.deepPurple : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryPage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 80,
            color: Colors.green,
          ),
          const SizedBox(height: 30),
          const Text(
            'Quiz Completed!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'Thank you for sharing your preferences. We\'ll use this information to personalize your  sustainability journey.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          if (_userResponses.length == _questions.length)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Responses:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...List.generate(_userResponses.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. ${_userResponses[index]['question']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: Text(
                            _userResponses[index]['answer'],
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _finishOnboarding,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Continue to App',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  
  QuizQuestion({
    required this.question,
    required this.options,
  });
}
