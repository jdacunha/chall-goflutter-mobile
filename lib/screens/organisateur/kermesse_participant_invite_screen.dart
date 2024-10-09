import 'package:flutter/material.dart';
import 'package:chall_mobile/data/user_list_response.dart';
import 'package:chall_mobile/services/kermesse_service.dart';
import 'package:chall_mobile/services/user_service.dart';
import 'package:chall_mobile/widgets/list_future_builder.dart';
import 'package:chall_mobile/widgets/screen_list.dart';
import 'package:go_router/go_router.dart';

import '../../api/api_response.dart';

class KermesseParticipantInviteScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseParticipantInviteScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseParticipantInviteScreen> createState() =>
      _KermesseUserInviteScreenState();
}

class _KermesseUserInviteScreenState extends State<KermesseParticipantInviteScreen> {
  final UserService _userService = UserService();
  final KermesseService _kermesseService = KermesseService();

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response =
    await _userService.listInviteKermesse(kermesseId: widget.kermesseId);
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _invite(int userId) async {
    ApiResponse<Null> response = await _kermesseService.inviteParticipant(
      kermesseId: widget.kermesseId,
      userId: userId,
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
          content: Text('Participant invité avec succès'),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Inviter des participants",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListFutureBuilder<UserListItem>(
              future: _getAll,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.email),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      await _invite(item.id);
                    },
                    child: const Text('Inviter'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
