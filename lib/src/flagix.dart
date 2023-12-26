import 'package:feature_flagix/src/feature_flagix.dart';
import 'package:flutter/material.dart';

/// A widget that conditionally shows its child
/// based on the user's role and required permission.
class Flagix extends StatefulWidget {
  /// Constructs a [Flagix].
  ///
  /// The [flag] parameter specifies the flag
  /// required to show the child widget.
  ///
  /// The [child] parameter specifies the widget to be shown if
  /// the user has the required permission.
  ///
  const Flagix({
    required this.flag,
    required this.child,
    this.replace,
    super.key,
  });

  /// The required permission to show the child widget.
  final dynamic flag;

  /// The child widget to be shown if the user has the required permission.
  final Widget child;

  /// child is the flag is not granted
  /// it is optional
  final Widget? replace;

  @override
  State<Flagix> createState() => _FlagixState();
}

class _FlagixState extends State<Flagix> {
  final FeatureFlagix featureFlagix = FeatureFlagix();
  late bool hasPermissionGranted;

  @override
  void initState() {
    super.initState();
    hasPermissionGranted = featureFlagix.hasPermission(widget.flag);
  }

  @override
  Widget build(BuildContext context) {
    // Show the widget only if the role has the required permission
    return hasPermissionGranted
        ? widget.child
        : widget.replace ?? const SizedBox.shrink();
  }
}
