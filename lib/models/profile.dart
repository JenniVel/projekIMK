import 'package:cloud_firestore/cloud_firestore.dart';

class Profiles {
  String? id;
  String? imageUrl;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  Profiles({
    this.id,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Profiles.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Profiles(
      id: doc.id,
      imageUrl: data['image_url'],
      createdAt: data['created_at'] as Timestamp,
      updatedAt: data['updated_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'image_url': imageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
