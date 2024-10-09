import 'package:flutter/material.dart';

class ListFutureBuilder<T> extends StatelessWidget {
  final Future<List<T>> Function() future;
  final Widget Function(BuildContext, T) builder;

  const ListFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return builder(context, snapshot.data![index]);
            },
          );
        }
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(child: Text('Pas de données'));
        }
        return const Center(child: Text('Une erreur est survenue'));
      },
    );
  }
}
