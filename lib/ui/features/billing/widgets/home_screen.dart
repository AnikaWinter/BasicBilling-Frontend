import 'package:basic_billing_application/ui/features/billing/widgets/new_bill_dialog.dart';
import 'package:basic_billing_application/ui/features/billing/widgets/pay_bill_dialog.dart';
import 'package:basic_billing_application/ui/features/billing/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(fontSize: 30),),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.orange,
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.1,
        padding: const EdgeInsets.all(20),
        children: [
          _HomeCard(icon: Icons.add_to_photos_rounded, label: 'Create Bill', onTap: () => _newBill(context)),
          _HomeCard(icon: Icons.payments_outlined, label: 'Pay Bill', onTap: () => _payBill(context)),
          _HomeCard(icon: Icons.content_paste_search_rounded, label: 'Pending Bills', onTap: () => context.push('/pending-bills')),
          _HomeCard(icon: Icons.history, label: 'Payment History', onTap: () => context.push('/payment-history'))
        ],)
    );
  }

  Future<void> _newBill(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => const NewBillDialog(),
    );

    if(!context.mounted) return;

    if (result == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessDialog(text: 'Bill created successfully!'),
      );
      await Future.delayed(const Duration(seconds: 2));
      if(!context.mounted) return;
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
  }

  Future<void> _payBill(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => const PayBillDialog(),
    );

    if(!context.mounted) return;

    if (result == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessDialog(text: 'Bill payed successfully!',),
      );
      await Future.delayed(const Duration(seconds: 2));
      if(!context.mounted) return;
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
  }
}

class _HomeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HomeCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        splashColor: Colors.orange.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 48, color: Colors.orange),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
