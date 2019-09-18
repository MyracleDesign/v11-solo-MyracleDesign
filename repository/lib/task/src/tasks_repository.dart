import 'models/task.dart';

abstract class TasksRepository {
  Future<void> addNewTask(Task task);

  Future<void> deleteTask(Task task);

  Stream<List<Task>> tasks();

  Future<void> updateTask(Task task);
}
