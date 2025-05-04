import 'package:down_detect/viewmodels/doctor_profile_viewmodel.dart';
import 'package:down_detect/viewmodels/early_detection_viewmodel.dart';
import 'package:down_detect/viewmodels/fontscale_viewmodel.dart';
import 'package:down_detect/viewmodels/home_viewmodel.dart';
import 'package:down_detect/viewmodels/signup_viewmodel.dart';
import 'package:down_detect/viewmodels/therapist_viewmodel.dart';
import 'package:down_detect/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/auth_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => TherapistViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => EarlyDetectionViewModel()),
        ChangeNotifierProvider(create: (_) => DoctorProfileViewModel()),
        ChangeNotifierProvider(create: (_) => FontScaleViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<FontScaleViewModel>(
      builder: (context, fontScaleVM, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Down Detect',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(
                textScaler: TextScaler.linear(fontScaleVM.currentScale),
              ),
              child: child!,
            ); 
          },
          home: const SplashScreen(),
        );
      },
    );
  }
}
