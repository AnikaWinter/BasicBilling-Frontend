import 'package:basic_billing_application/core/result.dart';
import 'package:basic_billing_application/ui/core/common/validators.dart';
import 'package:basic_billing_application/ui/features/billing/viewModels/manage_bill_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewBillDialog extends StatefulWidget {
  const NewBillDialog({super.key});

  @override
  State<NewBillDialog> createState() => _NewBillDialogState();
}

class _NewBillDialogState extends State<NewBillDialog> {
  final _formKey = GlobalKey<FormState>();

  String? selectedClientId;
  String? selectedServiceId;
  final periodController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ManageBillViewModel>().loadDropdownData();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final vm = context.read<ManageBillViewModel>();
    final result = await vm.submitBill(
      clientId: selectedClientId!,
      serviceId: selectedServiceId!,
      period: periodController.text,
      amount: int.parse(amountController.text),
    );

    if (!mounted) return;

    if (result is Success<void>) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ManageBillViewModel>();

    return AlertDialog(
      title: const Text('Create New Bill'),
      content:
          vm.isLoading
              ? const SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              )
              : Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (vm.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          vm.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    DropdownButtonFormField<String>(
                      value: selectedClientId,
                      hint: const Text('Select Client'),
                      items:
                          vm.clientIds
                              .map(
                                (id) => DropdownMenuItem(
                                  value: id,
                                  child: Text(id),
                                ),
                              )
                              .toList(),
                      validator: AppValidators.required('a client'),
                      onChanged:
                          (val) => setState(() => selectedClientId = val),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedServiceId,
                      hint: const Text('Select Service'),
                      items:
                          vm.services
                              .map(
                                (service) => DropdownMenuItem(
                                  value: service.id, 
                                  child: Text(
                                    service.name,
                                  ),
                                ),
                              )
                              .toList(),
                      validator: AppValidators.required('a service'),
                      onChanged:
                          (val) => setState(() => selectedServiceId = val),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: periodController,
                      decoration: const InputDecoration(
                        labelText: 'Period (YYYYMM)',
                      ),
                      validator: AppValidators.periodFormat(),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(
                        labelText: 'Amount (USD)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: AppValidators.requiredPositive('amount'),
                    ),
                  ],
                ),
              ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _submitForm, child: const Text('Submit')),
      ],
    );
  }
}
