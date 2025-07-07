import 'package:basic_billing_application/ui/features/billing/viewModels/view_bills_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewBillsScreen extends StatefulWidget {
  final String status;
  const ViewBillsScreen({super.key, required this.status});

  @override
  State<ViewBillsScreen> createState() => _ViewBillsScreenState();
}

class _ViewBillsScreenState extends State<ViewBillsScreen> {
  String? selectedClientId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ViewBillsViewModel>().loadDropdownData();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ViewBillsViewModel>();
    return Scaffold(
      appBar: AppBar(
        title:
            widget.status == 'pending'
                ? Text('Pending Bills')
                : Text('Payment History'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.orange,
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child:
            vm.isLoading
                ? const SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownMenu<String>(
                      width: 500,
                      initialSelection: selectedClientId,
                      hintText: 'Select Client',
                      onSelected: (value) async {
                        if (widget.status == 'pending') {
                          await context
                              .read<ViewBillsViewModel>()
                              .loadPendingBills(value!);
                        } else {
                          await context.read<ViewBillsViewModel>().loadPaidBills(
                            value!,
                          );
                        }
                        setState(() => selectedClientId = value);
                      },
                      dropdownMenuEntries:
                          vm.clientIds
                              .map(
                                (id) => DropdownMenuEntry(value: id, label: id),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 20),
                    if (vm.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          vm.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    if (selectedClientId != null)
                      widget.status == 'pending'
                          ? vm.pendingBills.isEmpty
                              ? Text(
                                'No pending bills for Client $selectedClientId!',
                              )
                              : Expanded(
                                child: ListView.builder(
                                  itemCount: vm.pendingBills.length,
                                  itemBuilder: (_, index) {
                                    final bill = vm.pendingBills[index];
                                    return Card(
                                      child: ListTile(
                                        title: Text('Service: ${bill.serviceType}'),
                                        subtitle: Text(
                                          'Amount: \$${bill.amount}',
                                        ),
                                        trailing: Text(
                                          'Period: ${bill.period}',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                          : vm.paidBills.isEmpty
                          ? Text('No paid bills for Client $selectedClientId!')
                          : Expanded(
                            child: ListView.builder(
                              itemCount: vm.paidBills.length,
                              itemBuilder: (_, index) {
                                final bill = vm.paidBills[index];
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      'Service: ${bill.serviceType} ${bill.period}',
                                    ),
                                    subtitle: Text('Amount: \$${bill.amount}'),
                                    trailing: Text('Paid: ${bill.paymentDate}'),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
      ),
    );
  }
}
