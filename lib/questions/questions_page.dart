//import 'dart:convert';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/app_bar.dart';
import 'package:jsninja/common.dart';
//import 'package:jsninja/state/generic_state_notifier.dart';
import 'package:jsninja/drawer.dart';

import '../controls/doc_field_text_edit.dart';
import '../providers/firestore.dart';
//import 'package:http/http.dart' as http;

class QuestionsPage extends ConsumerWidget {
  final TextEditingController searchCtrl = TextEditingController();

  QuestionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MyAppBar.getBar(context, ref),
      drawer: (MediaQuery.of(context).size.width < WIDE_SCREEN_WIDTH)
          ? TheDrawer.buildDrawer(context)
          : null,
      body: Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(
              //mainAxisSize: MainAxisSize.max,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: ref.watch(colSP('question')).when(
                  loading: () => [Container()],
                  error: (e, s) => [ErrorWidget(e)],
                  data: (data) => data.docs
                      .map(
                        (e) => ListTile(
                            title: Text("Question: " + e.data()!["question"],
                                style: Theme.of(context).textTheme.headline4),
                            subtitle: DocFieldTextEdit2(
                                FirebaseFirestore.instance.doc(
                                    'user/${FirebaseAuth.instance.currentUser!.uid}/answer/${e.id}'),
                                'answer')
                            // Text("Answer: ",
                            //     style: Theme.of(context).textTheme.headline4),
                            ),
                      )
                      .toList())
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text("Add Cover Letter",
              //       style: Theme.of(context).textTheme.headline3),
              // ),

              )),
    );
  }
}
