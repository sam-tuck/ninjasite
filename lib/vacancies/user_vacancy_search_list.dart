import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/providers/firestore.dart';
import 'package:jsninja/state/generic_state_notifier.dart';
import 'package:jsninja/vacancies/user_vacancy_search_list_item.dart';

final sortStateNotifierProvider =
    StateNotifierProvider<GenericStateNotifier<String?>, String?>(
        (ref) => GenericStateNotifier<String?>(null));

// String uid = FirebaseAuth.instance.currentUser!.uid;

class UserVacanciesList extends ConsumerWidget {

  String ? uid;
  UserVacanciesList(this.uid, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: ref.watch(colSP('user/$uid/vacancy')).when(
          loading: () => [Container()],
          error: (e, s) => [ErrorWidget(e)],
          data: (data) {
            //print('vacancies found: ${data.docs.first.id}')
            return data.docs
                .map((e) => UserVacancyItem(key: Key(e.id), e.reference))
                .toList();
          }));
}
