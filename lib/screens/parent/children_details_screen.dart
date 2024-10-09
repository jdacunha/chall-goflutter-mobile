import 'package:flutter/material.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/user_details_response.dart';
import 'package:chall_mobile/services/user_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/number_input.dart';
import 'package:chall_mobile/widgets/screen.dart';
import 'package:go_router/go_router.dart';

class ChildrenDetailsScreen extends StatefulWidget {
  final int userId;

  const ChildrenDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ChildrenDetailsScreen> createState() => _ChildrenDetailsScreenState();
}

class _ChildrenDetailsScreenState extends State<ChildrenDetailsScreen> {
  final UserService _userService = UserService();

  final TextEditingController _amountController = TextEditingController();

  Future<UserDetailsResponse> _get() async {
    ApiResponse<UserDetailsResponse> response = await _userService.details(
      userId: widget.userId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _send() async {
    ApiResponse<Null> response = await _userService.distributeJetons(
      childId: widget.userId,
      montant: int.parse(_amountController.text),
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jetons envoyés avec succès'),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Détails de l'enfant",
          ),
          DetailsFutureBuilder<UserDetailsResponse>(
            future: _get,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name),
                  Text(data.email),
                  Text(data.jetons.toString()),
                  NumberInput(
                    hintText: "Montant",
                    controller: _amountController,
                  ),
                  ElevatedButton(
                    onPressed: _send,
                    child: const Text("Envoyer des jetons"),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
