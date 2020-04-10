import 'package:flutter/material.dart';
import 'package:magpie_fly/magpie_fly.dart';

class BannerWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BannerCardState();
}

class BannerCardState extends State<BannerWidgetDemo> {
  @override
  Widget build(BuildContext context) {
    List dataList = [
      {
        "image":
            "https:\/\/pic1.ajkimg.com\/display\/anjuke\/0aa79ba5fc359b552c2467b8d71d0972\/1035x429c.jpg?t=5",
        "jump_action":
            "openanjuke:\/\/jump\/core\/common?params=%7B%22url%22%3A%22https%3A%5C%2F%5C%2Fm.anjuke.com%5C%2Factivity%5C%2Fhuati%5C%2Fvoting%3Fis_title_transparent%3D1%26from%3Dreyi%22%2C%22title%22%3A%22%22%2C%22device_id%22%3A%22%22%2C%22list_name%22%3A%22%22%2C%22ajk_type%22%3A%220%22%2C%22pagetype%22%3A%22common%22%2C%22categoryid%22%3A%22%22%2C%22loadingtype%22%3A%220%22%2C%22backtoroot%22%3A%22false%22%2C%22domainTips%22%3A%22%22%2C%22backprotocal%22%3A%22%22%2C%22webType%22%3A%22%22%2C%22save_step%22%3Afalse%2C%22pullRefresh%22%3Afalse%2C%22settings%22%3A%7B%22hide_title_panel%22%3Afalse%2C%22contain_status_bar%22%3Atrue%2C%22status_bar_mode%22%3A%22%22%2C%22status_bar_color%22%3A%22%22%7D%7D&isFinish=false&needLogin=false&isBackToMain=false&isSlideinBottom=false&isNoAnimated=false"
      },
      {
        "image":
            "https:\/\/pic1.ajkimg.com\/display\/anjuke\/7c7caca19bf78e8f486cfe768944c62a\/1035x429c.jpg?t=5",
        "jump_action":
            "openanjuke:\/\/jump\/core\/common?params=%7B%22url%22%3A%22https%3A%5C%2F%5C%2Fm.anjuke.com%5C%2Fkol%5C%2Fpolylist%5C%2F%3Fid%3D323%22%2C%22title%22%3A%22%22%2C%22device_id%22%3A%22%22%2C%22list_name%22%3A%22%22%2C%22ajk_type%22%3A%220%22%2C%22pagetype%22%3A%22common%22%2C%22categoryid%22%3A%22%22%2C%22loadingtype%22%3A%220%22%2C%22backtoroot%22%3A%22false%22%2C%22domainTips%22%3A%22%22%2C%22backprotocal%22%3A%22%22%2C%22webType%22%3A%22%22%2C%22save_step%22%3Afalse%2C%22pullRefresh%22%3Afalse%2C%22settings%22%3A%7B%22hide_title_panel%22%3Afalse%2C%22contain_status_bar%22%3Atrue%2C%22status_bar_mode%22%3A%22%22%2C%22status_bar_color%22%3A%22%22%7D%7D&isFinish=false&needLogin=false&isBackToMain=false&isSlideinBottom=false&isNoAnimated=false"
      }
    ];

    return BannerWidget(
        height: 60,
        width: MediaQuery.of(context).size.width,
        data: dataList,
        buildShowView: (index, data) {
          //print(data);
          return Image.network(
            data["image"],
            height: 100.0,
            //设置图片的高
            width: 100.0,
            //设置图片的宽
            fit: BoxFit.cover,
            //BoxFit.fill  全图显示，显示可能拉伸或者充满  BoxFit.contain  全图显示 显示原比例，不需充满   BoxFit.cover 显示可能拉伸可能剪裁充满  BoxFit.fitWidth显示可能拉伸可能剪裁，宽度充满   BoxFit.fitHeight显示可能拉伸可能充满，高度充满  BoxFit.scaleDown  效果和contain差不多,但是此属性不允许显示超过源图片大小，可小不可大
            color: Colors.black,
            colorBlendMode: BlendMode.dstOver,
            //color colorBlendMode具体效果后面再研究，我也没太弄懂,应该是一个类似混合模式的东东
            alignment: Alignment.center, //可以控制实际图片在容器内的位置
          );
        },
        onBannerClickListener: (index, data) {
          print(index);
        });
  }
}
