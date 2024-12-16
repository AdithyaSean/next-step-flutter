import 'package:get_it/get_it.dart';
import '../data/database/app_database.dart';
import '../services/firebase_db_service.dart';
import '../data/repositories/student_repository.dart';
import '../controllers/auth_controller.dart';
import '../services/tflite_service.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Database
  final database = AppDatabase();
  locator.registerSingleton<AppDatabase>(database);
  
  // Services
  locator.registerSingleton<FirebaseDBService>(
    FirebaseDBService(locator<AppDatabase>()),
  );
  
  // Repositories
  locator.registerSingleton<StudentRepository>(
    StudentRepository(
      locator<AppDatabase>(),
      locator<FirebaseDBService>(),
    ),
  );
  
  // Controllers
  locator.registerSingleton<AuthController>(
    AuthController(locator<StudentRepository>()),
  );

  // TFLiteService
  locator.registerSingleton<TFLiteService>(TFLiteService());
  await locator<TFLiteService>().initialize();
}
