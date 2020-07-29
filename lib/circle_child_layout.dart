import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as Math;

const double _radiansPerDegree = Math.pi / 180;
final double _startAngle = -90.0 * _radiansPerDegree;
typedef double ItemAngleCalculator(int index);

class CircularLayoutDelegate extends MultiChildLayoutDelegate {
  final Map<String, LayoutId> idItems;
  final LayoutId centerCircleLayoutId;
  final double radius;

  CircularLayoutDelegate({
    @required this.idItems,
    @required this.radius,
    this.centerCircleLayoutId,
  });

  @override
  void performLayout(Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    double _itemSpacing = 360.0 / idItems.length;

    var itemValues = idItems.values.toList();
    for (int i = 0; i < idItems.length; i++) {
      final idItem = itemValues[i];

      final String id = idItem.id;

      final Size buttonSize = layoutChild(id, BoxConstraints.loose(size));
      int actualIndex = i;

      final double itemAngle =
          _startAngle + actualIndex * _itemSpacing * _radiansPerDegree;

      positionChild(
        id,
        new Offset(
          (center.dx - buttonSize.width / 2) +
              (radius) * Math.cos(itemAngle), //x axis
          (center.dy - buttonSize.height / 2) +
              (radius) * Math.sin(itemAngle), //y axis
        ),
      );
    }
    if (centerCircleLayoutId != null) {
      final Size buttonSize =
          layoutChild(centerCircleLayoutId.id, BoxConstraints.loose(size));
      positionChild(
        centerCircleLayoutId.id,
        new Offset(center.dx - (buttonSize.width / 2),
            center.dy - (buttonSize.height / 2)),
      );
    }
  }

  @override
  bool shouldRelayout(CircularLayoutDelegate oldDelegate) =>
      !mapEquals(idItems, oldDelegate.idItems) ||
      radius != oldDelegate.radius ||
      centerCircleLayoutId?.child != oldDelegate.centerCircleLayoutId?.child ||
      radius != oldDelegate.radius;
}
