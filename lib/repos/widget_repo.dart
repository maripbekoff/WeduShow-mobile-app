import 'package:WeduShow/repos/user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WidgetRepo {
  UserRepo _userRepo = UserRepo();
  final _firestore = Firestore.instance;

  Future<void> createNewWidget(List pageValue) async {
    String _uid = await _userRepo.getCurrentUser().then((value) => value.uid);

    Map<String, dynamic> preData() {
      Map<String, dynamic> data = {};
      for (int i = 0; i < pageValue.length; i++) {
        data["page_$i"] = {
          "question": pageValue[i][0][0].value.text,
          "answers": [
            pageValue[i][0][1].value.text,
            pageValue[i][0][2].value.text,
            pageValue[i][0][3].value.text,
          ],
          "correct_answer": pageValue[i][1],
          "time": pageValue[i][2],
        };
      }
      return data;
    }

    await _firestore
        .collection('users')
        .document(_uid)
        .collection('widgets')
        .document()
        .setData(preData());
  }
}
