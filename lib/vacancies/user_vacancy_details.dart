import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_bar.dart';
import '../common.dart';
import '../drawer.dart';

class UserVacancyDetailsPage extends ConsumerWidget {
  static const routeName = '/vacancy';

  final String vacancyId;

  UserVacancyDetailsPage(this.vacancyId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: //AdminAppBar.getBar(context, ref),
            AppBar(
          title: Text('Vacancy ${vacancyId}'),
          actions: [ThemeIconButton()],
        ),
        drawer: (MediaQuery.of(context).size.width < WIDE_SCREEN_WIDTH)
            ? TheDrawer.buildDrawer(context)
            : null,
        body: Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Text(vacancyId))
                // Expanded(child: UserList()),
                // Expanded(child: UserDetails(ref.watch(activeUser)))
              ],
            )),
      );
}
