import 'package:flutter/material.dart';
import 'package:magpie_fly/magpie_fly.dart';

class SearchInputDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(15),
            child: SearchInput(
              hintTextColor: Colors.grey,
              isBorderShadow: true,
              blurRadius: 5.0,
              circleRadius: 5.0,
              prefixIconColor: Colors.grey,
              hintText: "带阴影的TextFiled",
              borderColor: Colors.grey,
              onChanged: (text){
                print(text);
              },
            )),
        Container(
            margin: EdgeInsets.all(15),
            child: SearchInput(
              circleRadius: 5.0,
              isBorderShadow: false,
              hintText: "不带阴影的TextFiled",
              borderColor: Colors.blue,
            ))
      ],
    );
  }
}
