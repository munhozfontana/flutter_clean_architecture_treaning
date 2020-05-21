import 'package:flutter/cupertino.dart';

class IptLabel extends StatelessWidget {
  const IptLabel({
    Key key,
    @required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 5, left: 5, right: 5),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Roboto',
          color: Color(0xff6a6a6a),
          fontSize: 13,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
