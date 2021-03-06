import 'package:flutter/material.dart';
import 'package:shoppify/models/item.dart';
import 'constants/styles.dart';

class ItemsListPage extends StatefulWidget {
  ItemsListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ItemsListPageState createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
  final _items = <Item>[];
  final _itemAddController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  // @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        backgroundColor: Styles.primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (this._items.length == 0) {
      return Center(
          child: const Text(
        'Няма добавени продукти за покупка.',
        textAlign: TextAlign.center,
        style: Styles.NoItemsTitleTextStype,
      ));
    }

    return RefreshIndicator(
      child: ListView.builder(
          itemCount: this._items.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildListItem(this._items[index], index);
          }),
      onRefresh: () => this._loadItems(),
    );
  }

  Widget _buildListItem(Item item, int index) {
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => _removeItem(item.id, index),
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
            style: item.isBought
                ? Styles.BoughtItemTextStyle
                : Styles.ItemTextStyle),
        tileColor: Colors.grey.shade100,
        leading: Icon(
          item.isBought ? Icons.check_box : Icons.check_box_outline_blank,
          color: item.isBought ? Styles.primaryColor : null,
        ),
        onTap: () => _changeItemBoughtStatus(item));
  }

  _loadItems() async {
    final fetchedItems = await Item.fetchAll();
    fetchedItems.sort();
    setState(() {
      this._items.clear();
      this._items.addAll(fetchedItems);
    });
  }

  _changeItemBoughtStatus(Item item) async {
    item.isBought = !item.isBought;
    this._changeItemPositionToEdge(item);
    await Item.update(item);
    // this._loadItems();
  }

  _removeItem(String itemId, int index) async {
    setState(() {
      this._items.removeAt(index);
    });

    await Item.remove(itemId);
  }

  _addItem() {
    showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: const Text('Добавяне на продукт'),
              content: _buildAddItemContent(),
              actions: _buildCreateDialogButtons(),
            ));
  }

  Widget _buildAddItemContent() {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: TextField(
              keyboardType: TextInputType.text,
              cursorColor: Styles.primaryColor,
              controller: this._itemAddController,
              decoration: _buildInputDecorator()),
        )
      ],
    );
  }

  InputDecoration _buildInputDecorator() {
    return InputDecoration(
        hintText: 'Чушки',
        hintStyle: Styles.InputHintTextStyle,
        labelText: 'Продукт',
        labelStyle: Styles.InputLabelTextStyle,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.primaryColor, width: 1.0),
        ),
        hoverColor: Styles.primaryColor);
  }

  List<Widget> _buildCreateDialogButtons() {
    return <Widget>[
      _buildButton('Затвори', _closeDialog, Styles.cancelButton),
      _buildButton('Добави', _addNewItemToBuy, Styles.primaryButton)
    ];
  }

  _addNewItemToBuy() async {
    if (this._itemAddController.text.trim().isEmpty) {
      return;
    }

    String itemName = this._itemAddController.text;
    var firstChar = itemName[0];
    itemName = itemName.replaceFirst(firstChar, firstChar.toUpperCase());

    if (this
            ._items
            .where((element) =>
                element.name.toLowerCase() == itemName.toLowerCase())
            .length >
        0) {
      showDialog(context: context, builder: _buildAlertDialog);
      return;
    }

    this._itemAddController.text = "";
    final createdItem = Item(itemName);

    this._items.add(createdItem);
    this._changeItemPositionToEdge(createdItem);

    await Item.addNew(createdItem);

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

  _changeItemPositionToEdge(Item item) {
    setState(() {
      this._items.sort();
    });
  }
}
