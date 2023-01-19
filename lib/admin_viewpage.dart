import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/admin/user_details.dart';
import 'package:jsninja/admin/user_list.dart';
import 'package:jsninja/app_bar.dart';
import 'package:jsninja/drawer.dart';
import 'package:jsninja/common.dart';

import 'admin/user_details_page.dart';
import 'admin/users_page.dart';

//Accessed by clicking workaround button on login page for time being
class AdminViewWidget extends ConsumerWidget {
  const AdminViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          // Cast the arguments to the correct
          // type: ScreenArguments.

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          // return MaterialPageRoute(
          //   builder: (context) {
          //     return PassArgumentsScreen(
          //       title: args.title,
          //       message: args.message,
          //     );
          //   },
          // );
          // print('onGenerateRoute: ${settings}');
          // if (settings.name == '/' || settings.name == 'search') {
          if (settings.name == '/' || settings.name == 'clients') {
            return PageRouteBuilder(pageBuilder: (_, __, ___) => UsersPage());
          } else if (settings.name == UserDetailsPage.routeName) {
            return PageRouteBuilder(pageBuilder: (_, __, ___) {
              //print('args: ${ModalRoute.of(context)!.settings}');
              final args = settings.arguments as ScreenArguments;

              // final args =
              //     ModalRoute.of(context)!.settings.arguments as ScreenArguments;
              // print('args: ${args}');
              return UserDetailsPage(args.title);
            });
          }
          // if (settings.name == 'resumes') {
          //   return PageRouteBuilder(pageBuilder: (_, __, ___) => ResumesPage());
          // }
          // if (settings.name == 'cover letters') {
          //   return PageRouteBuilder(
          //       pageBuilder: (_, __, ___) => CoverLettersPage());
          // }
          else {
            throw 'no page to show for ${settings.name}';
          }
        },
      ));
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
