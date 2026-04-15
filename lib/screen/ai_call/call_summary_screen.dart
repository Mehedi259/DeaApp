import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nowlii/core%20/app_routes/app_routes.dart';

class CallSummaryScreen extends StatelessWidget {
  const CallSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 54),
                
                // Avatar
                Container(
                  width: 100,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF4542EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 81,
                      height: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://placehold.co/81x80"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Title
                Text(
                  'GREAT JOB!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF011F54),
                    fontSize: 52,
                    fontFamily: 'Wosker',
                    fontWeight: FontWeight.w400,
                    height: 0.8,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Subtitle
                Text(
                  'You nailed it! Here\'s what Fuzzy noticed during chat.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF4C586E),
                    fontSize: 18,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    letterSpacing: -0.5,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Insights
                _buildInsightCard(
                  title: 'Mood detected',
                  description: 'You sounded calm and optimistic',
                  backgroundColor: const Color(0xFFFAE3CE),
                  icon: Icons.mood,
                ),
                
                const SizedBox(height: 8),
                
                _buildInsightCard(
                  title: 'Focus topic',
                  description: 'You talked about staying consistent.',
                  backgroundColor: const Color(0xFFDFEFFF),
                  icon: Icons.book,
                ),
                
                const SizedBox(height: 8),
                
                _buildInsightCard(
                  title: 'Energy shift',
                  description: 'You started tired but ended excited',
                  backgroundColor: const Color(0xFFDFEFFF),
                  icon: Icons.bolt,
                ),
                
                const SizedBox(height: 8),
                
                _buildInsightCard(
                  title: 'Next step',
                  description: 'Plan your next quest!',
                  backgroundColor: const Color(0xFFDFEFFF),
                  icon: Icons.trending_up,
                ),
                
                const SizedBox(height: 32),
                
                // Personal note section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Add personal note',
                        style: TextStyle(
                          color: const Color(0xFF011F54),
                          fontSize: 16,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 87,
                      padding: const EdgeInsets.all(24),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFDF7),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            color: const Color(0xFFC3DBFF),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Write short note to yourself...',
                          hintStyle: TextStyle(
                            color: const Color(0xFF4C586E),
                            fontSize: 16,
                            fontFamily: 'Work Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            letterSpacing: -0.5,
                          ),
                          border: InputBorder.none,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: OutlinedButton(
                        onPressed: () {
                          context.go(AppRoutespath.homeScreen);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 2,
                            color: const Color(0xFF6A68EF),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                        child: Text(
                          'Dismiss',
                          style: TextStyle(
                            color: const Color(0xFF4542EB),
                            fontSize: 20,
                            fontFamily: 'Work Sans',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {
                          // Save reflection logic
                          context.go(AppRoutespath.homeScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3F3CD6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                        child: Text(
                          'Save reflection',
                          style: TextStyle(
                            color: const Color(0xFFFFFDF7),
                            fontSize: 20,
                            fontFamily: 'Work Sans',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInsightCard({
    required String title,
    required String description,
    required Color backgroundColor,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4542EB),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF011F54),
                    fontSize: 18,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w900,
                    height: 0.8,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: TextStyle(
                    color: const Color(0xFF011F54),
                    fontSize: 16,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
