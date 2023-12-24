import 'package:feature_flagix/src/feature_flagix.dart';
import 'package:flutter/material.dart';

/// A widget that conditionally shows its child
/// based on the user's role and required permission.
class Flagix<P, R> extends StatefulWidget {
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
    super.key,
  });

  /// The required permission to show the child widget.
  final P flag;

  /// The child widget to be shown if the user has the required permission.
  final Widget child;

  @override
  State<Flagix> createState() => _FlagixState<R>();
}

class _FlagixState<R> extends State<Flagix> {
  final FeatureFlagix _appFlagix = FeatureFlagix();
  late R role;
  late bool hasPermissionGranted;

  @override
  void initState() {
    super.initState();
    role = _appFlagix.currentRole;
    hasPermissionGranted = _appFlagix.hasPermission(widget.flag);
  }

  @override
  Widget build(BuildContext context) {
    // Show the widget only if the role has the required permission
    return hasPermissionGranted ? widget.child : const SizedBox.shrink();
  }
}
