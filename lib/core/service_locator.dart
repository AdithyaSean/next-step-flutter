import 'package:get_it/get_it.dart';
import '../data/database/app_database.dart';
import '../services/firebase_db_service.dart';
import '../data/repositories/student_repository.dart';
import '../controllers/auth_controller.dart';
import '../services/tflite_service.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  try {
    // Database - ensure it's properly initialized
    final database = AppDatabase();
    locator.registerSingleton<AppDatabase>(database);
    
    // Verify database is accessible
    await database.customSelect('SELECT 1').get();
    print('Database initialized successfully');
    
    // Services
    final firebaseDB = FirebaseDBService(database);
    locator.registerSingleton<FirebaseDBService>(firebaseDB);
    
    // Initialize FirebaseDBService
    await firebaseDB.initialize().timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        print('FirebaseDBService initialization timed out, continuing...');
      },
    );
    
    // Repositories
    locator.registerSingleton<StudentRepository>(
      StudentRepository(database, firebaseDB),
    );
    
    // Controllers
    locator.registerSingleton<AuthController>(
      AuthController(locator<StudentRepository>()),
    );

    // TFLiteService
    final tfliteService = TFLiteService();
    locator.registerSingleton<TFLiteService>(tfliteService);
    await tfliteService.initialize();
    
  } catch (e, stackTrace) {
    print('Error during service locator setup: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
}
