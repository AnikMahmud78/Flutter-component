enum UserRole { sysAdmin, engineeringLead, operator }

class UserRolePermissions {
  final UserRole role;
  final bool canRead;
  final bool canApprove;
  final bool canModifyConfig;

  UserRolePermissions.forRole(this.role)
      : canRead = true,
        canApprove = true,
        canModifyConfig = (role == UserRole.sysAdmin);
}
