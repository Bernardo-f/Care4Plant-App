import 'package:care4plant/data/source/local/greenhouse_local_data_source.dart';
import 'package:care4plant/data/source/local/reporte_diario_local_data_source.dart';
import 'package:care4plant/data/source/remote/actividad_remote_data_source.dart';
import 'package:care4plant/data/source/remote/greenhouse_remote_data_source.dart';
import 'package:care4plant/data/source/remote/visita_remote_data_source.dart';
import 'package:care4plant/domain/repositories/categoria_repository.dart';
import 'package:care4plant/domain/usecases/add_ingreso_actividad_usecase.dart';
import 'package:care4plant/domain/usecases/add_pensamiento_usecase.dart';
import 'package:care4plant/domain/usecases/add_reporte_diario_usecase.dart';
import 'package:care4plant/domain/usecases/get_acceso_invernadero_usecase.dart';
import 'package:care4plant/domain/usecases/get_actvidades_by_categoria_usecase.dart';
import 'package:care4plant/domain/usecases/get_frecuencia_test_usecase.dart';
import 'package:care4plant/domain/usecases/get_name_usecase.dart';
import 'package:care4plant/domain/usecases/get_notificacion_actividades_usecase.dart';
import 'package:care4plant/domain/usecases/get_notificacion_test_usecase.dart';
import 'package:care4plant/domain/usecases/get_pensamientos_usecase.dart';
import 'package:care4plant/domain/usecases/get_plant_by_stress_level.dart';
import 'package:care4plant/domain/usecases/get_plant_usecase.dart';
import 'package:care4plant/domain/usecases/get_semana_frecuencia_test_usecase.dart';
import 'package:care4plant/domain/usecases/get_usuarios_greenhouse_usecase.dart';
import 'package:care4plant/domain/usecases/log_visita_usecase.dart';
import 'package:care4plant/domain/usecases/logout_usecase.dart';
import 'package:care4plant/domain/usecases/megusta_pensamiento_usecase.dart';
import 'package:care4plant/domain/usecases/register_stress_test_usecase.dart';
import 'package:care4plant/domain/usecases/set_acceso_invernadero_usecase.dart';
import 'package:care4plant/domain/usecases/set_frecuencia_test_usecase.dart';
import 'package:care4plant/domain/usecases/set_notificacion_actividades_usecase.dart';
import 'package:care4plant/domain/usecases/set_notificacion_test_usecase.dart';
import 'package:care4plant/domain/usecases/validate_date_test_usecase.dart';
import 'package:get_it/get_it.dart';

import 'core/services/network/custom_http_client.dart';
import 'core/services/storage/secure_storage_service.dart';

import 'data/repositories/actividad_repository_impl.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/categoria_repository_impl.dart';
import 'data/repositories/greenhouse_repository_impl.dart';
import 'data/repositories/plant_repository_impl.dart';
import 'data/repositories/reporte_diario_repository_impl.dart';
import 'data/repositories/stress_test_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/repositories/visita_repository_impl.dart';
import 'data/source/local/user_local_data_source.dart';
import 'data/source/remote/auth_remote_data_source.dart';
import 'data/source/remote/categoria_remote_data_source.dart';
import 'data/source/remote/plant_remote_data_source.dart';
import 'data/source/remote/reporte_diario_remote_data_source.dart';
import 'data/source/remote/stress_test_remote_data_source.dart';
import 'data/source/remote/user_remote_data_source.dart';

import 'domain/repositories/actividad_repository.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/greenhouse_repository.dart';
import 'domain/repositories/plant_repository.dart';
import 'domain/repositories/reporte_diario_repository.dart';
import 'domain/repositories/stress_test_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/repositories/visita_repository.dart';
import 'domain/usecases/get_accesorios_usecase.dart';
import 'domain/usecases/get_categorias_recomendadas_usecase.dart';
import 'domain/usecases/get_categorias_usecase.dart';
import 'domain/usecases/get_message_greenhouse_usecase.dart';
import 'domain/usecases/get_reporte_diario_usecase.dart';
import 'domain/usecases/get_stress_level_usecase.dart';
import 'domain/usecases/getall_plants_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/save_settings_usecase.dart';
import 'domain/usecases/set_message_greenhouse_usecase.dart';
import 'domain/usecases/signup_usecase.dart';
import 'domain/usecases/usar_accesorio_usecase.dart';
import 'domain/usecases/validate_session_usecase.dart';

import 'ui/provider/plant_provider.dart';
import 'ui/provider/validate_session_provider.dart';

final GetIt sl = GetIt.instance;

