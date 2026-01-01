import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/sharedpref_helper.dart';

class AppLanguageCubit extends Cubit<Locale> {
  final Locale initialLanguage;
  AppLanguageCubit(this.initialLanguage) : super(initialLanguage);
  void setLanguage(Locale locale) {
    emit(locale);
    saveLanguage(locale.languageCode);
  }

  void saveLanguage(String languageCode) async {
    await SharedprefHelper.setData("LanguageCode", languageCode);
  }
}
