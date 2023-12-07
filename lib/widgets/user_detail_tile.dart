import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.head,
    required this.value,
  });
  final String head;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Text(
          head,
          style: TextStyle(fontSize: 15),
        ),
        title: Text(value),
      ),
    );
  }
}
