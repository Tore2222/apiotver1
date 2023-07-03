import 'package:flutter/material.dart';

import 'blocs/auth_bloc.dart';

//l quan trọng lắm vì bị lỗi inherit
class Myapp extends InheritedWidget {
  //final AuthBloc authBloc;
  final Widget child;
  Myapp(this.child) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

//   static Myapp of(BuildContext context) {
//     return context.inheritFromWidgetOfExactType<Myapp>();
//   }
}
