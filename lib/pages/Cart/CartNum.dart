import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

class CartNum extends StatefulWidget {
  CartNum({Key? key}) : super(key: key);

  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Column(
      children: <Widget>[Text("${cartProvider.cartNum}")],
    );
  }
}
