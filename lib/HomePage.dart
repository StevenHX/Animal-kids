import 'package:fluent_ui/fluent_ui.dart';
import 'package:xlotus/FirstPage.dart';
import 'package:xlotus/util/device_utils.dart';
import 'package:xlotus/util/image_utils.dart';
import 'package:xlotus/widgets/load_image.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
        pane: NavigationPane(
            selected: index,
            onChanged: (i) => setState(() => index = i),
            displayMode: PaneDisplayMode.open,
            size: const NavigationPaneSize(
              openWidth: 160,
            ),
            header: const LoadImage(
              'header',
              format: ImageFormat.jpg,
              fit: BoxFit.fill,
              width: 160,
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
        content: NavigationBody(index: index, children: [
          Device.isMobile ? const Text('1') : const FirstPage(),
          const Text("2"),
          const Text("3"),
          const Text("4"),
        ]));
  }
}
