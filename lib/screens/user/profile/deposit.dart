import 'package:ashewa_d/provider/auth.dart';
import 'package:ashewa_d/provider/payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';
import '../../../uitil/http_error.dart';
import '../../../uitil/toast.dart';
import '../../../widget/textfield.dart';

class DepositScreen extends StatefulWidget {
  final String id;
  final String name;
  const DepositScreen({super.key, required this.name, required this.id});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _accountNameController = TextEditingController();
  final _accountnumberController = TextEditingController();
  final _referenceController = TextEditingController();
  final _depositAmountController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountnumberController.dispose();
    _referenceController.dispose();
    _depositAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(widget.name, style: const TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              //
              //Account Number
              //
              CustomTextFieldWidget(
                  hint: "Account Number", controller: _accountnumberController),
              const SizedBox(height: 15),
              //
              //Account Holder Name
              //
              CustomTextFieldWidget(
                  hint: "Account Holder Name",
                  controller: _accountNameController),
              const SizedBox(height: 15),
              //
              //Bank Name
              //
              CustomTextFieldWidget(
                  hint: "Reference Number", controller: _referenceController),

              const SizedBox(height: 15),
              //
              //
              //
              CustomTextFieldWidget(
                  hint: "Deposit Amount", controller: _depositAmountController),

              const SizedBox(height: 35),
              _isLoading
                  ? Center(
                      child: Transform.scale(
                        scale: 0.6,
                        child: const CircularProgressIndicator(),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => validate(),
                      child: Container(
                        height: 46,
                        width: screenSize.width * 0.9,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: AppColor.primaryColor),
                        child: const Text(
                          "Process Deposit",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void validate() async {
    if (_accountnumberController.text.length < 4) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid account number");
    } else if (_accountnumberController.text.length < 2) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid account holder Name");
    } else if (_referenceController.text.length < 2) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid reference number");
    } else if (_depositAmountController.text.isEmpty) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid deposit amount");
    } else {
      try {
        FocusScope.of(context).unfocus();
        setState(() {
          _isLoading = true;
        });
        Provider.of<PaymentProvider>(context, listen: false)
            .addDeposit(
                context: context,
                token: Provider.of<AuthProvider>(context, listen: false).token!,
                accountId: widget.id,
                amount: _depositAmountController.text,
                accountHolder: _accountNameController.text,
                accountNumber: _accountnumberController.text,
                referenceNumber: _referenceController.text)
            .then((value) {
          showScaffoldMessanger(
              context: context,
              backgroundColor: Colors.green,
              errorMessage: "Success");
          Navigator.of(context).pop();
        });
      } on CustomHttpException catch (e) {
        setState(() {
          _isLoading = false;
        });
        showScaffoldMessanger(context: context, errorMessage: e.toString());
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print(e.toString());
        // showScaffoldMessanger(context: context, errorMessage: e.toString());
      }
    }
  }
}
