import 'package:flutter/material.dart';
import 'package:jsninja/resume/userResumePage.dart';
import 'package:jsninja/search/search_page.dart';
import 'package:jsninja/search/resume_page.dart';
import 'package:jsninja/search/coverletter_page.dart';

class UserViewWidget extends StatelessWidget {
  const UserViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Navigator(
          onGenerateRoute: (RouteSettings settings) {
            // print('onGenerateRoute: ${settings}');
            // if (settings.name == '/' || settings.name == 'search') {
            if (settings.name == '/' || settings.name == 'vacancies') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => VacanciesPage());
            }
            if (settings.name == 'resumes') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => UseerResumePage());
            }
            if (settings.name == 'cover letters') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => CoverLettersPage());
            } else {
              //  else if (settings.name == 'lists') {
              //   return PageRouteBuilder(
              //       pageBuilder: (_, __, ___) => ListsPage());
              // } else if (settings.name == 'pep admin') {
              //   return PageRouteBuilder(
              //       pageBuilder: (_, __, ___) => PepAdminPage());
              // } else if (settings.name == 'pep library') {
              //   return PageRouteBuilder(
              //       pageBuilder: (_, __, ___) => PepLibraryPage());
              // } else if (settings.name == 'adverse media') {
              //   return PageRouteBuilder(
              //       pageBuilder: (_, __, ___) => AdverseMediaPage());
              // } else {
              throw 'no page to show';
            }
          },
        ));
  }
}
