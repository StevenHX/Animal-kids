import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/components/tabs/gf_tabbar.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:xlotus/util/device_utils.dart';
import 'package:xlotus/util/image_utils.dart';
import 'package:xlotus/widgets/load_image.dart';

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

  static const channel = MethodChannel("com.jk/battery");
  String value = '';
  String path = '';

  final people = {
    'Mass in B minor': 'Johann Sebastian Bach',
    'Third Symphony': 'Ludwig van Beethoven',
    'Serse': 'George Frideric Hendel',
  };

  Future getData() async {
    String batteryLevel;
    if (!Device.isAndroid) {
      batteryLevel = "no support get battery level";
    } else {
      try {
        //从原生种获取当前channel中的方法值
        final int result = await channel.invokeMethod("getBatteryInfo");
        batteryLevel = 'Battery level at $result % .';
      } on PlatformException catch (e) {
        batteryLevel = "Failed to get battery level: '${e.message}'.";
      }
    }
    setState(() {
      value = batteryLevel;
    });
  }

  void getFiles() async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'image',
      extensions: <String>['jpg', 'png', 'webp'],
    );
    final XFile? file = await openFile(
      acceptedTypeGroups: <XTypeGroup>[typeGroup],
      initialDirectory: r'C:\Users\huanxiao\Pictures',
      confirmButtonText: '嘿嘿嘿',
    );
    if (file != null) {
      setState(() {
        path = file.path;
      });
    }
  }

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
    return material.Scaffold(
      body: material.SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const LoadImage(
                  "https://hr.wingtech.com/cardImages/verifyBg/2.jpg",
                  width: 550,
                  height: 260,
                ),
                GlassmorphicContainer(
                  width: 450,
                  height: 240,
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
                  child: !Device.isWeb
                      ? Image.file(
                          File(path),
                          fit: BoxFit.contain,
                        )
                      : const LoadImage("earth"),
                ),
              ],
            ),
            GFAppBar(
              leading: GFIconButton(
                icon: const Icon(
                  material.Icons.arrow_back,
                  color: material.Colors.white,
                ),
                onPressed: () => getFiles(),
                type: GFButtonType.transparent,
              ),
              title: Text(value),
              actions: <Widget>[
                GFIconButton(
                  icon: const Icon(
                    material.Icons.more_horiz,
                    color: material.Colors.white,
                  ),
                  onPressed: () => getData(),
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
            GFCheckboxListTile(
              titleText: 'Arthur Shelby',
              subTitleText: 'By order of the peaky blinders',
              avatar: GFAvatar(
                backgroundImage: ImageUtils.getAssetImage('me_press'),
              ),
              size: 25,
              activeBgColor: Colors.green,
              type: GFCheckboxType.circle,
              activeIcon: const Icon(
                material.Icons.check,
                size: 15,
                color: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  isChecked = value;
                });
              },
              value: isChecked,
              inactiveIcon: null,
            ),
            TreeView(
              items: [
                TreeViewItem(
                  content: const Text('Work Documents'),
                  children: [
                    TreeViewItem(content: const Text('XYZ Functional Spec')),
                    TreeViewItem(content: const Text('Feature Schedule')),
                    TreeViewItem(content: const Text('Overall Project Plan')),
                    TreeViewItem(
                        content: const Text('Feature Resources Allocation')),
                  ],
                ),
                TreeViewItem(
                  content: const Text('Personal Documents'),
                  children: [
                    TreeViewItem(
                      content: const Text('Home Remodel'),
                      children: [
                        TreeViewItem(
                            content: const Text('Contractor Contact Info')),
                        TreeViewItem(content: const Text('Paint Color Scheme')),
                        TreeViewItem(
                            content: const Text('Flooring weedgrain type')),
                        TreeViewItem(
                            content: const Text('Kitchen cabinet style')),
                      ],
                    ),
                  ],
                ),
              ],
              selectionMode: TreeViewSelectionMode.none,
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
              content: Text(_checked ? 'On' : 'Off'),
            ),
            // const GFLoader(
            //   type: GFLoaderType.custom,
            //   loaderIconOne: Icon(material.Icons.insert_emoticon),
            //   loaderIconTwo: Icon(material.Icons.insert_emoticon),
            //   loaderIconThree: Icon(material.Icons.insert_emoticon),
            // ),
            // const GFLoader(
            //   type: GFLoaderType.custom,
            //   loaderIconOne: Text('Please'),
            //   loaderIconTwo: Text('Wait'),
            //   loaderIconThree: Text('a moment'),
            // ),
            GestureDetector(
              onTap: () => GFToast.showToast(
                'GetFlutter is an open source library that comes with pre-build 1000+ UI components.',
                context,
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    color: GFColors.DARK,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.40), blurRadius: 5)
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
              image: Image.asset(
                  ImageUtils.getImgPath('inject', format: ImageFormat.webp)),
              title: GFListTile(
                avatar: GFAvatar(
                  backgroundImage: ImageUtils.getAssetImage('me_press'),
                ),
                title: const Text('Card Title'),
                subTitle: const Text('Card Sub Title'),
              ),
              content:
                  const Text("Some quick example text to build on the card"),
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
    );
  }
}
