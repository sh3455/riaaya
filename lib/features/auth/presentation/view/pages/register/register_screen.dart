import 'package:flutter/material.dart';
import 'package:riaaya_app/features/auth/presentation/view/widgets/register/client_Register_layout.dart';
import 'package:riaaya_app/features/auth/presentation/view/widgets/register/nurse_Register_client.dart';

import '../../widgets/login/client_login_layout.dart';
import '../../widgets/login/nurse_login_client.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png",height: size.height*0.2,),
                  Center(
                    child: Text("Welcome Nurse!",style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),),
                  ),
                  SizedBox(height:size.height*0.04 ,),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TabBar(
                        labelStyle: TextStyle(fontSize: 16,color: Colors.white),
                        dividerHeight: 0,
                        unselectedLabelStyle: TextStyle(
                            fontSize: 16,color: Colors.black),
                        indicatorSize:TabBarIndicatorSize.tab ,
                        indicator: BoxDecoration(
                            color: Color(0XFF3D7AF5),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        tabs: [
                          Tab(text: "Client",),
                          Tab(text:"Nurse")
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(child:ClientRegisterPage()),
                        SingleChildScrollView(child: NurseRegisterLayout()),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}
