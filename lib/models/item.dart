import '../database.dart';

class Item {
  final String name;
  bool isBought;
  Item(this.name, {this.isBought = false});

  static Future<List<Item>> fetchAll() async {
    var response = await Database.client.from('items').select().execute();

    if (response.error != null) {
      print('error: ${response.error?.message}');
    }

    List<Item> items = [];
    response.data.forEach((x) {
      items.add(Item(x['name'].toString(), isBought: x['isBought']));
    });

    return items;
  }
}
