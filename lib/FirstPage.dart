import 'package:fluent_ui/fluent_ui.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPage> {
  int currentIndex = 0;
  var tabs = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: TabView(
        currentIndex: currentIndex,
        onChanged: (index) => setState(() => currentIndex = index),
        onNewPressed: () {
          setState(() => tabs++);
        },
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
          (index) => Text(index.toString()),
        ),
      ),
    );
  }
}
