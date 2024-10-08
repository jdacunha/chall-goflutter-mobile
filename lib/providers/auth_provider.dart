import 'package:flutter/material.dart';
import 'package:chall_mobile/providers/auth_user.dart';

class AuthProvider extends ChangeNotifier {
  AuthUser _user = AuthUser.getEmpty();

  AuthUser get user => _user;

  bool get isLogged => _user.id >= 0;

  void setUser(
      int id,
      String name,
      String email,
      String role,
      bool hasStand
      ) {
    _user = AuthUser(
      id: id,
      name: name,
      email: email,
      role: role,
      hasStand: hasStand,
    );
    notifyListeners();
  }

void setHasStand(bool hasStand) {
    _user = _user.copyWith(hasStand: hasStand);
    notifyListeners();
  }
}
