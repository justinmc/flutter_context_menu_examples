import 'package:flutter/material.dart';

import 'anywhere_page.dart';
import 'small_changes_page.dart';
import 'email_button_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Validation Sandbox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: <String, Widget Function(BuildContext)>{
        '/': (BuildContext context) => const MyHomePage(),
        AnywherePage.route: (BuildContext context) => const AnywherePage(),
        SmallChangesPage.route: (BuildContext context) => SmallChangesPage(),
        EmailButtonPage.route: (BuildContext context) => const EmailButtonPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContextualMenu Demos'),
      ),
      body: ListView(
        children: const <Widget>[
          MyListItem(
            route: AnywherePage.route,
            title: AnywherePage.title,
            subtitle: AnywherePage.subtitle,
          ),
          MyListItem(
            route: SmallChangesPage.route,
            title: SmallChangesPage.title,
            subtitle: SmallChangesPage.subtitle,
          ),
          MyListItem(
            route: EmailButtonPage.route,
            title: EmailButtonPage.title,
            subtitle: EmailButtonPage.subtitle,
          ),
        ],
      ),
    );
  }
}

class MyListItem extends StatelessWidget {
  const MyListItem({
    Key? key,
    required this.route,
    required this.subtitle,
    required this.title,
  }) : super(key: key);

  final String route;
  final String subtitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
        margin: const EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
          ),
        ),
      ),
    );
  }
}
