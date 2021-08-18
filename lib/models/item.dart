import 'dart:developer';

import 'package:supabase/supabase.dart';
import '../database.dart';

class Item {
  String id;
  String name;
  bool isBought;

  Item(this.name, {this.isBought = false, this.id = ''});

  static Future<List<Item>> fetchAll() async {
    var response = await Database.client
        .from('items')
        .select()
        .order('isBought', ascending: true)
        .execute();

    if (response.error != null) {
      print('error: ${response.error?.message}');
    }

    List<Item> items = [];
    response.data.forEach((x) {
      items.add(
          Item(x['name'].toString(), isBought: x['isBought'], id: x['id']));
    });

    return items;
  }

  static addNew(Item item) async {
    await Database.client.from('items').insert([item.toJson()]).execute();
  }

  static update(Item item) async {
    await Database.client
        .from('items')
        .update(item.toJson(), returning: ReturningOption.minimal)
        .match({'id': item.id}).execute();
  }

  static remove(String id) async {
    await Database.client.from('items').delete().match({'id': id}).execute();
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'isBought': this.isBought,
      };
}
