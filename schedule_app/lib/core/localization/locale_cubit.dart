import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('vi'));

  void changeLocale(Locale locale) {
    if (state != locale) {
      emit(locale);
    }
  }

  void toggleLanguage() {
    if (state.languageCode == 'vi') {
      emit(const Locale('en'));
    } else {
      emit(const Locale('vi'));
    }
  }
}
