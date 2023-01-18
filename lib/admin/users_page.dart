import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/admin/user_details.dart';
import 'package:jsninja/admin/user_list.dart';
import 'package:jsninja/common.dart';
import 'package:jsninja/drawer.dart';

import '../admin_app_bar.dart';

class UsersPage extends ConsumerWidget {
  UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AdminAppBar.getBar(context, ref),
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
              Expanded(child: UserList()),
              Expanded(child: UserDetails(ref.watch(activeUser)))
            ],
          )),
    );
  }
}
