import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(Locale locale) : super(locale);

  void setLocale(Locale i) {
    emit(i);
  }
}
