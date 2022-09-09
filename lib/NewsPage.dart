import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:xlotus/widgets/load_image.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ];
  List<String> list = [
    '1111111',
    '2222222',
    '33333333',
    '44444444',
    '55555555',
    '66666666',
    '777777',
    '312312312312',
    '312312312312',
    '312312312312',
    '312312312312',
    '312312312312',
    '312312312312',
    '312312312312',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minWidth: 1200, maxWidth: MediaQuery.of(context).size.width),
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Scaffold(
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    //显示列表项
                    return GestureDetector(
                      onTap: () => GFToast.showToast(
                        '${list[index]}GetFlutter is an open source library that comes with pre-build 1000+ UI components.',
                        context,
                      ),
                      child: const GFListTile(
                        avatar: GFAvatar(
                          backgroundColor: Colors.transparent,
                          child: LoadImage("earth"),
                        ),
                        titleText: '111',
                        subTitleText:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing',
                        icon: Icon(Icons.more_horiz),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: .0),
                  itemCount: list.length),
            ),
          ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '这是一个标题',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 300,
                    color: Colors.grey.shade800,
                  ),
                  Container(
                    width: 200,
                    height: 300,
                    color: Colors.grey.shade700,
                  ),
                  Container(
                    width: 200,
                    height: 300,
                    color: Colors.grey.shade600,
                  ),
                  Container(
                    width: 200,
                    height: 300,
                    color: Colors.grey.shade500,
                  ),
                  Container(
                    width: 200,
                    height: 300,
                    color: Colors.grey.shade400,
                  ),
                  Container(
                    width: 200,
                    height: 300,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
