import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TypeInput {
  blue,
  red,
}

class BtnForm extends StatelessWidget {
  final double width;
  final String text;
  final TypeInput typeInput;
  final Function onTap;

  const BtnForm({
    Key key,
    this.width = 0.18,
    this.text = "NameInput",
    this.typeInput = TypeInput.blue,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var widthInput = mediaQuery.width * width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 59.00,
        width: widthInput,
        decoration: BoxDecoration(
          color: _buildColor(),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 2.00),
              color: Color(0xff000000).withOpacity(0.16),
              blurRadius: 9,
            ),
          ],
          borderRadius: BorderRadius.circular(5.00),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 28,
              color: Color(0xfff6f6f6),
            ),
          ),
        ),
      ),
    );
  }

  Color _buildColor() {
    switch (typeInput) {
      case TypeInput.blue:
        return Color(0xff6b9fc2);
        break;
      case TypeInput.red:
        return Colors.red;
        break;
      default:
        return Colors.green;
    }
  }
}
