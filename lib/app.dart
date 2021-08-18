import 'package:flutter/material.dart';
import 'package:shoppify/items_list.dart';
import 'styles.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopify',
      theme: ThemeData(
          primarySwatch: Colors.green,
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(headline6: Styles.AppBarTextStype)),
          textTheme: TextTheme(headline6: Styles.TitleTextStype)),
      home: ItemsListPage(title: 'Shopify Home Page'),
    );
  }
}
