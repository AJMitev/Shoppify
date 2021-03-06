import 'package:flutter/material.dart';
import 'package:shoppify/items_list.dart';
import 'constants/styles.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopify',
      theme: ThemeData(
          buttonColor: Styles.primaryColor,
          primaryColor: Styles.primaryColor,
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(headline6: Styles.AppBarTextStype)),
          textTheme: TextTheme(headline6: Styles.TitleTextStype)),
      home: ItemsListPage(title: 'Shopify List'),
    );
  }
}
