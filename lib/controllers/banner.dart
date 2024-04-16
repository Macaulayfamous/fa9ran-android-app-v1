import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final bannerUrls = RxList<String>();

  Stream<List<Map<String, dynamic>>> getBannerUrls() {
    return _firestore.collection('banners').snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) =>
              doc.data().containsKey('image') && (doc['image'] is List))
          .map((doc) => {
                'image': (doc['image'] as List).cast<String>().first,
                'page':
                    doc['page'], // Extract the 'page' value from the document
              })
          .toList();
    });
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class BannerController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final bannerUrls = RxList<String>();
// Stream<List<String>> getBannerUrls() {
//   return _firestore.collection('banners').snapshots().map((snapshot) {
//     // Iterate over all documents in the snapshot
//     snapshot.docs.forEach((doc) {
//       final String pageValue = doc['page'] as String;
//       print('Page value: $pageValue'); // Print the page value for each document
//     });

//     return snapshot.docs
//         .where((doc) =>
//             doc.data().containsKey('image') && (doc['image'] is List))
//         .expand((doc) => (doc['image'] as List).cast<String>()) // Flatten the list of lists
//         .toList();
//   });
// }

// }

