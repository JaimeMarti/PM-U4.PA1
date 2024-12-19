import 'package:dartz/dartz.dart';
import 'package:u4_pa2/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Exception, List<Character>>> getAllCharacters();
}