import 'package:cloud_firestore/cloud_firestore.dart';

class Resume {
  String? resumeID;
  String? jobTitle;
  String? description;
  String? resume;
  Timestamp? timeCreated;
  String? author;
  Timestamp? lastupdated;
  Resume(
      {this.resumeID,
      this.jobTitle,
      this.description,
      this.resume,
      this.timeCreated,
      this.author,
      this.lastupdated});

  Map<String, dynamic> toMap() {
    return {
      'jobTitle': jobTitle,
      'description': description,
      'resume': resume,
      'lastupdated': lastupdated
    };
  }
}
