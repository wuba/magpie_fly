import 'package:flutter/material.dart';
import 'package:magpie_fly/magpie_fly.dart';
import 'package:magpie_fly_example/demo/horizonal_scroll/component/card.dart';
// import 'component/card.dart';

class HorizontalScrollCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: HorizontalScrollView(
        itemCount: 10,
        footerWidth: 70,
        onFooterLoadingCallBack: () {
          print('开始加载');
        },
        footerView: Container(
          color: Color.fromRGBO(237, 239, 241, 1),
          width: 70,
          child: Center(
            child: Text('自定义footerview', style: TextStyle(color: Color.fromRGBO(141, 145, 147, 1))),
          ),
        ),
        footerShowStyle: FooterViewShowStyle.dismiss,
        itembuilder: (context, index) {
          return CardWidget.card(Color.fromRGBO(240, 242, 255, 1));
        },
      ),
    );
  }

  
}
