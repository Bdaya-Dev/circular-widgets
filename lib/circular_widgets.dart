library circular_widgets;

import 'package:flutter/widgets.dart';

import 'circle_child_layout.dart';

class CircularWidgets extends StatefulWidget {
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// how many outer items to display
  final int itemsLength;

  /// Radius of the outer item
  final double radiusOfItem;

  /// Radius of the center widget
  final double centerWidgetRadius;

  /// (optional) Builds the center widget
  final WidgetBuilder centerWidgetBuilder;

  /// Space between inner circle and outer circles
  final double innerSpacing;
  const CircularWidgets({
    Key key,
    @required this.itemBuilder,
    this.itemsLength = 5,
    this.radiusOfItem = 100,
    this.centerWidgetBuilder,
    this.centerWidgetRadius = 150,
    this.innerSpacing = 10,
  }) : super(key: key);

  @override
  _CircularWidgetsState createState() => _CircularWidgetsState();
}

class _CircularWidgetsState extends State<CircularWidgets> {
  @override
  Widget build(BuildContext context) {
    //list widgets
    Map<String, LayoutId> itemIds = {};
    for (var i = 0; i < widget.itemsLength; i++) {
      final id = 'Item($i)';
      itemIds[id] = LayoutId(
        id: 'Item($i)',
        child: SizedBox(
          height: widget.radiusOfItem,
          width: widget.radiusOfItem,
          child: widget.itemBuilder(context, i),
        ),
      );
    }
    final circleWidget =
        widget.centerWidgetBuilder == null || widget.centerWidgetRadius == null
            ? null
            : LayoutId(
                id: 'CenterItem',
                child: SizedBox(
                  height: widget.centerWidgetRadius,
                  width: widget.centerWidgetRadius,
                  child: widget.centerWidgetBuilder?.call(context),
                ),
              );

    return CustomMultiChildLayout(
      delegate: CircularLayoutDelegate(
        idItems: itemIds,
        centerCircleLayoutId: circleWidget,
        radius: (widget.centerWidgetRadius +
                widget.innerSpacing +
                widget.radiusOfItem) /
            2,
      ),
      children: [
        ...itemIds.values.toList(),
        if (circleWidget != null) circleWidget
      ],
    );
  }
}
