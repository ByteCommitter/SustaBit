import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sa_chat_page.dart';

class SALibraryPage extends StatelessWidget {
  const SALibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students Anonymous Library'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header section
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.deepPurple.withOpacity(0.1),
            child: const Column(
              children: [
                Text(
                  'The Human Library',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Our team acts as a human library, helping with mental health by listening and providing support to everyone on campus.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Click on a book to connect with a team member',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          // Bookshelf
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/wooden_shelf.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.brown.withOpacity(0.7),
                    BlendMode.color,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0), // Increased padding
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.58, // Adjusted for thinner books
                    crossAxisSpacing: 20, // Increased spacing between books
                    mainAxisSpacing: 10, // Increased vertical spacing
                  ),
                  itemCount: _saTeamMembers.length,
                  itemBuilder: (context, index) {
                    final member = _saTeamMembers[index];
                    return _buildBookItem(context, member);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookItem(BuildContext context, SATeamMember member) {
    return GestureDetector(
      onTap: () {
        // Navigate to chat with this team member
        Get.to(() => SAChatPage(teamMember: member));
      },
      child: Container(
        decoration: BoxDecoration(
          color: member.bookColor,
          borderRadius: BorderRadius.circular(2), // Even smaller corner radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Book spine - even thinner
            Container(
              height: 50, // Shorter spine
              width: 6, // Thinner spine
              color: member.bookColor.withOpacity(0.7),
              margin: const EdgeInsets.only(left: 1), // Smaller margin
            ),
            
            // Book title (rotated)
            Expanded(
              child: Center(
                child: RotatedBox(
                  quarterTurns: 1, // Rotate 90 degrees
                  child: Text(
                    member.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12, // Smaller font
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            
            // Book subject - thinner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), // Smaller padding
              alignment: Alignment.center,
              color: Colors.black26,
              child: Text(
                member.specialty,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 7, // Even smaller font
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model class for SA team members
class SATeamMember {
  final String id;
  final String name;
  final String specialty;
  final String bio;
  final Color bookColor;
  final List<String> presetMessages;

  const SATeamMember({
    required this.id,
    required this.name,
    required this.specialty,
    required this.bio,
    required this.bookColor,
    required this.presetMessages,
  });
}

// Hardcoded SA team members
final List<SATeamMember> _saTeamMembers = [
  SATeamMember(
    id: 'sa1',
    name: 'Dr. Emma Wilson',
    specialty: 'Anxiety & Stress',
    bio: 'Clinical psychologist with 10 years of experience helping students manage anxiety and stress.',
    bookColor: Colors.deepPurple,
    presetMessages: [
      "Hi there! I'm Dr. Emma. How can I support you today?",
      "Remember that feeling anxious is a normal response to stress. Let's talk about it.",
      "Would you like to learn some breathing techniques that can help in moments of stress?",
    ],
  ),
  SATeamMember(
    id: 'sa2',
    name: 'Michael Chen',
    specialty: 'Peer Support',
    bio: 'Graduate student and trained peer counselor who has personal experience with overcoming depression.',
    bookColor: Colors.teal,
    presetMessages: [
      "Hey! I'm Michael. I'm here to listen without judgment.",
      "As someone who's been through similar struggles, I understand how overwhelming things can get.",
      "Would you like to share what's been on your mind lately?",
    ],
  ),
  SATeamMember(
    id: 'sa3',
    name: 'Sophia Rodriguez',
    specialty: 'Academic Pressure',
    bio: 'Education counselor specializing in helping students navigate academic stress and expectations.',
    bookColor: Colors.indigo,
    presetMessages: [
      "Hi, I'm Sophia. Feeling overwhelmed with coursework?",
      "Let's discuss some strategies to balance your academic responsibilities.",
      "Remember that your worth isn't determined by your grades or achievements.",
    ],
  ),
  SATeamMember(
    id: 'sa4',
    name: 'James Thompson',
    specialty: 'Grief & Loss',
    bio: 'Licensed therapist with expertise in helping individuals process grief and navigate significant life changes.',
    bookColor: Colors.amber.shade800,
    presetMessages: [
      "Hello, I'm James. I create a safe space for discussing difficult emotions.",
      "Grief can come in many forms. How has your experience been?",
      "It's okay to not be okay. I'm here to support you through this process.",
    ],
  ),
  SATeamMember(
    id: 'sa5',
    name: 'Aisha Patel',
    specialty: 'Cultural Adaptation',
    bio: 'International student advisor who helps students navigate cultural transitions and identity challenges.',
    bookColor: Colors.pink.shade700,
    presetMessages: [
      "Hi, I'm Aisha. Adjusting to a new environment can be challenging.",
      "I'd love to hear about your experiences and how you've been coping.",
      "What aspects of the transition have been most difficult for you?",
    ],
  ),
  SATeamMember(
    id: 'sa6',
    name: 'David Nguyen',
    specialty: 'LGBTQ+ Support',
    bio: 'Counselor and advocate for LGBTQ+ students, focusing on identity, acceptance, and community building.',
    bookColor: Colors.blue.shade800,
    presetMessages: [
      "Hello! I'm David. This is a judgment-free zone where you can be yourself.",
      "How have you been feeling about your identity and place in the community?",
      "Would you like to discuss resources or support groups available on campus?",
    ],
  ),
  SATeamMember(
    id: 'sa7',
    name: 'Maya Johnson',
    specialty: 'Relationship Issues',
    bio: 'Counselor specializing in interpersonal relationships, communication skills, and boundary setting.',
    bookColor: Colors.red.shade700,
    presetMessages: [
      "Hi, I'm Maya. Navigating relationships can be complex.",
      "How have your connections with others been affecting your well-being?",
      "Let's talk about healthy boundaries and communication strategies.",
    ],
  ),
  SATeamMember(
    id: 'sa8',
    name: 'Alex Kim',
    specialty: 'Substance Use',
    bio: 'Recovery coach who provides non-judgmental support for students dealing with substance use concerns.',
    bookColor: Colors.green.shade800,
    presetMessages: [
      "Hey there, I'm Alex. I'm here to listen and support, not to judge.",
      "Would you like to talk about how substance use has been impacting your life?",
      "There are many paths to wellness. Let's explore what might work for you.",
    ],
  ),
  SATeamMember(
    id: 'sa9',
    name: 'Olivia Martinez',
    specialty: 'Self-Esteem',
    bio: 'Positive psychology practitioner focused on building self-worth, resilience, and personal strengths.',
    bookColor: Colors.purple.shade800,
    presetMessages: [
      "Hello! I'm Olivia. I believe in your inherent worth and potential.",
      "How has your relationship with yourself been lately?",
      "Let's explore the unique strengths you possess that you might not fully recognize yet.",
    ],
  ),
];
