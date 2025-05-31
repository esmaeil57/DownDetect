import 'package:down_detect/view_model/community_view_model.dart';
import 'package:down_detect/view_model/doctor_profile_viewmodel.dart';
import 'package:down_detect/view_model/early_detection_viewmodel.dart';
import 'package:down_detect/view_model/fontscale_viewmodel.dart';
import 'package:down_detect/view_model/home_viewmodel.dart';
import 'package:down_detect/view_model/prediction_viewmodel.dart';
import 'package:down_detect/view_model/profile_viewmodel.dart';
import 'package:down_detect/view_model/signup_viewmodel.dart';
import 'package:down_detect/view_model/tab_view_model.dart';
import 'package:down_detect/view_model/therapist_viewmodel.dart';
import 'package:down_detect/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/network/api_client.dart';
import 'view_model/auth_viewmodel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final authViewModel = AuthViewModel();
  await authViewModel.initialize(); // Load token & user before app starts
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>.value(value: authViewModel),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => TherapistViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => EarlyDetectionViewModel()),
        ChangeNotifierProvider(create: (_) => DoctorProfileViewModel()),
        ChangeNotifierProvider(create: (_) => FontScaleViewModel()),
        ChangeNotifierProvider(create: (_) => PredictionViewModel()),
        ChangeNotifierProvider(create: (_) => TabViewModel()),
        ChangeNotifierProvider(create: (_) => CommunityViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel())
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
            primarySwatch: Colors.teal,
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
