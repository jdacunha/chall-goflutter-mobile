import 'package:flutter/material.dart';
import 'package:chall_mobile/services/stripe_service.dart';
import 'package:chall_mobile/widgets/number_input.dart';
import 'package:chall_mobile/widgets/screen.dart';
import 'package:go_router/go_router.dart';

class UserJetonEditScreen extends StatefulWidget {
  final int userId;

  const UserJetonEditScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserJetonEditScreen> createState() => _UserCreditEditScreenState();
}

class _UserCreditEditScreenState extends State<UserJetonEditScreen> {
  final StripeService _stripeService = StripeService();
  final TextEditingController _creditController = TextEditingController();

  Future<void> _submit() async {
    // Validation du montant de crédit
    if (_creditController.text.isEmpty || int.tryParse(_creditController.text) == null) {
      _showSnackBar('Veuillez entrer un montant valide.', isError: true);
      return;
    }

    final int creditAmount = int.parse(_creditController.text);

    await _stripeService.stripePaymentCheckout(
      widget.userId,
      creditAmount,
      context,
      onSuccess: () {
        _showSnackBar('Jetons acheté avec succès.');
        context.pop();
      },
      onCancel: () {
        _showSnackBar('Achat de jetons annulé.', isError: true);
      },
      onError: (error) {
        _showSnackBar('Erreur lors de l\'achat des jetons.', isError: true);
      },
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red[400] : Colors.green[400],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Achat de jetons",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          NumberInput(
            controller: _creditController,
            hintText: "Montant de jetons (1 jeton = 1€)",
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Confirmer l\'achat'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _creditController.dispose();
    super.dispose();
  }
}
