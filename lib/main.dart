import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkdekutree/widgets/circle_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'link.dart';

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
  final links = [
    Link(
        title: 'Meu canal no Youtube',
        url: 'https://www.youtube.com/channel/UCPRdmUZXiPz5_2XokXsPPbA'),
    Link(title: 'Meu portfólio', url: 'https://castrors.github.io/'),
    Link(
        title: 'Trilha + Montanha russa em Alpsee Bergwelt na Alemanha',
        url: 'https://www.youtube.com/watch?v=MdUm6kmihN4'),
  ];

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
          Expanded(
            child: ListView.builder(
              itemCount: links.length,
              itemBuilder: (context, index) {
                final link = links[index];
                return Card(
                  color: Colors.green.shade800,
                  child: ListTile(
                    title: Text(
                      link.title,
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => _launchURL(link.url),
                  ),
                );
              },
            ),
          ),
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
