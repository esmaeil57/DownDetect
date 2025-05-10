import 'package:down_detect/view_model/doctor_profile_viewmodel.dart';
import 'package:down_detect/view_model/early_detection_viewmodel.dart';
import 'package:down_detect/view_model/fontscale_viewmodel.dart';
import 'package:down_detect/view_model/home_viewmodel.dart';
import 'package:down_detect/view_model/prediction_viewmodel.dart';
import 'package:down_detect/view_model/signup_viewmodel.dart';
import 'package:down_detect/view_model/therapist_viewmodel.dart';
import 'package:down_detect/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/auth_viewmodel.dart';

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
        ChangeNotifierProvider(create: (_)=> PredictionViewModel())
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
