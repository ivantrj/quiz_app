import 'package:flutter/material.dart';
import 'package:quiz_app/services/firestore.dart';
import 'package:quiz_app/shared/bottom_nav.dart';
import 'package:quiz_app/shared/error.dart';
import 'package:quiz_app/shared/loading.dart';
import 'package:quiz_app/services/models.dart';
import 'package:quiz_app/topics/topic_item.dart';
import 'package:quiz_app/topics/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text('Topics'),
              actions: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.userCircle,
                    color: Colors.pink[200],
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                )
              ],
            ),
            drawer: TopicDrawer(topics: topics),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}
