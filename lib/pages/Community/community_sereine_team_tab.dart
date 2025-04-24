import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentalsustainability/theme/app_colors.dart';
import 'sa_chat_page.dart';
import 'models/community_models.dart';

class CommunitySeireineTeamTab extends StatelessWidget {
  final List<SATeamMember> saTeamMembers;
  
  const CommunitySeireineTeamTab({
    Key? key,
    required this.saTeamMembers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header section with minimal description
        Container(
          padding: const EdgeInsets.all(20),
          color: AppColors.primary.withOpacity(0.1),
          child: Column(
            children: [
              Text(
                'The Human Library',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              // Minimal description - to be updated later by user
              const SizedBox(height: 8),
              Text(
                'Click on a book to connect with a peer supporter',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Bookshelf with background and columns
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Container(
              decoration: BoxDecoration(
                // Bookshelf background
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: const AssetImage('assets/images/wood_texture.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.brown.shade700.withOpacity(0.8), 
                    BlendMode.multiply
                  ),
                ),
                // Add a rounded roof to the bookshelf
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.shade900.withOpacity(0.6),
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Bookshelf roof
                  Container(
                    height: 20,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade900,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  
                  // Row 1 of bookshelf
                  _buildBookshelfRow(
                    [saTeamMembers[0], saTeamMembers[1], saTeamMembers[2]],
                    Colors.brown.shade800,
                  ),
                  
                  // Row 2 of bookshelf
                  _buildBookshelfRow(
                    [saTeamMembers[3], saTeamMembers[4], saTeamMembers[5]],
                    Colors.brown.shade700,
                  ),
                  
                  // Row 3 of bookshelf
                  _buildBookshelfRow(
                    [saTeamMembers[6], saTeamMembers[7], saTeamMembers[8]],
                    Colors.brown.shade600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  // Helper method to build a row of the bookshelf
  Widget _buildBookshelfRow(List<SATeamMember> rowMembers, Color shelfColor) {
    return Expanded(
      child: Column(
        children: [
          // Books container
          Expanded(
            flex: 5,
            child: Row(
              children: [
                // Left decorative column - narrower
                _buildBookshelfColumn(15),
                
                // Books section with proper spacing
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: rowMembers.map((member) => _buildBook(member)).toList(),
                    ),
                  ),
                ),
                
                // Right decorative column - narrower
                _buildBookshelfColumn(15),
              ],
            ),
          ),
          
          // Shelf
          Container(
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: shelfColor,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          
          // Space below shelf
          const SizedBox(height: 8),
        ],
      ),
    );
  }
  
  // Helper method to build decorative column with customizable width
  Widget _buildBookshelfColumn(double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.brown.shade900,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
  
  // Helper method to build an individual book with horizontal text
  Widget _buildBook(SATeamMember member) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      child: GestureDetector(
        onTap: () {
          // Navigate to chat with this team member
          Get.to(() => SAChatPage(teamMember: member));
        },
        child: Container(
          width: 65, // Reduced from 80
          // Reduce height to fix overflow by adding negative bottom margin
          margin: const EdgeInsets.only(bottom: 34),
          height: double.infinity,
          decoration: BoxDecoration(
            color: member.bookColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(6),
              bottomLeft: Radius.circular(2),
              bottomRight: Radius.circular(2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3,
                offset: const Offset(2, 1),
              ),
            ],
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
              color: Colors.black38,
              width: double.infinity,
              child: Text(
                member.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14, // Reduced from 16
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
