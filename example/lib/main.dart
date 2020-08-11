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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test Circular Widgets'),
        ),
        // Use Layout builder for responsive behaviour
        body: LayoutBuilder(
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
              innerSpacing: smallestBoundary / 30,
              radiusOfItem: smallestBoundary / 8,
              centerWidgetRadius: smallestBoundary / 2,
              centerWidgetBuilder: (context) {
                return SingleCircle(
                  txt: 'Center',
                  color: Colors.red,
                );
              },
            );
          },
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.add),
                  onPressed: () {
                    setState(() => length++);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.remove),
                  onPressed: () {
                    setState(() => length--);
                  },
                ),
              ),
            ],
          ),
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
