/// Represents the permissions associated with different roles.
class FlagixModel<R, P> {
  /// Creates a new instance of [FlagixModel] with the given [roles].
  FlagixModel({
    required this.roles,
  });

  /// A map that associates [Roles] with their corresponding [RoleFlagix].
  final Map<R, RoleFlagix<P>> roles;
}

/// Represents the permissions associated with a specific role.
class RoleFlagix<P> {
  /// Creates a new instance of [RoleFlagix] with the given [permissions].
  RoleFlagix({
    required this.permissions,
  });

  /// The list of [FlagixModel] associated with this role.
  final List<P> permissions;
}
