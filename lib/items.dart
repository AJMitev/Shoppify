import 'package:flutter/material.dart';
import 'package:shoppify/mock/mock_item.dart';
import 'package:shoppify/models/item.dart';

class ItemsPage extends StatefulWidget {
  ItemsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final _items = <Item>[];
  final _itemAddController = TextEditingController();

  // @override
  Widget build(BuildContext context) {
    if (this._items.length == 0) {
      this._items.addAll(MockItem.fetchAll());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _createList(this._items),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _createList(List<Item> items) {
    if (items.length == 0) {
      return Center(child: const Text('Няма добавени продукти за покупка.'));
    }

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return _createListItem(items[index], index);
        });
  }

  Widget _createListItem(Item item, int index) {
    return Dismissible(
        key: UniqueKey(),

        // only allows the user swipe from right to left
        direction: DismissDirection.endToStart,

        // Remove this product from the list
        // In production enviroment, you may want to send some request to delete it on server side
        onDismissed: (_) {
          setState(() {
            this._items.removeAt(index);
          });
        },

        // Display item's title, price...
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            child: ListTile(
                title: Text("${item.name}",
                    style: TextStyle(
                        decoration:
                            item.isBought ? TextDecoration.lineThrough : null)),
                tileColor: Colors.grey.shade100,
                leading: Icon(
                  item.isBought
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: item.isBought ? Colors.green.shade300 : null,
                ),
                onTap: () => {
                      setState(() {
                        item.isBought = !item.isBought;
                        if (item.isBought) {
                          this._items.remove(item);
                          this._items.add(item);
                        }
                      })
                    })),
        background: Container(
            color: Colors.red.shade900,
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            )));
  }

  _addItem() {
    showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: const Text('Добави нов продукт към списъка'),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: this._itemAddController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Продукт',
                      ),
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                new TextButton(
                  onPressed: _closeAndClearDialog,
                  style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.grey.shade300)),
                  child: const Text('Затвори'),
                ),
                new TextButton(
                  onPressed: _addNewItemToBuy,
                  style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(color: Theme.of(context).primaryColor)),
                  child: const Text('Добави'),
                ),
              ],
            ));
  }

  _addNewItemToBuy() {
    if (this._itemAddController.text.trim().isEmpty) {
      return;
    }

    final newItem = Item(this._itemAddController.text);
    if (this._items.where((element) => element.name == newItem.name).length >
        0) {
      showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: const Text('Внимание!'),
                content: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Продукт с име ${newItem.name} вече съществува!")
                  ],
                ),
                actions: <Widget>[
                  new TextButton(
                    onPressed: _closeAndClearDialog,
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(color: Colors.grey)),
                    child: const Text('Добре'),
                  ),
                ],
              ));
      return;
    }

    setState(() {
      this._items.add(newItem);
      this._itemAddController.text = "";
    });

    Navigator.of(context).pop();
  }

  _closeAndClearDialog() {
    this._itemAddController.text = "";
    Navigator.of(context).pop();
  }
}
