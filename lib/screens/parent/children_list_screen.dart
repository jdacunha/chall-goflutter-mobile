import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/user_list_response.dart';
import 'package:chall_mobile/router/parent_routes.dart';
import 'package:chall_mobile/services/user_service.dart';
import 'package:chall_mobile/widgets/list_future_builder.dart';
import 'package:chall_mobile/widgets/screen_list.dart';

class ChildrenListScreen extends StatefulWidget {
  const ChildrenListScreen({
    super.key,
  });

  @override
  State<ChildrenListScreen> createState() => _ChildrenListScreenState();
}

class _ChildrenListScreenState extends State<ChildrenListScreen> {
  final UserService _userService = UserService();

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response =
        await _userService.listChildren();
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mes enfants",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              context.push(
                ParentRoutes.childrenInvite,
              );
            },
            child: const Text('Inviter'),
          ),
          Expanded(
            child: ListFutureBuilder<UserListItem>(
              future: _getAll,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.email),
                  onTap: () {
                    context.push(
                      ParentRoutes.childrenDetails,
                      extra: {
                        "userId": item.id,
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
