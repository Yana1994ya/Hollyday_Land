import "package:flutter/material.dart";
import "package:hollyday_land/providers/login.dart";
import "package:provider/provider.dart";

class ProfileScreen extends StatelessWidget {
  static const routePath = "/profile";

  static DecorationImage userImage(String? imageUrl) {
    if (imageUrl == null) {
      return DecorationImage(
        image: ExactAssetImage("assets/graphics/icon.png"),
        fit: BoxFit.fill,
      );
    } else {
      return DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.fill,
      );
    }
  }

  const ProfileScreen({Key? key}) : super(key: key);

  static Widget loginBody(BuildContext context, LoginProvider loginProvider) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 220),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Image(image: AssetImage("assets/graphics/logo.png")),
              ElevatedButton(
                child: const Text("Log in with Google"),
                onPressed: () {
                  loginProvider.signIn();
                },
              ),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage("assets/graphics/profile_login.jpg"),
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    // if guest
    if (loginProvider.currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: loginBody(context, loginProvider),
      );
    } else {
      // if logged in
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(bottom: 270, top: 80),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: ProfileScreen.userImage(
                          loginProvider.currentUser!.photoUrl),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome ${loginProvider.currentUser!.displayName}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loginProvider.signOut();
                    },
                    child: Text("Log out"),
                  ),
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/graphics/profile.jpg"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter),
          ),
        ),
      );
    }
  }
}
