import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ipt_label.dart';

class IptDropDown extends StatefulWidget {
  final double heightPx;
  final double width;
  final String label;
  final DropdownButton dropdownbutton;

  const IptDropDown({
    Key key,
    @required this.heightPx,
    this.width = 0.3,
    this.label = "Label",
    this.dropdownbutton,
  }) : super(key: key);

  @override
  _IptDropDownState createState() => _IptDropDownState();
}

class _IptDropDownState extends State<IptDropDown> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var widthInput = mediaQuery.width * widget.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IptLabel(label: widget.label),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              height: widget.heightPx,
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
              child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 10),
                  child: widget.dropdownbutton),
            ),
            Container(
              margin: EdgeInsets.all(5),
              height: 50,
              width: mediaQuery.width * .008,
              decoration: BoxDecoration(
                color: Color(0xff65a76c),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x29000000),
                      offset: Offset(3, 3),
                      blurRadius: 6,
                      spreadRadius: 0)
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
