import 'package:dartz/dartz.dart';
import 'package:u4_pa2/domain/entities/character.dart';
import 'package:u4_pa2/domain/repositories/character_repository.dart';

class GetAllCharacters {
  final CharacterRepository repository;

  GetAllCharacters(this.repository);

  Future<Either<Exception, List<Character>>> call() async {
    return await repository.getAllCharacters();
  }
}