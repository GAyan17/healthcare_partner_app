import 'package:flutter/material.dart';
import 'package:healthcare_partner_app/bloc/app/app_bloc.dart';
import 'package:healthcare_partner_app/view/view.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
