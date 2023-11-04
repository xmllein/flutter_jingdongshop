import 'package:flutter/material.dart';
import 'package:flutter_jdshop/provider/Counter.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var counterProvider = Provider.of<Counter>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.incCount();
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text('Cart Page ${counterProvider.count}'),
      ),
    );
  }
}
