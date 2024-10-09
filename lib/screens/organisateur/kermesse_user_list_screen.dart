import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/data/user_list_response.dart';
import 'package:chall_mobile/router/organisateur_routes.dart';
import 'package:chall_mobile/services/user_service.dart';
import 'package:chall_mobile/widgets/list_future_builder.dart';
import 'package:chall_mobile/widgets/screen_list.dart';

import '../../services/kermesse_service.dart';

class KermesseUserListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseUserListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseUserListScreen> createState() => _KermesseUserListScreenState();
}

class _KermesseUserListScreenState extends State<KermesseUserListScreen> {
  final UserService _userService = UserService();
  final KermesseService _kermesseService = KermesseService();
  String _kermesseStatus = '';

  Future<List<UserListItem>> _fetchKermesseUsers() async {
    final response = await _userService.list(kermesseId: widget.kermesseId);
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  // Récupérer le statut de la kermesse
  Future<void> _fetchKermesseStatus() async {
    final response = await _kermesseService.details(kermesseId: widget.kermesseId);
    if (response.error != null) {
      throw Exception(response.error);
    }
    setState(() {
      _kermesseStatus = response.data!.statut;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchKermesseStatus(); // Appel initial pour obtenir le statut de la kermesse
  }

  void _inviteUser() {
    context.push(
      OrganisateurRoutes.kermesseParticipantInvite,
      extra: {'kermesseId': widget.kermesseId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Participants",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _kermesseStatus == 'ENDED' ? null : _inviteUser,
            child: Text(
              'Inviter',
              style: TextStyle(
                color: _kermesseStatus == 'ENDED' ? Colors.grey : Colors.deepPurple,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListFutureBuilder<UserListItem>(
              future: _fetchKermesseUsers,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.role),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
