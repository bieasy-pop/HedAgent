import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/features/authentication/data/models/auth_response.dart';
import 'package:hedagent/route/app_router_names.dart';


void navigateAfterAuth(BuildContext context, AuthUser user) {
  if (!user.isVerified) {
    context.goNamed(RouteNames.emailVerificationScreenString);
    return;
  }

  if (user.role == 'educator' && !user.isActive) {
    context.goNamed(RouteNames.pendingApprovalScreenString);
    return;
  }

  context.goNamed(RouteNames.homeString);
}
