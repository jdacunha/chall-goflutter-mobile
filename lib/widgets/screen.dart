import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const Screen({
    Key? key,
    required this.child,
    this.appBar,
  }) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
