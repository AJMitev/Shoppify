import 'package:flutter/material.dart';
import 'package:shoppify/items_list.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopify',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ItemsListPage(title: 'Shopify Home Page'),
    );
  }
}
