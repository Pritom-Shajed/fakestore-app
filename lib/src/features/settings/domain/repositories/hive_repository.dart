abstract class HiveRepository {

  // For initializing the database
  Future<void> init();

  // For deleting the database
  Future<void> delete();
}
