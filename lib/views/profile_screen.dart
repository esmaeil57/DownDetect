import 'dart:convert';
import 'package:down_detect/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/auth_viewmodel.dart';
import '../view_model/profile_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    // Initialize viewModel in the next frame to avoid build errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel = Provider.of<ProfileViewModel>(context, listen: false);
      // Check for user changes and refresh data if needed
      _viewModel.checkForUserChange();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This ensures we check for user changes when navigating back to this screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
        viewModel.checkForUserChange();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error loading profile',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadUserProfile(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final user = viewModel.user;
          if (user == null) {
            return const Center(child: Text('No user data available'));
          }

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Header with Image
                  _buildProfileHeader(context, viewModel, screenSize),

                  SizedBox(height: screenSize.height * 0.04),

                  // User Information Cards
                  _buildInfoCard(
                    context: context,
                    title: 'Personal Information',
                    children: [
                      _buildInfoRow('Name', user.name),
                      _buildInfoRow('Email', user.email),
                      _buildInfoRow('Role', _capitalizeRole(user.role)),
                    ],
                    iconData: Icons.person,
                    isDarkMode: isDarkMode,
                    screenSize: screenSize,
                  ),

                  SizedBox(height: screenSize.height * 0.02),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _capitalizeRole(String role) {
    if (role.isEmpty) return '';
    return role.toUpperCase();
  }

  Widget _buildProfileHeader(BuildContext context, ProfileViewModel viewModel, Size screenSize) {
    return Column(
      children: [
        Stack(
          children: [
            // Profile Image
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: screenSize.width * 0.15,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                child: _buildProfileImage(viewModel),
              ),
            ),
          ],
        ),

        SizedBox(height: screenSize.height * 0.02),

        // User Name
        Text(
          viewModel.user?.name ?? 'User',
          style: TextStyle(
            fontSize: screenSize.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: screenSize.height * 0.005),

        // User Email
        Text(
          viewModel.user?.email ?? 'email@example.com',
          style: TextStyle(
            fontSize: screenSize.width * 0.035,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(ProfileViewModel viewModel) {
    if (viewModel.profileImage != null) {
      return ClipOval(
        child: Image.file(
          viewModel.profileImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else if (viewModel.cachedProfileImagePath != null) {
      try {
        // Try to decode the base64 image
        final bytes = base64Decode(viewModel.cachedProfileImagePath!);
        return ClipOval(
          child: Image.memory(
            bytes,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) => _defaultProfileImage(),
          ),
        );
      } catch (e) {
        return _defaultProfileImage();
      }
    } else {
      return _defaultProfileImage();
    }
  }

  Widget _defaultProfileImage() {
    return const Icon(
      Icons.person,
      size: 80,
      color: Colors.grey,
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required String title,
    required List<Widget> children,
    required IconData iconData,
    required bool isDarkMode,
    required Size screenSize,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenSize.width * 0.05),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                color: Theme.of(context).colorScheme.primary,
                size: screenSize.width * 0.06,
              ),
              SizedBox(width: screenSize.width * 0.03),
              Text(
                title,
                style: TextStyle(
                  fontSize: screenSize.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(height: screenSize.height * 0.04),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value.isNotEmpty ? value : 'Not provided',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<AuthViewModel>(context, listen: false).logout(context);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

}