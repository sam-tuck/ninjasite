import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/admin/user_resume_item_tile.dart';
import 'package:jsninja/providers/firestore.dart';
import 'package:jsninja/search/vacancy_item_tile.dart';
import 'package:jsninja/state/generic_state_notifier.dart';

final sortStateNotifierProvider =
    StateNotifierProvider<GenericStateNotifier<String?>, String?>(
        (ref) => GenericStateNotifier<String?>(null));

class UserResumeListWidget extends ConsumerWidget {
  final String uid;

  UserResumeListWidget(this.uid);

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: ref
          .watch(
              // filteredColSP(QueryParams(
              //   path: 'vacancy',
              //   orderBy: 'timeCreated',
              //   isOrderDesc: true,
              //   limit: 100))
              colSP('user/${uid}/resume'))
          .when(
              loading: () => [Container()],
              error: (e, s) => [ErrorWidget(e)],
              data: (data) => data.docs
                  .map((e) => UserResumeListItem(key: Key(e.id), e.reference))
                  .toList()));
}
