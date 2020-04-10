import 'package:flutter/material.dart';
import 'package:magpie_fly/magpie_fly.dart';

class DragBtnDemo extends StatefulWidget {
  @override
  _DragBtnDemoState createState() => _DragBtnDemoState();
}

class _DragBtnDemoState extends State<DragBtnDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black12,
      child: DraggableBtn(
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          alignment: Alignment.center,
          child: Icon(Icons.favorite, color: Colors.yellow,),
        ),
        initOffset: Offset(MediaQuery
            .of(context)
            .size
            .width - 100,
            MediaQuery
                .of(context)
                .size
                .height - 300),
        fullScreenOffset: Offset(0, 100),
      ),
    );
  }
}
