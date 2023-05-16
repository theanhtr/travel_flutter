import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/utils/user_preferences.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';
import 'package:travel_app_ytb/representation/screens/Edit_profile_page.dart';
import 'package:travel_app_ytb/representation/screens/login/login_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';
import 'package:travel_app_ytb/representation/widgets/number_widget.dart';
import 'package:travel_app_ytb/representation/widgets/profile_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    widget.log = LoginManager();
    UserModel userProfile = UserModel();
    widget.log.setUserProfileModel();
    final user = LoginManager().userModel;

    Future<String> setUpUserModelAndMakeSureItHasInfor() async {
      await widget.log.setUserProfileModel();
      print(widget.log.userModelProfile.photoUrl.toString());
      return "hello";
    }

    void initState() {
      super.initState();
      setUpUserModelAndMakeSureItHasInfor();
    }

    return FutureBuilder<String>(
      future: setUpUserModelAndMakeSureItHasInfor(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        if (snapshot.hasData) {
          return Scaffold(
            body: LocalStorageHelper.getValue("roleId") == 1
                ? ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      ProfileWidget(
                        imagePath: widget.log.userModelProfile.photoUrl
                                    .toString() !=
                                null
                            ? widget.log.userModelProfile.photoUrl.toString()
                            : "https://cdn.mos.cms.futurecdn.net/JarKa4TVZxSCuN8x8WNPSN.jpg",
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
                          await FirebaseAuth.instance
                              .signOut()
                              .then((value) => {
                                    Loading.dismiss(context),
                                    if (_isLogOut == false)
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
                      physics: BouncingScrollPhysics(),
                      children: [
                        ProfileWidget(
                          imagePath: widget.log.userModelProfile.photoUrl
                                      .toString() !=
                                  null
                              ? widget.log.userModelProfile.photoUrl.toString()
                              : "https://cdn.mos.cms.futurecdn.net/JarKa4TVZxSCuN8x8WNPSN.jpg",
                          onClicked: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage()),
                            );
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
                            await FirebaseAuth.instance
                                .signOut()
                                .then((value) => {
                                      Loading.dismiss(context),
                                      if (_isLogOut == false)
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
