import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/fontscale_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  bool _fontSizeExpanded = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fontScaleVM = Provider.of<FontScaleViewModel>(context);
    final primaryColor = const Color(0xFF0E6C73);
    final secondaryColor = const Color(0xCB17B7BC);
    final textColor = _fontSizeExpanded ? Colors.white : Colors.black;

    return Column(
      children: [
        PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 4,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              height: MediaQuery.of(context).size.height*0.13,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0E6C73), Color(0xFF199CA4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical:20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Icon(Icons.settings, color: Colors.white, size: 24),
                  SizedBox(width: 8),
                  Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _fontSizeExpanded = !_fontSizeExpanded;
                    });
                  },
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                    decoration: BoxDecoration(
                      gradient: _fontSizeExpanded
                          ? LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                          : const LinearGradient(
                        colors: [Colors.white, Color(0xF2F4FFFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        if (!_fontSizeExpanded)
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        if (_fontSizeExpanded)
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 12,
                            offset: const Offset(0, 8),
                          ),
                      ],
                    ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 400),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                                child: const Text("Adjust Font Size"),
                              ),
                            ),
                            AnimatedRotation(
                              turns: _fontSizeExpanded ? 0.5 : 0.0,
                              duration: const Duration(milliseconds: 400),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 24,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        AnimatedCrossFade(
                          firstChild: const SizedBox.shrink(),
                          secondChild: Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                "Current Size: ${(fontScaleVM.currentScale * 100).round()}%",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Colors.white,
                                  inactiveTrackColor: Colors.white30,
                                  thumbColor: Colors.white,
                                  overlayColor: Colors.white12,
                                ),
                                child: Slider(
                                  value: fontScaleVM.currentScale,
                                  min: 0.8,
                                  max: 1.6,
                                  divisions: 8,
                                  label: "${(fontScaleVM.currentScale * 100).round()}%",
                                  onChanged: (value) {
                                    fontScaleVM.setScale(value);
                                  },
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    fontScaleVM.resetToSystemDefault();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: primaryColor,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    elevation: 6,
                                  ),
                                  child: const Text(
                                    "Reset to System Default",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          crossFadeState: _fontSizeExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 400),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildInfoCard(
                  context: context,
                  title: 'Account Management',
                  children: [
                    _buildActionButton(
                      context: context,
                      label: 'Change Password',
                      onPressed: () {
                        // Implement password change functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Change password feature coming soon')),
                        );
                      },
                      icon: Icons.lock,
                      color: primaryColor,
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      context: context,
                      label: 'Delete Account',
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Delete Account Will be Available Soon'))
                      ),
                      icon: Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ],
                  iconData: Icons.settings,
                  isDarkMode: isDarkMode,
                  screenSize: screenSize,
                ),

              ],
            ),
          ),
      ],
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
                color: Color(0xFF0E6C73) ,
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
}

