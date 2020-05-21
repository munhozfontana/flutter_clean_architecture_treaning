import 'package:flutter/material.dart';

class DragDrop extends StatefulWidget {
  final double heightPx;
  final double width;

  const DragDrop({
    Key key,
    @required this.heightPx,
    this.width = 0.3,
  }) : super(key: key);

  @override
  _DragDropState createState() => _DragDropState();
}

class _DragDropState extends State<DragDrop> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var widthInput = mediaQuery.width * widget.width;

    return Container(
      height: widget.heightPx * 3.3,
      width: widthInput,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 2),
              blurRadius: 9,
              spreadRadius: 0)
        ],
      ),
      child: Center(
        child: Icon(
          Icons.cloud_upload,
          size: 50,
        ),
      ),
    );
  }
}
