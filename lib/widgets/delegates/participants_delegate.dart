import 'package:divide_ai/models/participant.dart';
import 'package:divide_ai/services/user_service.dart';
import 'package:flutter/material.dart';

class ParticipantsDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Nome ou tag de usuário';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.grey[600],
        ),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder<List<Participant>?>(
      future: _getSuggestions(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text('Erro ao buscar usuários.'),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('Nenhum usuário encontrado.'),
              );
            }

            final suggestions = snapshot.data!;

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              itemCount: suggestions.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
                child: Divider(),
              ),
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return ListTile(
                  onTap: () => close(context, suggestion.toJSONString()),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[500],
                    backgroundImage: suggestion.avatarUrl != null
                        ? NetworkImage(suggestion.avatarUrl!)
                        : null,
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        suggestion.name!,
                        style: const TextStyle(fontSize: 18, height: 1.2),
                      ),
                      Text(
                        '@${suggestion.username}',
                        style: TextStyle(
                            fontSize: 14, height: 1, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              },
            );
        }
      },
    );
  }

  Future<List<Participant>?> _getSuggestions() {
    return UserService().findUserByNameOrUsername(query);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }
}
