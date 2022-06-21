import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as Math;

const double _radiansPerDegree = Math.pi / 180;

typedef double ItemAngleCalculator(int index);

class CircularLayoutDelegate extends MultiChildLayoutDelegate {
  final Map<String, LayoutId> idItems;
  final LayoutId? centerCircleLayoutId;
  final double radius;
  final double startAngleDeg;
  final double totalArchDeg;
  final bool isClockWise;
  CircularLayoutDelegate({
    required this.idItems,
    required this.radius,
    required this.startAngleDeg,
    required this.totalArchDeg,
    required this.isClockWise,
    this.centerCircleLayoutId,
  });

  @override
  void performLayout(Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    double _itemSpacing = totalArchDeg / idItems.length;

    var itemValues = idItems.values.toList();
    for (int i = 0; i < idItems.length; i++) {
      final idItem = itemValues[i];

      final id = idItem.id;

      final buttonSize = layoutChild(id, BoxConstraints.loose(size));
      final actualIndex = i;
      final startAngle = startAngleDeg * _radiansPerDegree;
      final itemAngle = startAngle +
          actualIndex *
              _itemSpacing *
              _radiansPerDegree *
              (isClockWise ? 1 : -1);

      positionChild(
        id,
        Offset(
          (center.dx - buttonSize.width / 2) +
              (radius) * Math.cos(itemAngle), //x axis
          (center.dy - buttonSize.height / 2) +
              (radius) * Math.sin(itemAngle), //y axis
        ),
      );
    }

    final centerLayoutId = centerCircleLayoutId;
    if (centerLayoutId != null) {
      final buttonSize =
          layoutChild(centerLayoutId.id, BoxConstraints.loose(size));
      positionChild(
        centerLayoutId.id,
        Offset(
          center.dx - (buttonSize.width / 2),
          center.dy - (buttonSize.height / 2),
        ),
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
