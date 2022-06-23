import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';

class ConfigWidget extends StatelessWidget {
  const ConfigWidget({
    Key? key,
    required this.config,
    required this.valueSetter,
    required this.itemsLength,
    required this.itemsLengthSetter,
  }) : super(key: key);

  final CircularWidgetConfig config;
  final void Function(CircularWidgetConfig newConfig) valueSetter;

  final int itemsLength;
  final void Function(int newValue) itemsLengthSetter;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: ScrollController(),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListTile(
            title: Text('Outer Items Length ($itemsLength)'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => itemsLengthSetter(itemsLength + 1),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => itemsLengthSetter(itemsLength - 1),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: CheckboxListTile(
            title: Text('Is Clockwise ?'),
            value: config.isClockwise,
            onChanged: (newVal) =>
                valueSetter(config.copyWith(isClockwise: newVal ?? true)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: CheckboxListTile(
            title: Text('Is Add Extra Fake Item ?'),
            value: config.isAddExtraFakeItem,
            onChanged: (newVal) => valueSetter(
              config.copyWith(isAddExtraFakeItem: newVal ?? true),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: CheckboxListTile(
            title: Text('Is Center on top?'),
            value: config.drawOrder == CircularLayoutDrawOrder.centerOnTop,
            onChanged: (newVal) => valueSetter(
              config.copyWith(
                drawOrder: (newVal ?? true)
                    ? CircularLayoutDrawOrder.centerOnTop
                    : CircularLayoutDrawOrder.itemsOnTop,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListTile(
            title: Text(
                'Start angle (${config.startAngleDeg.toStringAsFixed(2)})'),
            subtitle: Slider(
              min: -360,
              max: 360,
              label: config.startAngleDeg.toStringAsFixed(2),
              value: config.startAngleDeg,
              onChanged: (newVal) =>
                  valueSetter(config.copyWith(startAngleDeg: newVal)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListTile(
            title:
                Text('Total Arch (${config.totalArchDeg.toStringAsFixed(2)})'),
            subtitle: Slider(
              min: 0,
              max: 360,
              label: config.totalArchDeg.toStringAsFixed(2),
              value: config.totalArchDeg,
              onChanged: (newVal) =>
                  valueSetter(config.copyWith(totalArchDeg: newVal)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListTile(
            title: Text(
                'Inner Spacing (${config.innerSpacing.toStringAsFixed(2)})'),
            subtitle: Slider(
              min: -100,
              max: 100,
              label: config.innerSpacing.toStringAsFixed(2),
              value: config.innerSpacing,
              onChanged: (newVal) =>
                  valueSetter(config.copyWith(innerSpacing: newVal)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: ListTile(
            title: Text(
                'Center Radius (${config.centerWidgetRadius.toStringAsFixed(2)})'),
            subtitle: Slider(
              min: 1,
              max: 500,
              label: config.centerWidgetRadius.toStringAsFixed(2),
              value: config.centerWidgetRadius,
              onChanged: (newVal) =>
                  valueSetter(config.copyWith(centerWidgetRadius: newVal)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: ListTile(
            title:
                Text('Item Radius (${config.itemRadius.toStringAsFixed(2)})'),
            subtitle: Slider(
              min: 1,
              max: 500,
              label: config.itemRadius.toStringAsFixed(2),
              value: config.itemRadius,
              onChanged: (newVal) =>
                  valueSetter(config.copyWith(itemRadius: newVal)),
            ),
          ),
        ),
      ],
    );
  }
}
