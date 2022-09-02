import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/components/tabs/gf_tabbar.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:steven_flutter/util/image_utils.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  var tabs = 2;
  var isChecked = false;
  late material.TabController tabController;
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    tabController = material.TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: TabView(
        currentIndex: currentIndex,
        onChanged: (index) => setState(() => currentIndex = index),
        tabs: List.generate(tabs, (index) {
          return Tab(
              text: Text('Tab $index'),
              closeIcon: FluentIcons.chrome_close,
              onClosed: () {
                setState(() => tabs--);
              });
        }),
        bodies: List.generate(
            tabs,
            (index) => material.Scaffold(
                  body: material.SingleChildScrollView(
                    child: Column(
                      children: [
                        GFAppBar(
                          leading: GFIconButton(
                            icon: const Icon(
                              material.Icons.arrow_back,
                              color: material.Colors.white,
                            ),
                            onPressed: () {},
                            type: GFButtonType.transparent,
                          ),
                          title: const Text("GF Appbar"),
                          actions: <Widget>[
                            GFIconButton(
                              icon: const Icon(
                                material.Icons.more_horiz,
                                color: material.Colors.white,
                              ),
                              onPressed: () {},
                              type: GFButtonType.transparent,
                            ),
                          ],
                        ),
                        GFTabBar(
                          length: 3,
                          controller: tabController,
                          tabs: const [
                            material.Tab(
                              icon: Icon(material.Icons.directions_bike),
                              child: Text(
                                "Tab1",
                              ),
                            ),
                            material.Tab(
                              icon: Icon(material.Icons.directions_bus),
                              child: Text(
                                "Tab2",
                              ),
                            ),
                            material.Tab(
                              icon: Icon(material.Icons.directions_railway),
                              child: Text(
                                "Tab3",
                              ),
                            ),
                          ],
                        ),
                        GFButton(
                          onPressed: () {},
                          text: "primary",
                          shape: GFButtonShape.pills,
                        ),
                        GFButton(
                          onPressed: () {},
                          text: "primary",
                          shape: GFButtonShape.pills,
                          type: GFButtonType.outline,
                        ),
                        GFCheckbox(
                          size: GFSize.SMALL,
                          activeBgColor: GFColors.DANGER,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value;
                            });
                          },
                          value: isChecked,
                        ),
                        ToggleSwitch(
                            checked: _checked,
                            onChanged: (v) => setState(() => _checked = v),
                            content: Text(_checked ? 'On' : 'Off')),
                        const GFLoader(
                          type: GFLoaderType.custom,
                          loaderIconOne: Icon(material.Icons.insert_emoticon),
                          loaderIconTwo: Icon(material.Icons.insert_emoticon),
                          loaderIconThree: Icon(material.Icons.insert_emoticon),
                        ),
                        const GFLoader(
                          type: GFLoaderType.custom,
                          loaderIconOne: Text('Please'),
                          loaderIconTwo: Text('Wait'),
                          loaderIconThree: Text('a moment'),
                        ),
                        GestureDetector(
                          onTap: () => GFToast.showToast(
                            'GetFlutter is an open source library that comes with pre-build 1000+ UI components.',
                            context,
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 20),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7)),
                                color: GFColors.DARK,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.40),
                                      blurRadius: 5)
                                ]),
                            child: const GFListTile(
                                color: GFColors.DARK,
                                title: Text(
                                  'Show Toast',
                                  style: TextStyle(color: GFColors.WHITE),
                                ),
                                icon: Icon(
                                  CupertinoIcons.forward,
                                  color: GFColors.SUCCESS,
                                )),
                          ),
                        ),
                        GFImageOverlay(
                          height: 200,
                          width: 300,
                          image: ImageUtils.getAssetImage('me_press'),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.darken),
                          child: const Center(
                            child: Text('Flutter Image overlay example Code',
                                style: TextStyle(color: GFColors.LIGHT)),
                          ),
                        ),
                        GFImageOverlay(
                          height: 200,
                          width: 200,
                          shape: BoxShape.circle,
                          boxFit: BoxFit.cover,
                          image: ImageUtils.getAssetImage('me_press'),
                        ),
                        GFCard(
                          boxFit: BoxFit.cover,
                          image: Image.asset(ImageUtils.getImgPath('inject',
                              format: ImageFormat.webp)),
                          title: GFListTile(
                            avatar: GFAvatar(
                              backgroundImage:
                                  ImageUtils.getAssetImage('me_press'),
                            ),
                            title: const Text('Card Title'),
                            subTitle: const Text('Card Sub Title'),
                          ),
                          content: const Text(
                              "Some quick example text to build on the card"),
                          buttonBar: GFButtonBar(
                            children: <Widget>[
                              GFButton(
                                onPressed: () {},
                                text: 'Buy',
                              ),
                              GFButton(
                                onPressed: () {},
                                text: 'Cancel',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
