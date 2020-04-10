import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magpie_fly/magpie_fly.dart';
import 'component/video_component.dart';
import 'component/text_component.dart';

class VideoFeedDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<VideoFeedDemo> {
  List<String> dataList = [
    'http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4',
    'http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4',
    'http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4',
    'http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4',
    'http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4',
    'http://vfx.mtime.cn/Video/2019/03/18/mp4/190318214226685784.mp4',
    'http://vfx.mtime.cn/Video/2019/03/19/mp4/190319104618910544.mp4',
    'http://vfx.mtime.cn/Video/2019/03/19/mp4/190319125415785691.mp4',
    'http://vfx.mtime.cn/Video/2019/03/17/mp4/190317150237409904.mp4',
    'http://vfx.mtime.cn/Video/2019/03/14/mp4/190314223540373995.mp4',
    'http://vfx.mtime.cn/Video/2019/03/14/mp4/190314102306987969.mp4',
    'http://vfx.mtime.cn/Video/2019/03/13/mp4/190313094901111138.mp4',
    'http://vfx.mtime.cn/Video/2019/03/12/mp4/190312143927981075.mp4',
    'http://vfx.mtime.cn/Video/2019/03/12/mp4/190312083533415853.mp4',
    'http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4',
    '庆祝澳门回归祖国20周年特别报道',
    '这次升旗，意义非凡！',
    '情系濠江 习近平和澳门的故事',
    '坚定维护党中央权威和集中统一领导',
    '倾听中国声音 共建美好世界 庆祝澳门回归20周年',
    '我国钢铁消费增长何以超预期',
    '奋力完成好明年经济工作重点任务',
    '消费品质量安全形势总体平稳 以“民生之暖”保稳定促发展',
    '多项经济指标超预期 外媒：中国经济企稳信号增强',
    '教育部解读两个《意见》——切实减轻中小学教师负担',
    '2020年全国硕士研究生招生考试21日开考 341万人报名',
    '教育部公布“双高计划”学校名单 197所高职院校入选',
    '山东舰交接入列仪式的举办地点怎么安排?海军回应',
    '四川资中5.2级地震已致9人受伤 其中重伤4人',
    '最高人民法院：极严重的性侵儿童罪犯判处死刑',
    '香港大学新学期将于1月如期开学，2020内地招生政策不变',
    '台“大选”电视辩论会将登场 韩国瑜蔡英文宋楚瑜正面交锋',
    '台媒：2020年台湾选举“不分区立委”政党票号次出炉',
    '美国朝鲜问题特使本周将访华 外交部：欢迎',
  ]..shuffle(Random.secure());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollDetectListener(
        detect: true,
        percentIn: 1 /*(0-1]*/,
        offset: 60 /*Appbar height*/,
        onVisible: (metas, model) {
          var videoItem = model.videoData;
          if (metas != null && metas.length > 0) {
            var meta = metas[0] as VideoMeta;
            var targetData = dataList[meta.index];
            if (videoItem == null ||
                (videoItem != null && videoItem != targetData)) {
              model.updateVideo(meta.index, targetData);
            }
          } else if (videoItem != null) {
            model.updateVideo(-1, null);
          }
        },
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (_, i) => dataList[i].startsWith('http')
              ? VideoComponent(i, dataList[i])
              : TextComponent(dataList[i]),
          separatorBuilder: (_, i) => Divider(
            height: 1,
          ),
          itemCount: dataList.length,
        ),
      ),
    );
  }
}
