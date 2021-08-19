import 'dart:developer';

import 'package:supabase/supabase.dart';
import 'package:uuid/uuid.dart';
import '../database.dart';

class Item implements Comparable<Item> {
  String id = Uuid().v4();
  String name;
  bool isBought;
  DateTime createdOn = DateTime.now().toUtc();

  Item(this.name, {this.isBought = false});

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
      var item = Item(x['name'].toString(), isBought: x['isBought']);
      item.id = x['id'];
      item.createdOn = DateTime.parse(x['createdOn']);
      items.add(item);
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
        'createdOn': this.createdOn.toString(),
      };

  @override
  int compareTo(Item other) {
    return this.isBought == other.isBought
        ? this.createdOn.isBefore(other.createdOn)
            ? -1
            : 1
        : this.isBought
            ? 1
            : -1;
  }
}
