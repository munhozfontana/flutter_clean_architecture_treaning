import 'package:flutter/material.dart';

class ContainerForm extends StatelessWidget {
  final List<Widget> listOfWidgets;
  ContainerForm({
    Key key,
    this.listOfWidgets = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 2),
              blurRadius: 9,
              spreadRadius: 0)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...listOfWidgets],
      ),
    );
  }
}
