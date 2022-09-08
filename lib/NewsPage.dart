import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:xlotus/util/image_utils.dart';
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
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 280.0,
              pinned: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: SizedBox(
                    child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const LoadImage(
                      'header',
                      format: ImageFormat.jpg,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 280,
                    ),
                    GlassmorphicContainer(
                      width: double.infinity,
                      height: 280,
                      borderRadius: 0,
                      blur: 8,
                      alignment: Alignment.center,
                      border: 1,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.1),
                          const Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: const [
                          0.1,
                          1,
                        ],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.5),
                          const Color((0xFFFFFFFF)).withOpacity(0.5),
                        ],
                      ),
                      child: GFCarousel(
                        hasPagination: true,
                        autoPlay: false,
                        height: 265,
                        autoPlayInterval: const Duration(seconds: 6),
                        items: imageList.map(
                          (url) {
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                child: Image.network(url,
                                    fit: BoxFit.cover, width: 1000.0),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ];
        },
        body: Scaffold(
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
              separatorBuilder: (context, index) => const Divider(height: .0),
              itemCount: list.length),
        ));
  }
}
