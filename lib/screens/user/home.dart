import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/auth.dart';
import '../../provider/sand.dart';
import '../../uitil/shimmer/home.dart';
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
          .getSand(Provider.of<AuthProvider>(context).token!);
      Provider.of<SandProvider>(context, listen: false)
          .getMyWishList(Provider.of<AuthProvider>(context).token!);
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
        child: Provider.of<SandProvider>(context).featuredSand.isNotEmpty
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
                }),
      ),
    );
  }
}
