import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/providers/firestore.dart';
import 'package:jsninja/search/search_results.dart';
import 'package:jsninja/state/generic_state_notifier.dart';

final activeUser =
    StateNotifierProvider<GenericStateNotifier<String?>, String?>(
        (ref) => GenericStateNotifier<String?>(null));

class UserDetails extends ConsumerWidget {
  final String? entityId;

  final TextEditingController idCtrl = TextEditingController(),
      nameCtrl = TextEditingController(),
      descCtrl = TextEditingController();

  UserDetails(this.entityId);

  @override
  Widget build(BuildContext context, WidgetRef ref) => entityId == null
      ? Container()
      : ref.watch(docSP('user/${entityId!}')).when(
          loading: () => Container(),
          error: (e, s) => ErrorWidget(e),
          data: (userDoc) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: Colors.grey,
                  )),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Text(userDoc.id),
                  Text('name: ${userDoc.data()!['name'] ?? ''}'),
                  Divider(),

                  Text(
                      'User Resumes List Widget goes here...'), // Replace with UserResumeListWidget(userDoc.id)
                  Divider(),
                  Text(
                      'User Vacancy List Widget goes here'), // Replace with UserVacancyListWidget(userDoc.id)
                  Divider(),
                  Text(
                      'User FAQ List Widget goes here'), // Replace with UserFAQListWidget(userDoc.id)
                ],
              ))));
}
