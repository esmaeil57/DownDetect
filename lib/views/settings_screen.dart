import 'package:down_detect/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/fontscale_viewmodel.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  bool _fontSizeExpanded = false;

  @override
  Widget build(BuildContext context) {
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

              ],
            ),
          ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Provider.of<AuthViewModel>(context, listen: false).logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE53935), Color(0xFFFF6B6B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.logout, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
