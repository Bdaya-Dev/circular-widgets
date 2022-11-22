import 'package:circular_widgets/src/circular_widget_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as Math;

const double _radiansPerDegree = Math.pi / 180;

typedef double ItemAngleCalculator(int index);

class CircularLayoutDelegate extends MultiChildLayoutDelegate {
  final List<LayoutId> idItems;
  final LayoutId? centerCircleLayoutId;
  final CircularWidgetConfig config;
  // double get radius => config.totalRadius;
  double get startAngleDeg => config.startAngleDeg;
  double get totalArchDeg => config.totalArchDeg;
  bool get isClockWise => config.isClockwise;
  bool get isAddExtraFakeItem => config.isAddExtraFakeItem;
  CircularLayoutDelegate({
    required this.idItems,
    required this.config,
    required this.centerCircleLayoutId,
  });

  @override
  void performLayout(Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final startAngle = startAngleDeg * _radiansPerDegree;
    final itemSpacing =
        totalArchDeg / (idItems.length + (isAddExtraFakeItem ? 0 : -1));

    //distance from center circle to item top left
    final itemCenterDistance =
        config.centerWidgetRadius + config.innerSpacing + config.itemRadius;

    for (int i = 0; i < idItems.length; i++) {
      final idItem = idItems[i];

      final id = idItem.id;

      final itemSize = layoutChild(id, BoxConstraints.loose(size));
      final itemAngle = startAngle +
          i * itemSpacing * _radiansPerDegree * (isClockWise ? 1 : -1);

      final itemXAxis = center.dx -
          itemSize.width / 2 +
          itemCenterDistance * Math.cos(itemAngle);

      final itemYAxis = center.dy -
          itemSize.height / 2 +
          itemCenterDistance * Math.sin(itemAngle);

      positionChild(id, Offset(itemXAxis, itemYAxis));
    }

    final centerLayoutId = centerCircleLayoutId;
    if (centerLayoutId != null) {
      final centerSize =
          layoutChild(centerLayoutId.id, BoxConstraints.loose(size));
      positionChild(
        centerLayoutId.id,
        Offset(
          center.dx - centerSize.width / 2,
          center.dy - centerSize.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRelayout(CircularLayoutDelegate oldDelegate) =>
      !listEquals(idItems, oldDelegate.idItems) ||
      centerCircleLayoutId?.child != oldDelegate.centerCircleLayoutId?.child;
}
