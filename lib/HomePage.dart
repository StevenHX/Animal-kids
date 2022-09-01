import 'package:fluent_ui/fluent_ui.dart';

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
        appBar: NavigationAppBar(
            title: const Text(
              'Cute Animal Child',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
            actions: Row(children: const []),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue.lighter),
        pane: NavigationPane(
            selected: index,
            onChanged: (i) => setState(() => index = i),
            displayMode: PaneDisplayMode.compact,
            items: [
              PaneItem(
                icon: const Icon(FluentIcons.icon_sets_flag),
                title: const Text("Sample Page 1"),
                infoBadge: const InfoBadge(
                  source: Text("9"),
                ),
              ),
              PaneItem(
                  icon: const Icon(FluentIcons.e_discovery),
                  title: const Text("Sample Page 2")),
              PaneItem(
                  icon: const Icon(FluentIcons.flow_template),
                  title: const Text("Sample Page 3")),
              PaneItem(
                  icon: const Icon(FluentIcons.edit_note),
                  title: const Text("Sample Page 4"))
            ]),
        content: NavigationBody(index: index, children: const [
          Text("1"),
          Text("2"),
          Text("3"),
          Text("4"),
        ]));
  }
}
