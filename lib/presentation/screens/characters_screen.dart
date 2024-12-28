import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u4_pa2/presentation/blocs/characters/characters_bloc.dart';
import 'package:u4_pa2/presentation/blocs/characters/characters_event.dart';
import 'package:u4_pa2/presentation/blocs/characters/characters_state.dart';
import 'package:u4_pa2/presentation/blocs/login/login_bloc.dart';
import 'package:u4_pa2/presentation/blocs/login/login_event.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});
  @override
  State<CharactersScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharactersScreen> {
  String _filter = '';

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(LoadCharactersEvent(_filter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes de Harry Potter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<LoginBloc>().add(LogoutButtonPressed());
              context.go('/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _filter = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    context
                      .read<CharacterBloc>()
                      .add(LoadCharactersEvent(_filter));
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                // Mostrar el indicador de carga mientras isLoading sea true
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                // Mostrar mensaje de error si hay uno
                else if (state.errorMessage.isNotEmpty) {
                  return Center(child: Text(state.errorMessage));
                }
                // Mostrar la lista de personajes
                else if (state.characters.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.characters.length,
                    itemBuilder: (context, index) {
                      final character = state.characters[index];
                      return ListTile(
                        leading: Image.network(character.image ?? "https://media.istockphoto.com/id/1334419989/photo/3d-red-question-mark.jpg?s=612x612&w=0&k=20&c=bpaGVuyt_ACui3xK8CvkeoVQC-jczxANZTMXGKAE11E="),
                        title: Text("${character.name} - ${character.wand.wood ?? "No wood"}, ${character.wand.core ?? "No core"}, ${character.wand.length ?? 5}"),
                        subtitle: Text(character.house)
                      );
                    },
                  );
                }
                // Si no hay personajes, mostrar un mensaje vacío
                else {
                  return const Center(
                    child: Text(
                    'No hay personajes que coincidan con el filtro.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}