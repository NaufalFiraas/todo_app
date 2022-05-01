import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'darktheme_state.dart';

class DarkthemeCubit extends HydratedCubit<DarkthemeState> {
  DarkthemeCubit() : super(const DarkthemeChanged(false));

  void changeToDark(bool value) {
    emit(DarkthemeChanged(value));
  }

  @override
  DarkthemeState? fromJson(Map<String, dynamic> json) {
    return DarkthemeChanged(json['isDark']);
  }

  @override
  Map<String, dynamic>? toJson(DarkthemeState state) {
    state.toMap();
  }
}
