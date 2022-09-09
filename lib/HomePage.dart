import 'package:fluent_ui/fluent_ui.dart' hide MenuItem;
import 'package:tray_manager/tray_manager.dart';
import 'package:xlotus/FirstPage.dart';
import 'package:xlotus/NewsPage.dart';
import 'package:xlotus/util/image_utils.dart';
import 'package:xlotus/widgets/load_image.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TrayListener {
  final TrayManager _trayManager = TrayManager.instance;
  void _generateIcon() async {
    await _trayManager
        .setIcon(ImageUtils.getImgPath("app_icon", format: ImageFormat.ico));
    await _trayManager.setToolTip('你想干嘛😒');
  }

  void _generateContextMenu() async {
    Menu menu = Menu(items: [
      MenuItem(label: '首页'),
      MenuItem(label: '新闻'),
      MenuItem.separator(),
      MenuItem.submenu(
        key: 'arts',
        label: '工具',
        submenu: Menu(items: [
          MenuItem(label: '工具1'),
          MenuItem(label: '工具2'),
          MenuItem(label: '工具3'),
        ]),
      ),
      MenuItem.separator(),
      MenuItem(label: '关于xlotus')
    ]);
    await trayManager.setContextMenu(menu);
  }

  int index = 0;

  @override
  void initState() {
    super.initState();
    _generateIcon();
    _generateContextMenu();
    _trayManager.addListener(this);
  }

  @override
  void dispose() {
    _trayManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
        pane: NavigationPane(
            selected: index,
            onChanged: (i) => setState(() => index = i),
            displayMode: PaneDisplayMode.open,
            size: const NavigationPaneSize(
              openWidth: 150,
            ),
            header: const LoadImage(
              'header',
              format: ImageFormat.jpg,
              fit: BoxFit.fill,
              width: 150,
            ),
            items: [
              PaneItem(
                icon: const Icon(FluentIcons.icon_sets_flag),
                title: const Text("首页"),
              ),
              PaneItem(
                  icon: const Icon(FluentIcons.e_discovery),
                  title: const Text("新闻")),
              PaneItem(
                  icon: const Icon(FluentIcons.flow_template),
                  title: const Text("工具")),
              PaneItem(
                  icon: const Icon(FluentIcons.edit_note),
                  title: const Text("关于"))
            ]),
        content: NavigationBody(index: index, children: const [
          FirstPage(),
          NewsPage(),
          Text("3"),
          Text("4"),
        ]));
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    print('你选择了${menuItem.label}');
    switch (menuItem.label) {
      case '首页':
        setState(() {
          index = 0;
        });
        break;
      case '新闻':
        setState(() {
          index = 1;
        });
        break;
      case '工具':
        setState(() {
          index = 2;
        });
        break;
      case '关于xlotus':
        setState(() {
          index = 3;
        });
        break;
    }
  }

  @override
  void onTrayIconRightMouseUp() {
    print('右击鼠标抬起');
  }

  @override
  void onTrayIconRightMouseDown() async {
    await _trayManager.popUpContextMenu();
  }

  @override
  void onTrayIconMouseUp() {
    print('托盘图标鼠标抬起');
  }

  @override
  void onTrayIconMouseDown() {
    print('托盘图标点击');
  }
}
