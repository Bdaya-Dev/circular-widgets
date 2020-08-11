import 'dart:math';

import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExampleWidget());
}

class ExampleWidget extends StatefulWidget {
  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  int length = 5;
  double innerSpacingDivider = 10;
  double radiusOfItemDivider = 6;
  double centerWidgetRadiusDivider = 3;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test Circular Widgets'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() => length++);
              },
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() => length--);
              },
            ),
          ],
        ),
        // Use Layout builder for responsive behaviour
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ListTile(
                title: Text('Responsive Inner Spacing'),
                subtitle: Slider(
                  min: 1,
                  max: 30,
                  divisions: 29,
                  label: innerSpacingDivider.toStringAsFixed(2),
                  value: innerSpacingDivider,
                  onChanged: (newVal) =>
                      setState(() => innerSpacingDivider = newVal),
                ),
              ),
            ),
            //Wrap with Expanded for Layout Builder to work, since it requires bounded width and height
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  var smallestBoundary =
                      min(constraints.maxHeight, constraints.maxWidth);
                  return CircularWidgets(
                    itemsLength: length,
                    itemBuilder: (context, index) {
                      // Can be any widget, preferably a circle
                      return SingleCircle(
                        txt: index.toString(),
                        color: Colors.grey,
                      );
                    },
                    innerSpacing: smallestBoundary / innerSpacingDivider,
                    radiusOfItem: smallestBoundary / radiusOfItemDivider,
                    centerWidgetRadius:
                        smallestBoundary / centerWidgetRadiusDivider,
                    centerWidgetBuilder: (context) {
                      return SingleCircle(
                        txt: 'Center',
                        color: Colors.red,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: ListTile(
                title: Text('Responsive Center Radius'),
                subtitle: Slider(
                  min: 1,
                  max: 5,
                  divisions: 16,
                  label: centerWidgetRadiusDivider.toStringAsFixed(2),
                  value: centerWidgetRadiusDivider,
                  onChanged: (newVal) =>
                      setState(() => centerWidgetRadiusDivider = newVal),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: ListTile(
                title: Text('Responsive Item Radius'),
                subtitle: Slider(
                  min: 1,
                  max: 10,
                  divisions: 18,
                  label: radiusOfItemDivider.toStringAsFixed(2),
                  value: radiusOfItemDivider,
                  onChanged: (newVal) =>
                      setState(() => radiusOfItemDivider = newVal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleCircle extends StatelessWidget {
  final String txt;
  final Color color;
  const SingleCircle({Key key, @required this.txt, @required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Center(child: Text(txt)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
