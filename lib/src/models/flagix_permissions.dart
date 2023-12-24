/// Represents the permissions associated with a specific role.
class FlagixPermissions<P> {
  /// Creates a new instance of [FlagixPermissions] with the given [permissions].
  FlagixPermissions({
    required this.permissions,
  });

  /// The list of permissions associated with the role.
  final List<P> permissions;
}
