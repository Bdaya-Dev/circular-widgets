import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';

import 'config_widget.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  ExamplePageState createState() => ExamplePageState();
}

class ExamplePageState extends State<ExamplePage> {
  int length = 5;
  CircularWidgetConfig config = const CircularWidgetConfig(
    innerSpacing: 0,
    itemRadius: 20,
    centerWidgetRadius: 50,
    startAngleDeg: -90,
    totalArchDeg: 360,
    isClockwise: true,
    isAddExtraFakeItem: true,
    drawOrder: CircularLayoutDrawOrder.itemsOnTop,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Circular Widgets'),
      ),
      // Use Layout builder for responsive behaviour
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: CircularWidgets(
              config: config,
              itemsLength: length,
              itemBuilder: (context, index) {
                // Can be any widget, preferably a circle
                return SingleCircle(
                  txt: index.toString(),
                  color: Colors.grey,
                );
              },
              centerWidgetBuilder: (context) {
                return const SingleCircle(
                  txt: 'Center',
                  color: Colors.red,
                );
              },
            ),
          ),
          Expanded(
            child: ConfigWidget(
              config: config,
              valueSetter: (newVal) {
                setState(() {
                  config = newVal;
                });
              },
              itemsLength: length,
              itemsLengthSetter: (newVal) {
                setState(() {
                  length = newVal;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SingleCircle extends StatelessWidget {
  final String txt;
  final Color color;
  const SingleCircle({
    Key? key,
    required this.txt,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(child: Text(txt)),
    );
  }
}
