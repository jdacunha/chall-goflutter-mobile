import 'package:flutter/material.dart';

class StandTypeSelect extends StatefulWidget {
  final String defaultValue;
  final Function(String) onChange;

  const StandTypeSelect({
    super.key,
    required this.defaultValue,
    required this.onChange,
  });

  @override
  State<StandTypeSelect> createState() => _StandTypeSelectState();
}

class _StandTypeSelectState extends State<StandTypeSelect> {
  late String _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedType,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedType = newValue;
          });
          widget.onChange(newValue);
        }
      },
      items: const [
        DropdownMenuItem(
          value: 'ACTIVITE',
          child: Text('Activité'),
        ),
        DropdownMenuItem(
          value: 'VENTE',
          child: Text('Vente'),
        ),
      ],
    );
  }
}
