import 'package:shoppify/models/item.dart';

import '../models/item.dart';

class MockItem {
  static Item fetchAny() {
    return Item("Домат");
  }

  static List<Item> fetchAll() {
    return <Item>[
      Item("Домати"),
      Item("Краставици"),
      Item("Яйца"),
      Item(
        "Бадеми",
      ),
      Item("Кисело Мляко"),
      Item("Лютеница", isBought: true),
    ];
  }
}
