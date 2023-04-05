import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:flutter/material.dart';

class UserContractDetails extends StatefulWidget {
  const UserContractDetails({Key? key, required this.user}) : super(key: key);
  final User user;

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userContractDetailsPage);
  }

  @override
  State<UserContractDetails> createState() => _UserContractDetailsState();
}

class _UserContractDetailsState extends State<UserContractDetails> {
  String _planName = "";
  String _price = "";
  String _currency = "";
  String _expiresDate = "";
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSubscription();
    });
  }

  Future _loadSubscription() async {
    final Map? resMap = await RemoteUsers.contractDetails();
    if (resMap == null) return;
    _planName = resMap['plan_name'];
    _price = resMap['price'];
    _currency = resMap['currency'];
    _expiresDate = resMap['expires_date'];
    setState(() {
      _planName;
      _price;
      _currency;
      _expiresDate;
      _initDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_initDone == false) {
      return Container(
          alignment: Alignment.center, child: const LoadingSpinner());
    }

    return Container(
        child: Column(
      children: [
        Text(_planName),
        Text(_price),
        Text(_currency),
        Text(_expiresDate),
      ],
    ));
  }
}
