import 'package:hive/hive.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';

class HiveService {
  static HiveService? hive;

  static HiveService getHive() {
    hive = HiveService();
    return hive!;
  }

/* function to check box is already  created or not*/
  Future<bool> isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

/* function to add box */
  addBoxes<T>(dynamic response, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    try {
      // openBox.deleteAt(0);
    } catch (exception) {
      print("adding boxes exception ${exception}");
    } finally {
      openBox.add(response);
    }
  }

/* function to get box */
  Future<dynamic> getBoxes(String boxName) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.getAt(0);
  }

  Future<List<TodoHiveModel>> getTodos() async {
    String boxname = "todos"; //your box name
    await getBoxes(boxname);
    var todosbox = Hive.box(boxname);
    final data = todosbox.keys.map((key) {
      final item = todosbox.get(key);
      return TodoHiveModel(
        userId: item.userId,
        id: item.id,
        title: item.title,
        description: item.description,
        isCompleted: item.isCompleted,
        createdDate: item.createdDate,
        taskTime: item.taskTime,
      );
    }).toList();
    return data;
  }
}
