import 'package:ashewa_d/provider/user/sand.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/auth/auth_user.dart';
import '../../uitil/shimmer/home.dart';
import '../../widget/home/appbar.dart';
import '../../widget/home/favorite.dart';
import '../../widget/home/featured.dart';
import '../../widget/home/home_sands.dart';

class HomeScreenForUser extends StatefulWidget {
  const HomeScreenForUser({super.key});

  @override
  State<HomeScreenForUser> createState() => _HomeScreenForUserState();
}

class _HomeScreenForUserState extends State<HomeScreenForUser> {
  bool isInit = true;
  late Future _sandData;

  @override
  void didChangeDependencies() {
    if (isInit) {
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.black));
      _sandData = Provider.of<SandProvider>(context, listen: false)
          .getSand(Provider.of<UserAuthProvider>(context).token!);
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffedf2f6),
      body: SafeArea(
        child: Provider.of<SandProvider>(context).favoriteSand.isNotEmpty
            ? const HomeSandsWidget()
            : FutureBuilder(
                future: _sandData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const HomeShimmer();
                    // return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Unknown Error"));
                  } else {
                    // return HomeShimmer();
                    return const HomeSandsWidget();
                  }
                }
              ),
      ),
    );
  }
}
