import 'package:u4_pa2/data/datasources/character_remote_datasource.dart';
import 'package:u4_pa2/data/repositories/character_repository_impl.dart';
import 'package:u4_pa2/domain/repositories/character_repository.dart';
import 'package:u4_pa2/domain/usecases/get_all_characters_usecase.dart';
import 'package:u4_pa2/presentation/blocs/characters/characters_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // BloC
  sl.registerFactory(() => CharacterBloc(sl()));

  // Casos de uso
  sl.registerLazySingleton(() => GetAllCharacters(sl()));

  // Repositorios
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(sl()),
  );

  // Cliente HTTP
  sl.registerLazySingleton(() => http.Client());
}