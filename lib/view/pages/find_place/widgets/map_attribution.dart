import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapAttribution extends StatelessWidget {
  /// Attribution text, such as 'OpenStreetMap contributors'
  final Text source;

  /// Callback called when [source] is tapped/clicked
  final VoidCallback? onTap;

  /// Color of the box containing the [source] text
  final Color? backgroundColor;

  /// Anchor the widget in a position of the map
  final Alignment alignment;

  /// A simple, classic style, attribution widget, to be placed in
  /// [FlutterMap.nonRotatedChildren]
  ///
  /// Displayed as a padded translucent white box with the following text:
  /// 'flutter_map | © [source]'.
  const MapAttribution({
    Key? key,
    required this.source,
    this.onTap,
    this.backgroundColor,
    this.alignment = Alignment.bottomRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: alignment,
        child: ColoredBox(
          color: backgroundColor ?? Theme.of(context).colorScheme.background,
          child: GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '© ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  MouseRegion(
                    cursor: onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
                    child: source,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
