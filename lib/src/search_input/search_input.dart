import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final Color borderColor;
  final Color fillColor;
  final String hintText;
  final double blurRadius;
  final double circleRadius;
  final Color hintTextColor;
  final Color prefixIconColor;
  final bool isBorderShadow;
  final bool enabel;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onSubmitted;
  final TextEditingController controller;

  SearchInput(
      {Key key,
      this.borderColor,
      this.fillColor = Colors.white,
      this.hintText,
      this.hintTextColor,
      this.blurRadius = 5.0,
      this.circleRadius = 10.0,
      this.isBorderShadow = true,
      this.prefixIconColor,
      this.enabel,
      this.controller,
      this.onChanged,
      this.onEditingComplete, 
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isBorderShadow
          ? BoxDecoration(
              color: fillColor,
              boxShadow: [
                BoxShadow(color: borderColor, blurRadius: blurRadius),
              ],
              borderRadius: BorderRadius.all(Radius.circular(circleRadius)))
          : null,
      child: TextField(
        controller: controller ?? TextEditingController(),
        enabled: enabel,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search,
                color: prefixIconColor ?? Theme.of(context).accentColor),
            border: _createBorder(),
            enabledBorder: _createBorder(),
            hintText: hintText,
            hintStyle: TextStyle(color: hintTextColor)),
      ),
    );
  }

  InputBorder _createBorder() {
    if (!isBorderShadow) {
      return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(blurRadius));
    }
    return InputBorder.none;
  }
}