void init() async {
  // Lo registramos como singleton
  sl.registerLazySingleton(() => UserLocalDataSource());
  // Core
  sl.registerLazySingleton(() => CustomHttpClient());
  sl.registerLazySingleton(() => SecureStorageService());

  // Registro de fuente de datos remota
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));
  sl.registerLazySingleton(() => UserRemoteDataSource(sl()));
  sl.registerLazySingleton(() => PlantRemoteDataSource(sl()));
  sl.registerLazySingleton(() => StressTestRemoteDataSource(sl()));
  sl.registerLazySingleton(() => ReporteDiarioRemoteDataSource(sl()));
  sl.registerLazySingleton(() => ReporteDiarioLocalDataSource());
  sl.registerLazySingleton(() => CategoriaRemoteDataSource(sl()));
  sl.registerLazySingleton(() => ActividadRemoteDataSource(sl()));
  sl.registerLazySingleton(() => VisitaRemoteDataSource(sl()));
  sl.registerLazySingleton(() => GreenhouseLocalDataSource());
  sl.registerLazySingleton(() => GreenhouseRemoteDataSource(sl()));

  // Registro del repositorio
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<PlantRepository>(() => PlantRepositoryImpl(sl()));
  sl.registerLazySingleton<StressTestRepository>(() => StressTestRepositoryImpl(sl()));
  sl.registerLazySingleton<ReporteDiarioRepository>(() => ReporteDiarioRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<CategoriaRepository>(() => CategoriaRepositoryImpl(sl()));
  sl.registerLazySingleton<ActividadRepository>(() => ActividadRepositoryImpl(sl()));
  sl.registerLazySingleton<VisitaRepository>(() => VisitaRepositoryImpl(sl()));
  sl.registerLazySingleton<GreenhouseRepository>(() => GreenhouseRepositoryImpl(sl(), sl()));

  // Registro del caso de uso
  sl.registerLazySingleton(() => ValidateSessionUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SaveSettingsUseCase(sl()));
  sl.registerLazySingleton(() => GetAllPlantsUseCase(sl()));
  sl.registerLazySingleton(() => RegisterStressTestUseCase(sl()));
  sl.registerLazySingleton(() => GetNameUseCase(sl()));
  sl.registerLazySingleton(() => GetPlantUseCase());
  sl.registerLazySingleton(() => GetAccesoriosUseCase(sl()));
  sl.registerLazySingleton(() => GetStressLevelUseCase(sl()));
  sl.registerLazySingleton(() => UsarAccesorioUseCase(sl()));
  sl.registerLazySingleton(() => GetReporteDiarioUseCase(sl()));
  sl.registerLazySingleton(() => ValidateDateTestUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoriasRecomendadasUseCase(sl()));
  sl.registerLazySingleton(() => AddReporteDiarioUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoriasUseCase(sl()));
  sl.registerLazySingleton(() => GetActividadesByCategoriaUseCase(sl()));
  sl.registerLazySingleton(() => LogVisitaUseCase(sl()));
  sl.registerLazySingleton(() => AddIngresoActividadUseCase(sl()));
  sl.registerLazySingleton(() => GetUsuariosGreenhouseUseCase(sl()));
  sl.registerLazySingleton(() => GetPensamientosUseCase(sl()));
  sl.registerLazySingleton(() => SetMessageGreenhouseUseCase(sl()));
  sl.registerLazySingleton(() => GetMessageGreenhouseUseCase(sl()));
  sl.registerLazySingleton(() => GetPlantByStressLevelUseCase(sl()));
  sl.registerLazySingleton(() => AddPensamientoUseCase(sl()));
  sl.registerLazySingleton(() => MegustaPensamientoUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => SetAccesoInvernaderoUseCase(sl()));
  sl.registerLazySingleton(() => SetFrecuenciaTestUseCase(sl()));
  sl.registerLazySingleton(() => SetNotificacionActividadesUseCase(sl()));
  sl.registerLazySingleton(() => SetNotificacionTestUseCase(sl()));
  sl.registerLazySingleton(() => GetFrecuenciaTestUseCase(sl()));
  sl.registerLazySingleton(() => GetNotificacionActividadesUseCase(sl()));
  sl.registerLazySingleton(() => GetNotificacionTestUseCase(sl()));
  sl.registerLazySingleton(() => GetSemanaFrecuenciaTestUseCase(sl()));
  sl.registerLazySingleton(() => GetAccesoInvernaderoUseCase(sl()));
  // Registro del provider
  sl.registerFactory(() => ValidateSessionProvider(validateSessionUseCase: sl()));
  sl.registerFactory(() => PlantProvider(
      getPlantUseCase: sl(),
      getAccesoriosUseCase: sl(),
      getStressLevelUseCase: sl(),
      usarAccesorioUseCase: sl()));
}
