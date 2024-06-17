import 'package:flutter/material.dart';
import 'package:quind_demo_project/core/theme/colors.dart';
import 'package:quind_demo_project/core/theme/fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/routes/resource_icons.dart';
import '../../auth/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const routeName = "/";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late WebViewController controller;
  bool hasNavigated = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: firstColor, // Color del borde
                            width: 2, // Ancho del borde
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            userProfile,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "David Granados",
                        style: textBigBold22(secondColor),
                      ),
                      Text(
                        "User",
                        style: textBlackStyle,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.call,
                    color: secondColor,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text("+57 3214658656", style: textStyleInput(secondColor))
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.email,
                    color: secondColor,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text("davigra02@viaso.co", style: textStyleInput(secondColor))
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: secondColor,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text("Calle 34 A #32 -27 Caucasia Ant.",
                      style: textStyleInput(secondColor))
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4),
                leading: const Icon(
                    Icons.favorite_border), // Icono a la izquierda del ListTile
                title: Text(
                  'Contacto seguro',
                  style: textBlackStyleSubTitle,
                ), // Título del ListTile
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4),
                leading: const Icon(Icons
                    .loyalty_outlined), // Icono a la izquierda del ListTile
                title: Text(
                  'Código de promoción',
                  style: textBlackStyleSubTitle,
                ), // Título del ListTile
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4),
                leading: const Icon(
                    Icons.support_agent), // Icono a la izquierda del ListTile
                title: Text(
                  'Soporte técnico',
                  style: textBlackStyleSubTitle,
                ), // Título del ListTile
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4),
                leading: const Icon(
                    Icons.policy_outlined), // Icono a la izquierda del ListTile
                title: Text(
                  'Términos y políticas de privacidad',
                  style: textBlackStyleSubTitle,
                ), // Título del ListTile
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4),
                leading: const Icon(
                    Icons.exit_to_app), // Icono a la izquierda del ListTile
                title: Text(
                  'Salir',
                  style: textBlackStyleSubTitle,
                ), // Título del ListTile
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                 await controller.loadRequest(Uri.parse('https://www.dropbox.com/logout'));
              
              // After logout, navigate to a new page or do other actions
              Navigator.pushReplacementNamed(
                // ignore: use_build_context_synchronously
                context,
                LoginPage.routeName,
              );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
