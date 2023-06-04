import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';
import 'package:travel_app_ytb/representation/screens/Edit_profile_page.dart';
import 'package:travel_app_ytb/representation/screens/login/login_screen.dart';
import 'package:travel_app_ytb/representation/screens/order/order_history_screen.dart';
import 'package:travel_app_ytb/representation/screens/user_fill_in_information_screen.dart';
import 'package:travel_app_ytb/representation/widgets/animation/alarm_animation.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_icon_widget.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';
import 'package:travel_app_ytb/representation/widgets/number_widget.dart';
import 'package:travel_app_ytb/representation/widgets/profile_widget.dart';

import '../../core/constants/color_palatte.dart';
import '../../routes.dart';

// import 'package:user_profile_example/model/user.dart';
// import 'package:user_profile_example/utils/user_preferences.dart';
// import 'package:user_profile_example/widget/appbar_widget.dart';
// import 'package:user_profile_example/widget/button_widget.dart';
// import 'package:user_profile_example/widget/numbers_widget.dart';
// import 'package:user_profile_example/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  static const routeName = 'profile_screen';

  // final UserModel userModelProfile = LoginManager().userModelProfile;
  late LoginManager log = LoginManager();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLogOut = false;

  Future<String> setUpUserModelAndMakeSureItHasInfor() async {
    await widget.log.setUserProfileModel();
    print(widget.log.userModelProfile.photoUrl.toString());
    return "hello";
  }

  @override
  void initState() {
    super.initState();
    setUpUserModelAndMakeSureItHasInfor();
  }

  @override
  Widget build(BuildContext context) {
    widget.log = LoginManager();
    widget.log.setUserProfileModel();
    return FutureBuilder<String>(
      future: setUpUserModelAndMakeSureItHasInfor(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }
        if (snapshot.hasData) {
          return Scaffold(
            body: LocalStorageHelper.getValue("roleId") == 1
                ? ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ProfileWidget(
                        imagePath: widget.log.userModelProfile.photoUrl != null
                            ? widget.log.userModelProfile.photoUrl.toString()
                            : ConstUtils.defaultImageAvatar,
                        onClicked: () async {
                          Navigator.of(context).pushNamed(
                              // MaterialPageRoute(
                              //   builder: (context) => EditProfilePage(),
                              // ),
                              EditProfilePage.routeName,
                              arguments: {
                                "reloadProfile": () {
                                  setState(() {});
                                }
                              });
                        },
                        isEdit: false,
                      ),
                      const SizedBox(height: 24),
                      buildName(widget.log.userModelProfile),
                      const SizedBox(height: 32),
                      NumbersWidget(),
                      const SizedBox(height: 32),
                      ButtonWidget(
                        title: LocalizationText.logout,
                        ontap: () async {
                          Loading.show(context);
                          await LoginManager().signOut().then((value) => {
                                Loading.dismiss(context),
                                if (value == true && _isLogOut == false)
                                  {
                                    Navigator.popAndPushNamed(
                                        context, LoginScreen.routeName),
                                    _isLogOut = true,
                                  }
                              });
                        },
                      )
                      // buildAbout(widget.log.userModelProfile)
                    ],
                  )
                : AppBarContainer(
                    titleString: LocalizationText.profile,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ProfileWidget(
                          imagePath: widget.log.userModelProfile.photoUrl
                                      .toString() !=
                                  null
                              ? widget.log.userModelProfile.photoUrl.toString()
                              : ConstUtils.defaultImageAvatar,
                          onClicked: () async {
                            print(
                                "dong 132: ${widget.log.userModelProfile.firstName.runtimeType}");
                            if (widget.log.userModelProfile.firstName == null) {
                              Navigator.of(context).pushNamed(
                                  FillInforScreen.routeName,
                                  arguments: {
                                    "reloadProfile": () {
                                      setState(() {});
                                    }
                                  });
                            } else {
                              Navigator.of(context).pushNamed(
                                  // MaterialPageRoute(
                                  //   builder: (context) => EditProfilePage(),
                                  // ),
                                  EditProfilePage.routeName,
                                  arguments: {
                                    "reloadProfile": () {
                                      setState(() {});
                                    }
                                  });
                            }
                          },
                          isEdit: false,
                        ),
                        const SizedBox(height: 24),
                        buildName(widget.log.userModelProfile),
                        const SizedBox(height: 32),
                        NumbersWidget(),
                        const SizedBox(height: 32),
                        ButtonWidget(
                          title: LocalizationText.logout,
                          ontap: () async {
                            Loading.show(context);
                            await LoginManager().signOut().then((value) => {
                                  Loading.dismiss(context),
                                  if (value == true && _isLogOut == false)
                                    {
                                      Navigator.popAndPushNamed(
                                          context, LoginScreen.routeName),
                                      _isLogOut = true,
                                    }
                                });
                          },
                        ),
                        const SizedBox(height: 32),
                        Stack(
                          children: [
                            ButtonWidget(
                              title: LocalizationText.orderHistory,
                              ontap: () {
                                Navigator.pushNamed(
                                    context, OrderHistoryScreen.routeName);
                              },
                            ),
                            const Positioned(
                              right: 10,
                              // TODO remove fake data
                              child: AlarmAnimation(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          );
        }
        return Container();
      },
    );
  }

  Widget buildName(UserModel user) => Column(
        children: [
          Text(
            "${user.firstName} ${user.lastName}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            LoginManager().userModel.email.toString(),
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(UserModel user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            Text(
              LocalizationText.about,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // ignore: prefer_const_constructors
            Text(
              user.about.toString(),
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
