import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/services/user_service.dart';
import 'package:chall_mobile/widgets/screen.dart';

class ChildrenInviteScreen extends StatefulWidget {
  const ChildrenInviteScreen({super.key});

  @override
  State<ChildrenInviteScreen> createState() => _ChildrenInviteScreenState();
}

class _ChildrenInviteScreenState extends State<ChildrenInviteScreen> {
  final UserService _userService = UserService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _submit() async {
    ApiResponse<Null> response = await _userService.invite(
      name: _nameController.text,
      email: _emailController.text,
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
          content: Text('Enfant invité avec succès'),
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
            "Inviter un enfant",
          ),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Nom',
            ),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Inviter'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
