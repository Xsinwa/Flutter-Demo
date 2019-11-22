import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double _kMinButtonSize = 56;

class LabelIconButton extends StatelessWidget {
  const LabelIconButton({
    Key key,
    this.iconSize = 24.0,
    this.padding = const EdgeInsets.all(5.0),
    this.alignment = Alignment.center,
    @required this.title,
    @required this.icon,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    @required this.onPressed,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
  });

  final double iconSize;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final Widget icon;
  final String title;
  final Color focusColor;
  final Color hoverColor;
  final Color color;
  final Color splashColor;
  final Color highlightColor;
  final Color disabledColor;
  final VoidCallback onPressed;
  final FocusNode focusNode;
  final bool autofocus;
  final String tooltip;


  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    Color currentColor;
    if (onPressed != null)
      currentColor = color;
    else
      currentColor = disabledColor ?? Theme.of(context).disabledColor;
    Widget result = ConstrainedBox(
      constraints: const BoxConstraints(minWidth: _kMinButtonSize, minHeight: _kMinButtonSize),
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: iconSize,
          width: iconSize,
          child: Align(
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconTheme.merge(
                  data: IconThemeData(
                    size: iconSize,
                    color: currentColor,
                  ),
                  child: icon
                ),
                Text(title, style: TextStyle(color: currentColor, fontSize: 9),),
              ],
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      result = Tooltip(
        message: tooltip,
        child: result,
      );
    }

    return Semantics(
      button: true,
      enabled: onPressed != null,
      child: Focus(
        focusNode: focusNode,
        autofocus: autofocus,
        child: InkResponse(
          onTap: onPressed,
          child: result,
          focusColor: focusColor ?? Theme.of(context).focusColor,
          hoverColor: hoverColor ?? Theme.of(context).hoverColor,
          highlightColor: highlightColor ?? Theme.of(context).highlightColor,
          splashColor: splashColor ?? Theme.of(context).splashColor,
          radius: math.max(
            Material.defaultSplashRadius,
            (iconSize + math.min(padding.horizontal, padding.vertical)) * 0.7,
            // x 0.5 for diameter -> radius and + 40% overflow derived from other Material apps.
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget>('icon', icon, showName: false));
    properties.add(StringProperty('tooltip', tooltip, defaultValue: null, quoted: false));
    properties.add(ObjectFlagProperty<VoidCallback>('onPressed', onPressed, ifNull: 'disabled'));
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties.add(ColorProperty('disabledColor', disabledColor, defaultValue: null));
    properties.add(ColorProperty('focusColor', focusColor, defaultValue: null));
    properties.add(ColorProperty('hoverColor', hoverColor, defaultValue: null));
    properties.add(ColorProperty('highlightColor', highlightColor, defaultValue: null));
    properties.add(ColorProperty('splashColor', splashColor, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding, defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode, defaultValue: null));
  }
}
