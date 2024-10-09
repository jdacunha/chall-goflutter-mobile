import 'package:flutter/material.dart';

class DetailsFutureBuilder<T> extends StatelessWidget {
  final Future<T> Function() future;
  final Widget Function(BuildContext, T) builder;

  const DetailsFutureBuilder({
    super.key,
    required this.future,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        if (snapshot.hasData) {
          return builder(context, snapshot.data as T);
        }
        return const Center(
          child: Text('Something went wrong'),
        );
      },
    );
  }
}
