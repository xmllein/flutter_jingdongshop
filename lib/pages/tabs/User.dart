import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/Counter.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    var counterProvider = Provider.of<Counter>(context);
    return Scaffold(
      body: Center(
        child: Text('User Page ${counterProvider.count}'),
      ),
    );
  }
}
