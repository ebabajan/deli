
import 'dart:io';
import 'package:delidove_api/models/grocery_item.dart';
import 'package:delidove_api/widgets/new_item.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:delidove_api/config.dart';



//import 'package:delidove_api/data/dummy_items.dart';

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  @override
  void initState(){
    super.initState();
  }

  void _addItem() async
  {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const NewItem())
    );
    if(newItem == null){
      return;  
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item)
  {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  

  void getCategories() async {
    final url = Config.url + Config.productCat;
    final credential = Config.token;

    _bypassSslVerificationForHttpClient();

    var header = {'Authorization': 'Basic $credential'};

    var dio = Dio();
    var response = await dio.request(
      url,
      options: Options(
        method: 'GET',
        headers: header,
      ),
    );
    print(response);
    
  }

  void _bypassSslVerificationForHttpClient() {
    HttpOverrides.global = _MyHttpOverrides();
  }

  @override
  Widget build(BuildContext context) {
    getCategories();
    Widget content = const Center(
      child:  Text('No Items to Show yet'),
    );

    if(_groceryItems.isNotEmpty){
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);  
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed:(){
              _addItem();
            } , 
            icon: const Icon(Icons.add)
          )
         ],
      ),
      body: content,
      
    );
  }
}
