import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'features/auth/presentation/view/pages/create_request/view/request_screan.dart';
import 'features/auth/presentation/view/widgets/register/client_Register_layout.dart';
import 'firebase_options.dart';
import 'features/auth/presentation/view/pages/login/login_page.dart';
import 'features/auth/data/Repo/hive_auth_service.dart';
import 'features/auth/presentation/view/pages/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("authBox");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final hiveService = HiveAuthService();
  final uid = hiveService.getUid();

  Widget initialPage = const SplashScreen();

  if (uid != null) {
    final doc = await FirebaseFirestore.instance.collection('clients').doc(uid).get();
    if (doc.exists && doc.data()?['email'] != null) {
      initialPage = const CreateRequestScreen();
    } else {
      initialPage = const LoginPage();
    }
  }

  runApp(MyApp(initialPage: initialPage));
}

class MyApp extends StatelessWidget {
  final Widget initialPage;
  const MyApp({super.key, required this.initialPage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => initialPage,
        '/client_register': (context) => const ClientRegisterPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
