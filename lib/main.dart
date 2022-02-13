import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/services/firestore.dart';
import 'package:quiz_app/services/models.dart';
import 'package:quiz_app/theme.dart';
// import 'package:provider/provider.dart';
// import 'package:quizapp/services/services.dart';
// import 'package:quizapp/shared/shared.dart';
// import 'package:quizapp/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // Error screen
          return Text('error', textDirection: TextDirection.ltr);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider(
            create: (_) => FirestoreService().streamReport(),
            catchError: (_, err) => Report(),
            initialData: Report(),
            child: MaterialApp(
                debugShowCheckedModeBanner: true,
                routes: appRoutes,
                theme: appTheme),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text('loading', textDirection: TextDirection.ltr);

        // return const MaterialApp(home: LoadingScreen());
      },
    );
  }
}
