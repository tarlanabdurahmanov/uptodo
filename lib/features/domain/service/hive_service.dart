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
    print(response);
    openBox.add(response);
  }

  Future<dynamic> getBoxes(String boxName) async {
    final openBox = await Hive.openBox(boxName);
    if (openBox.isNotEmpty) {
      return openBox.getAt(0);
    } else {
      return openBox;
    }
  }

  Future<List<Todo>> getTodos() async {
    String boxname = "todos";
    await getBoxes(boxname);
    var todosbox = Hive.box(boxname);
    final data = todosbox.keys.map((key) {
      final item = todosbox.get(key);
      return Todo(
        userId: item.userId,
        id: key,
        title: item.title,
        description: item.description,
        isCompleted: item.isCompleted,
        taskTime: item.taskTime,
        categoryId: item.categoryId,
        priority: item.priority,
      );
    }).toList();

    return data;
  }

  deleteTodo(dynamic key) async {
    String boxname = "todos";
    await getBoxes(boxname);
    var todosbox = Hive.box(boxname);
    todosbox.delete(key);
  }
}
