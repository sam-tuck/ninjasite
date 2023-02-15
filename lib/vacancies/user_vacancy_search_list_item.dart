import 'dart:async';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/providers/firestore.dart';
import 'package:jsninja/resume/user_resume_page.dart';
import 'package:jsninja/search/search_page.dart';
import 'package:jsninja/vacancies/user_vacancy_details.dart';

import '../admin_viewpage.dart';
import '../controls/doc_field_text_edit.dart';

class UserVacancyItem extends ConsumerWidget {
  final DocumentReference appRef;
  // const SearchListItem(this.searchRef);
  final TextEditingController ctrl = TextEditingController();
  String uid = FirebaseAuth.instance.currentUser!.uid;

  UserVacancyItem(this.appRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(docSP(appRef.path)).when(
        loading: () => Container(),
        error: (e, s) => ErrorWidget(e),
        data: (appDoc) => ref.watch(docSP("${appDoc.data()!['vacancy']}")).when(
            loading: () => Container(),
            error: (e, s) => ErrorWidget(e),
            data: (searchDoc) => Card(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Flexible(flex: 1, child: Text('vac ')),
                          Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    (searchDoc.data()!['positionTitle'] ?? '') +
                                        "  " +
                                        (searchDoc.data()!['location'] ?? '') +
                                        "  " +
                                        (searchDoc.data()!['salary'] ?? ''),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text((searchDoc.data()!['snippet']) ?? "")
                                ],
                              )),
                          Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  if (appDoc.data()!["interviewTime"] !=
                                      null) ...[
                                    Container(
                                        color: Colors.green,
                                        width: 80,
                                        height: 40,
                                        child: Center(
                                          child: Text('Interview Offer'),
                                        )),
                                    Text(
                                        'Applied ${DateFormat('dd-MMM-yyy').format(appDoc.data()!['appliedTime'].toDate())}\n Offer recieved ${DateFormat('dd-MMM-yyy').format(appDoc.data()!['interviewTime'].toDate())}')
                                  ] else if (appDoc.data()!["declinedTime"] !=
                                      null) ...[
                                    Container(
                                        color: Colors.grey,
                                        width: 80,
                                        height: 40,
                                        child: Center(
                                          child: Text('Archived'),
                                        )),
                                    Text(
                                        'Applied ${DateFormat('dd-MMM-yyy').format(appDoc.data()!['appliedTime'].toDate())}\n Archived ${DateFormat('dd-MMM-yyy').format(appDoc.data()!['declinedTime'].toDate())}')
                                  ] else if (appDoc.data()!["appliedTime"] !=
                                      null) ...[
                                    Container(
                                        color: Colors.yellow,
                                        width: 80,
                                        height: 40,
                                        child: Center(
                                          child: Text('Applied'),
                                        )),
                                    Text(
                                        'Applied ${DateFormat('dd-MMM-yyy').format(appDoc.data()!['appliedTime'].toDate())}')
                                  ] else ...[
                                    CircularProgressIndicator()
                                  ]
                                ],
                              )),
                        ],
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.delete),
                      //   onPressed: () {
                      //     showDialog(
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           return AlertDialog(
                      //             scrollable: true,
                      //             title: Text('Delete Sentence...'),
                      //             content: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Text('Are you sure?')),
                      //             actions: [
                      //               TextButton(
                      //                   child: Text("Yes"),
                      //                   onPressed: () {
                      //                     searchRef.delete();
                      //                     Navigator.of(context).pop();
                      //                   }),
                      //               TextButton(
                      //                   child: Text("Cancel"),
                      //                   onPressed: () {
                      //                     Navigator.of(context).pop();
                      //                   })
                      //             ],
                      //           );
                      //         });
                      //   },
                      // ))
                      //,
                      // subtitle: Text(entityDoc.data()!['desc'] ?? 'desc'),
                      // trailing: Column(children: <Widget>[
                      //   Text(searchDoc.data()!['target'] ?? ''),
                      //   // buildDeleteEntityButton(
                      //   //     context,
                      //   //     FirebaseFirestore.instance
                      //   //         .collection('batch')
                      //   //         .doc(batchId),
                      //   //     Icon(Icons.delete))
                      // ]),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          UserVacancyDetailsPage.routeName,
                          arguments: PageArguments(
                            // searchDoc.id,
                            searchDoc.data()!['positionDesc'].join("\n"),
                            'This message is extracted in the build method.',
                          ),
                        );
                      },
                    )
                  ],
                ))));
  }
}
