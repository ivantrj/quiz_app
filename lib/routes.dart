import 'package:quiz_app/about/about.dart';
import 'package:quiz_app/profile/profile.dart';
import 'package:quiz_app/login/login.dart';
import 'package:quiz_app/topics/topics.dart';
import 'package:quiz_app/home/home.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/about': (context) => const AboutScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/topics': (context) => const TopicsScreen(),
};
