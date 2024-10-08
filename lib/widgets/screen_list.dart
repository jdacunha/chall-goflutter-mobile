import 'package:flutter/material.dart';

class ScreenList extends StatefulWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const ScreenList({
    Key? key,
    required this.child,
    this.appBar,
  }) : super(key: key);

  @override
  State<ScreenList> createState() => _ScreenListState();
}

class _ScreenListState extends State<ScreenList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: widget.child,
        ),
      ),
    );
  }
}
