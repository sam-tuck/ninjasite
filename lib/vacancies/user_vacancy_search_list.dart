import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jsninja/providers/firestore.dart';
import 'package:jsninja/state/generic_state_notifier.dart';
import 'package:jsninja/vacancies/user_vacancy_search_list_item.dart';

final sortStateNotifierProvider =
    StateNotifierProvider<GenericStateNotifier<String?>, String?>(
        (ref) => GenericStateNotifier<String?>(null));

// String uid = FirebaseAuth.instance.currentUser!.uid;

class UserVacanciesList extends ConsumerWidget {
  String? uid;
  UserVacanciesList(this.uid, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: ref.watch(colSP('user/$uid/vacancy')).when(
          loading: () => [Container()],
          error: (e, s) => [ErrorWidget(e)],
          // more detailed version:
          // data: (data) {
          //   var arr = data.docs;
          //   arr.sort((a, b) => Jiffy(a.data()['timeCreated'].toDate())
          //           .isAfter(b.data()['timeCreated'].toDate())
          //       ? -1
          //       : 1);
          //   return (arr)
          //       .map((e) => UserVacancyItem(key: Key(e.id), e.reference))
          //       .toList();
          // }));
          // more concise version:
          data: (data) => (data.docs
                ..sort((a, b) => Jiffy(a.data()['timeCreated'].toDate())
                        .isAfter(b.data()['timeCreated'].toDate())
                    ? -1
                    : 1))
              .map((e) => UserVacancyItem(key: Key(e.id), e.reference))
              .toList()));
}
