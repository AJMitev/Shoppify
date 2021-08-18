import 'package:flutter/material.dart';
import 'package:shoppify/mock/mock_item.dart';
import 'package:shoppify/models/item.dart';
import 'styles.dart';

class ItemsListPage extends StatefulWidget {
  ItemsListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ItemsListPageState createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
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
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (this._items.length == 0) {
      return Center(child: const Text('Няма добавени продукти за покупка.'));
    }

    return ListView.builder(
        itemCount: this._items.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(this._items[index]);
        });
  }

  Widget _buildListItem(Item item) {
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => _removeItem,
        child: _buildItem(item),
        background: _buildListItemBackground());
  }

  Widget _buildItem(Item item) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: _buildTile(item));
  }

  Widget _buildListItemBackground() {
    return Container(
        color: Colors.red.shade900,
        margin: EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ));
  }

  Widget _buildTile(Item item) {
    return ListTile(
        title: Text("${item.name}",
            style: TextStyle(
                decoration: item.isBought ? TextDecoration.lineThrough : null)),
        tileColor: Colors.grey.shade100,
        leading: Icon(
          item.isBought ? Icons.check_box : Icons.check_box_outline_blank,
          color: item.isBought ? Colors.green.shade300 : null,
        ),
        onTap: () => _changeItemBoughtStatus(item));
  }

  _changeItemBoughtStatus(Item item) {
    setState(() {
      item.isBought = !item.isBought;
      if (item.isBought) {
        this._items.remove(item);
        this._items.add(item);
      }
    });
  }

  _removeItem(int index) {
    setState(() {
      this._items.removeAt(index);
    });
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
                _buildButton('Затвори', _closeDialog, Styles.cancelButton),
                _buildButton('Добави', _addNewItemToBuy, Styles.primaryButton)
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
      showDialog(context: context, builder: _buildAlertDialog);
      return;
    }

    setState(() {
      this._items.add(newItem);
      this._itemAddController.text = "";
    });

    Navigator.of(context).pop();
  }

  AlertDialog _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Внимание!'),
      content: _buildDialogContent("Продукт с това име вече съществува!"),
      actions: <Widget>[
        _buildButton('Добре', _closeDialog, Styles.cancelButton)
      ],
    );
  }

  Widget _buildButton(String text, Function()? onPressed, ButtonStyle style) {
    return TextButton(onPressed: onPressed, style: style, child: Text(text));
  }

  Widget _buildDialogContent(String dialogContent) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[Text(dialogContent)],
    );
  }

  _closeDialog() {
    this._itemAddController.text = "";
    Navigator.of(context).pop();
  }
}
