import 'package:cloud_firestore/cloud_firestore.dart';

import 'entities/entities.dart';
import 'models/models.dart';
import 'tasks_repository.dart';

class FirebaseTasksRepository implements TasksRepository {
  final taskCollection = Firestore.instance.collection("tasks");

  @override
  Future<void> addNewTask(Task task) {
    return taskCollection.add(task.toEntity().toDocument());
  }

  @override
  Future<void> deleteTask(Task task) {
    return taskCollection.document(task.id).delete();
  }

  @override
  Stream<List<Task>> tasks() {
    return taskCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Task.fromEntity(TaskEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateTask(Task update) {
    return taskCollection
        .document(update.id)
        .updateData(update.toEntity().toDocument());
  }
}
