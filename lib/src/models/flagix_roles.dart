import 'package:feature_flagix/src/models/flagix_permissions.dart';

/// Represents the permissions associated with different roles.
class FlagixRoles<R, P> {
  /// Creates a new instance of [FlagixRoles] with the given roles.
  FlagixRoles({required this.roles});

  /// A map that associates [FlagixPermissions]
  /// with their corresponding [R] role.
  final Map<R, FlagixPermissions<P>> roles;
}
