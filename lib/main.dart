import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkdekutree/widgets/circle_button.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Link Deku Tree',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Image.network(
                        'https://castrors.github.io/img/profile.png'),
                  ),
                  Text(
                    '@rodrigocastro_o',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('links')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, stream) {
                if (stream.connectionState == ConnectionState.waiting) {
                  return Expanded(
                      child: Center(child: CircularProgressIndicator()));
                }
                if (stream.hasError) {
                  print(stream.error);
                  return Text('Something unexpected happened');
                }

                var querySnapshot = stream.data;
                return Expanded(
                  child: ListView.builder(
                    itemCount: querySnapshot.size,
                    itemBuilder: (context, index) {
                      final link = querySnapshot.docs[index];
                      return Card(
                        color: Colors.green.shade800,
                        child: ListTile(
                          title: Text(
                            link['title'],
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () => _launchURL(link['url']),
                        ),
                      );
                    },
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleButton(
                  child: FaIcon(FontAwesomeIcons.linkedin),
                  onPressed: () =>
                      _launchURL('https://www.linkedin.com/in/castrodev/'),
                ),
                CircleButton(
                  child: FaIcon(FontAwesomeIcons.twitter),
                  onPressed: () =>
                      _launchURL('https://twitter.com/rodrigocastro_o'),
                ),
                CircleButton(
                  child: FaIcon(FontAwesomeIcons.github),
                  onPressed: () => _launchURL('https://github.com/castrors'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
