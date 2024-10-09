import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/user_details_response.dart';
import 'package:chall_mobile/router/organisateur_routes.dart';
import 'package:chall_mobile/services/user_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/screen.dart';
import 'package:chall_mobile/widgets/sign_out_button.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  const ProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();

  Future<UserDetailsResponse> _fetchUserDetails() async {
    final response = await _userService.details(userId: widget.userId);
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Profil",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DetailsFutureBuilder<UserDetailsResponse>(
            future: _fetchUserDetails,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileDetail("Nom", data.name),
                  _buildProfileDetail("Email", data.email),
                  _buildProfileDetail("Jetons", data.jetons.toString()),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.push(OrganisateurRoutes.userEdit);
                    },
                    child: const Text("Modifier le mot de passe"),
                  ),
                  const SizedBox(height: 16),
                  const SignOutButton(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
