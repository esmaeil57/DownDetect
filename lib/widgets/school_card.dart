import 'package:flutter/material.dart';
import '../data/models/school.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolCard extends StatelessWidget {
  final School school;
  final int index;

  const SchoolCard({
    super.key,
    required this.school,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final cardPadding = isTablet ? 20.0 : 16.0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with logo and name
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // School logo placeholder
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.school,
                      color: Colors.blue[700],
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // School name and type
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          school.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isTablet ? 18 : 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Type: ${school.type}",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: isTablet ? 14 : 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Location
              if (school.location.isNotEmpty) ...[
                _buildInfoRow(
                  icon: Icons.location_on_outlined,
                  label: "Location:",
                  value: school.location,
                  isTablet: isTablet,
                ),
                const SizedBox(height: 8),
              ],

              // Contact if available
              if (school.contact.isNotEmpty) ...[
                _buildInfoRow(
                  icon: Icons.phone_outlined,
                  label: "Contact:",
                  value: school.contact,
                  isTablet: isTablet,
                ),
                const SizedBox(height: 8),
              ],

              // Website
              _buildInfoRow(
                icon: Icons.language_outlined,
                label: "Website:",
                value: school.website,
                isTablet: isTablet,
                isLink: true,
              ),

              const SizedBox(height: 16),

              // Description
              Text(
                school.description,
                style: TextStyle(
                  fontSize: isTablet ? 15 : 13,
                  height: 1.5,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isTablet,
    bool isLink = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: isTablet ? 18 : 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: isTablet ? 14 : 13,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: isLink
              ? GestureDetector(
            onTap: () {
              // Launch website URL
              final url = "https://${value.toLowerCase()}";
              launchUrl(Uri.parse(url));
            },
            child: Text(
              value,
              style: TextStyle(
                fontSize: isTablet ? 14 : 13,
                color: Colors.blue[700],
                decoration: TextDecoration.underline,
              ),
            ),
          )
              : Text(
            value,
            style: TextStyle(
              fontSize: isTablet ? 14 : 13,
            ),
          ),
        ),
      ],
    );
  }
}