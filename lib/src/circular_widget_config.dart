enum CircularLayoutDrawOrder {
  centerOnTop,
  itemsOnTop,
}

class CircularWidgetConfig {
  /// Radius of the outer item
  final double itemRadius;

  /// Radius of the center widget
  final double centerWidgetRadius;

  /// Space between inner circle and outer circles
  final double innerSpacing;

  /// Where to start drawing the first item (0 refers to the right axis)
  final double startAngleDeg;

  /// The total arch angle (in degrees), 360 by default to fill entire widget
  final double totalArchDeg;

  /// Draw items clockwise
  final bool isClockwise;

  /// Set this to true to prevent overlapping the first and last item in a 360 deg arch
  final bool isAddExtraFakeItem;

  /// drawOrder
  final CircularLayoutDrawOrder drawOrder;

  /// total radius of the entire widget
  double get totalRadius => centerWidgetRadius + innerSpacing + 2 * itemRadius;

  const CircularWidgetConfig({
    this.itemRadius = 100,
    this.centerWidgetRadius = 150,
    this.innerSpacing = 10,
    this.startAngleDeg = -90,
    this.totalArchDeg = 360,
    this.isClockwise = true,
    this.isAddExtraFakeItem = true,
    this.drawOrder = CircularLayoutDrawOrder.itemsOnTop,
  });

  CircularWidgetConfig copyWith({
    double? itemRadius,
    double? centerWidgetRadius,
    double? innerSpacing,
    double? startAngleDeg,
    double? totalArchDeg,
    bool? isClockwise,
    bool? isAddExtraFakeItem,
    CircularLayoutDrawOrder? drawOrder,
  }) =>
      CircularWidgetConfig(
        drawOrder: drawOrder ?? this.drawOrder,
        itemRadius: itemRadius ?? this.itemRadius,
        centerWidgetRadius: centerWidgetRadius ?? this.centerWidgetRadius,
        innerSpacing: innerSpacing ?? this.innerSpacing,
        startAngleDeg: startAngleDeg ?? this.startAngleDeg,
        totalArchDeg: totalArchDeg ?? this.totalArchDeg,
        isClockwise: isClockwise ?? this.isClockwise,
        isAddExtraFakeItem: isAddExtraFakeItem ?? this.isAddExtraFakeItem,
      );
}
