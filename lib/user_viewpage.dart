import 'package:flutter/material.dart';
import 'package:jsninja/questions/questions_page.dart';
import 'package:jsninja/resume/user_resume_page.dart';
import 'package:jsninja/search/search_page.dart';
import 'package:jsninja/search/resume_page.dart';
import 'package:jsninja/search/coverletter_page.dart';
import 'package:jsninja/vacancies/user_vacancy_details.dart';

import 'admin_viewpage.dart';

class UserViewWidget extends StatelessWidget {
  const UserViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 4,
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
                  pageBuilder: (_, __, ___) => UserResumePage());
            }
            if (settings.name == 'cover letters') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => CoverLettersPage());
            } else {
              if (settings.name == 'answers') {
                return PageRouteBuilder(
                    pageBuilder: (_, __, ___) => QuestionsPage());
              } else if (settings.name == UserVacancyDetailsPage.routeName) {
                return PageRouteBuilder(pageBuilder: (_, __, ___) {
                  //print('args: ${ModalRoute.of(context)!.settings}');
                  final args = settings.arguments as PageArguments;

                  // final args =
                  //     ModalRoute.of(context)!.settings.arguments as ScreenArguments;
                  // print('args: ${args}');
                  return UserVacancyDetailsPage(args.title);
                });
              } else
                throw 'no page to show';
            }
          },
        ));
  }
}
