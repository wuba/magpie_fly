import 'fullscreen_effect.dart';
import '../util/parse_markdown.dart';
import 'package:flutter/material.dart';

class EffectPlaceHolder extends StatelessWidget {
  final Model model;

  const EffectPlaceHolder({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => FullScreenEffect(model: model,))),
      child: Container(
        alignment: Alignment.center,
        height: 44,
        margin: const EdgeInsets.only(bottom: 20, left: 60, right: 60),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(width:1, color:Theme.of(context).primaryColor)
        ),
        child: Text(
          "点击查看效果&代码",
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14.0),
        ),
      ),
    );
  }
}
