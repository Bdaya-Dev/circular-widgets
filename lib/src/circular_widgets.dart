import 'package:flutter/widgets.dart';

import 'circle_child_layout.dart';
import 'circular_widget_config.dart';

class CircularWidgets extends StatelessWidget {
  /// how many outer items to display
  final int itemsLength;

  /// outer item builder
  final IndexedWidgetBuilder itemBuilder;

  /// (optional) Builds the center widget
  final WidgetBuilder? centerWidgetBuilder;

  /// Configuration options for the circular widgets
  final CircularWidgetConfig config;

  const CircularWidgets({
    Key? key,
    required this.itemBuilder,
    required this.itemsLength,
    required this.config,
    this.centerWidgetBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //list widgets
    final List<LayoutId> itemIds = [];
    for (var i = 0; i < itemsLength; i++) {
      final id = 'Item($i)';
      itemIds.add(
        LayoutId(
          id: id,
          child: SizedBox(
            height: config.itemRadius * 2,
            width: config.itemRadius * 2,
            child: itemBuilder(context, i),
          ),
        ),
      );
    }
    final circleWidget = centerWidgetBuilder == null
        ? null
        : LayoutId(
            id: 'CenterItem',
            child: SizedBox(
              height: config.centerWidgetRadius * 2,
              width: config.centerWidgetRadius * 2,
              child: centerWidgetBuilder?.call(context),
            ),
          );

    final children = itemIds.toList();

    if (circleWidget != null) {
      if (config.drawOrder == CircularLayoutDrawOrder.centerOnTop) {
        children.add(circleWidget);
      } else {
        children.insert(0, circleWidget);
      }
    }

    return SizedBox(
      height: config.totalRadius * 2,
      width: config.totalRadius * 2,
      child: CustomMultiChildLayout(
        delegate: CircularLayoutDelegate(
          idItems: itemIds,
          centerCircleLayoutId: circleWidget,
          config: config,
        ),
        children: children,
      ),
    );
  }
}
