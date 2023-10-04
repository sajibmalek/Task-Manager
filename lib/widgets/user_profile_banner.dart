import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/screens/auth/auth_utility.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/update_profile.dart';

class UserProfileAppBar extends StatefulWidget {
  const UserProfileAppBar({
    super.key,
  });

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const UpdateProfileScreen()));
        //imagePicker;
      },
      child: ListTile(
        tileColor: Colors.green,
        textColor: Colors.white,
        leading:SizedBox(
          width: 25,
          height:25,
          child: Center(
            child: CachedNetworkImage(
              color: Colors.red,
              width: 25,
              height: 25,
              imageUrl: AuthUtility.userInfo.data?.photo ?? '',
              placeholder: (_, __) => Image.asset("assets/images/profile.png"),
              errorWidget: (_, __, ___) => Image.asset("assets/images/profile.png"),
            ),
          ),
        ),
        title: Text(
            "${AuthUtility.userInfo.data?.firstName}  ${AuthUtility.userInfo.data?.lastName}"),
        subtitle: Text("${AuthUtility.userInfo.data?.email}"),
        trailing: IconButton(
          onPressed: () async {
            await AuthUtility.logOutPref();
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            }
          },
          icon: const Icon(Icons.login_outlined),
          color: Colors.white,
        ),
      ),
    );
  }
}
