import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'ipt_label.dart';

enum IptFormFieldEnum { dragDrop, dropDown }

class IptField extends StatelessWidget {
  final double heightPx;
  final double width;
  final String label;
  final IptFormFieldEnum inputFormFieldEnum;
  final Function onChanged;
  final int maxLines;
  final MaskTextInputFormatter mask;
  final TextEditingController textEditingController;

  const IptField({
    Key key,
    @required this.heightPx,
    this.width = 0.3,
    this.label = "Label",
    this.inputFormFieldEnum,
    this.onChanged,
    this.maxLines = 120,
    this.mask,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var widthInput = mediaQuery.width * width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IptLabel(label: label),
        buildInput(widthInput, mediaQuery),
      ],
    );
  }

  Widget buildInput(double widthInput, Size mediaQuery) {
    switch (inputFormFieldEnum) {
      case IptFormFieldEnum.dropDown:
        return buildDragDrop(widthInput);
        break;
      default:
        return buildDefault(widthInput, mediaQuery);
    }
  }

  Stack buildDefault(double widthInput, Size mediaQuery) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          height: heightPx,
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
          child: mask == null
              ? TextFormField(
                  onChanged: onChanged,
                  decoration: defaloutDecoration,
                  maxLines: maxLines,
                  controller: textEditingController,
                )
              : TextFormField(
                  onChanged: onChanged,
                  decoration: defaloutDecoration,
                  inputFormatters: [mask],
                  controller: textEditingController,
                ),
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
    );
  }

  Container buildDragDrop(double widthInput) {
    return Container(
      height: heightPx * 3.3,
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

InputDecoration defaloutDecoration = InputDecoration(
  hintText: 'Email',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  hintStyle: TextStyle(
    color: Colors.white,
  ),
  focusedBorder: InputBorder.none,
  contentPadding: EdgeInsets.all(16),
  enabledBorder: InputBorder.none,
);
