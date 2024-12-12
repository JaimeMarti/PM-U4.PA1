import 'package:dartz/dartz.dart';
import 'package:u4_pa1/data/datasources/character_remote_datasource.dart';
import 'package:u4_pa1/domain/entities/character.dart';
import 'package:u4_pa1/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, List<Character>>> getAllCharacters() async {
    try {
      final characterModels = await remoteDataSource.getAllCharacters();
      return Right(characterModels
        .map((model) => Character(
          name: model.name, house: model.house, image: model.image))
        .toList());
    } catch (e) {
      return Left(Exception('Error al cargar personajes'));
    }
  }
}