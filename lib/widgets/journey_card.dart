import 'package:flutter/material.dart';
import '../data/models/journey.dart';

class JourneyCard extends StatelessWidget {
  final Journey journey;
  final int index;

  const JourneyCard({
    super.key,
    required this.journey,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey[300],
                child: Text(
                  journey.name.isNotEmpty ? journey.name[0] : '?',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          journey.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (journey.relation.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(
                            "(${journey.relation}, age ${journey.childAge})",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Story
                    Text(
                      journey.story,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        height: 1.5,
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
}