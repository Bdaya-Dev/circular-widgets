library circular_widgets;

import 'package:flutter/widgets.dart';

import 'circle_child_layout.dart';

class CircularWidgets extends StatelessWidget {
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// how many outer items to display
  final int itemsLength;

  /// Radius of the outer item
  final double radiusOfItem;

  /// Radius of the center widget
  final double centerWidgetRadius;

  /// (optional) Builds the center widget
  final WidgetBuilder? centerWidgetBuilder;

  /// Space between inner circle and outer circles
  final double innerSpacing;

  //Where to start drawing the first item (0 refers to the right axis)
  final double startAngleDeg;

  //The total arch angle (in degrees), 360 by default to fill entire widget
  final double totalArchDeg;

  //Draw items clockwise
  final bool isClockWise;

  const CircularWidgets({
    Key? key,
    required this.itemBuilder,
    required this.itemsLength,
    this.isClockWise = true,
    this.startAngleDeg = -90,
    this.totalArchDeg = 360,
    this.radiusOfItem = 100,
    this.centerWidgetBuilder,
    this.centerWidgetRadius = 150,
    this.innerSpacing = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //list widgets
    Map<String, LayoutId> itemIds = {};
    for (var i = 0; i < itemsLength; i++) {
      final id = 'Item($i)';
      itemIds[id] = LayoutId(
        id: 'Item($i)',
        child: SizedBox(
          height: radiusOfItem,
          width: radiusOfItem,
          child: itemBuilder(context, i),
        ),
      );
    }
    final circleWidget = centerWidgetBuilder == null
        ? null
        : LayoutId(
            id: 'CenterItem',
            child: SizedBox(
              height: centerWidgetRadius,
              width: centerWidgetRadius,
              child: centerWidgetBuilder?.call(context),
            ),
          );

    return CustomMultiChildLayout(
      delegate: CircularLayoutDelegate(
        startAngleDeg: startAngleDeg,
        isClockWise: isClockWise,
        totalArchDeg: totalArchDeg,
        idItems: itemIds,
        centerCircleLayoutId: circleWidget,
        radius: (centerWidgetRadius + innerSpacing + radiusOfItem) / 2,
      ),
      children: [
        ...itemIds.values.toList(),
        if (circleWidget != null) circleWidget
      ],
    );
  }
}
