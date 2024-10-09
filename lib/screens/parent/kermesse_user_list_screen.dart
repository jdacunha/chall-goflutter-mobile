import 'package:flutter/material.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/user_list_response.dart';
import 'package:chall_mobile/services/user_service.dart';
import 'package:chall_mobile/widgets/list_future_builder.dart';
import 'package:chall_mobile/widgets/screen_list.dart';

class KermesseUserListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseUserListScreen({
    Key? key,
    required this.kermesseId,
  }) : super(key: key);

  @override
  State<KermesseUserListScreen> createState() => _KermesseUserListScreenState();
}

class _KermesseUserListScreenState extends State<KermesseUserListScreen> {
  final UserService _userService = UserService();

  Future<List<UserListItem>> _fetchKermesseUsers() async {
    final response = await _userService.listChildren(kermesseId: widget.kermesseId);
    if (response.error != null) {
      throw Exception('Erreur lors de la récupération des utilisateurs: ${response.error}');
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Text(
              "Liste des utilisateurs",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListFutureBuilder<UserListItem>(
              future: _fetchKermesseUsers,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text("Rôle : ${item.role}"),
                );
              },
              ),
            ),
        ],
      ),
    );
  }
}
