import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chall_mobile/api/api_response.dart';
import 'package:chall_mobile/data/user_details_response.dart';
import 'package:chall_mobile/router/parent_routes.dart';
import 'package:chall_mobile/services/user_service.dart';
import 'package:chall_mobile/widgets/details_future_builder.dart';
import 'package:chall_mobile/widgets/screen.dart';
import 'package:chall_mobile/widgets/sign_out_button.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  const UserDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final UserService _userService = UserService();
  late Future<UserDetailsResponse> _userDetailsFuture;

  @override
  void initState() {
    super.initState();
    _userDetailsFuture = _fetchUserDetails();
  }

  Future<UserDetailsResponse> _fetchUserDetails() async {
    final response = await _userService.details(userId: widget.userId);
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  void _navigateToEditPassword() {
    context.push(ParentRoutes.userEdit);
  }

  void _navigateToBuyCredit() {
    context.push(ParentRoutes.userJetonEdit);
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
          FutureBuilder<UserDetailsResponse>(
            future: _userDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final user = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Nom', user.name),
                    _buildDetailRow('Email', user.email),
                    _buildDetailRow('Jetons', user.jetons.toString()),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _navigateToEditPassword,
                      child: const Text("Modifier mot de passe"),
                    ),
                    ElevatedButton(
                      onPressed: _navigateToBuyCredit,
                      child: const Text("Acheter des jetons"),
                    ),
                    const SizedBox(height: 16),
                    const SignOutButton(),
                  ],
                );
              }
              return const Center(child: Text('Aucune donnée disponible.'));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
