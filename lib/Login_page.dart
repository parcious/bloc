import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_apk/Api_integration/bloc/login_bloc.dart';
import 'package:login_apk/Api_integration/home_page.dart';
import 'package:login_apk/features/home/ui/home.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginBloc _bloc = LoginBloc();
  bool isLoading = false;

  login() async {
    _bloc.add(LoginEvent(
      username: usernameController.text,
      password: passwordController.text,
    ));
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<LoginBloc, LoginState>(
        bloc: _bloc,
        listener: (context, state) {
          // TODO: implement listener a
          if (state is LoginSuccessState) {
            isLoading = false;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          } else if (state is LoginErrorState) {
            isLoading = false;
            Text(
              state.error,
              style: TextStyle(color: Colors.red),
            );
          } else if (state is LoginLoadingState) {
            isLoading = true;
          }
        },
        child: Scaffold(
            body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Container(
              child: BlocBuilder<LoginBloc, LoginState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width,
                          height: height * 0.45,
                          child: Image.asset('assets/images/login.jpg',
                              fit: BoxFit.fill),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Container(
                                // margin: EdgeInsets.only(left: 5, top: 30),
                                child: Text(
                              "Username",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            )),
                          ],
                        ),
                        BlocProvider(
                          create: (context) => LoginBloc(),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    suffixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20))
                                    // icon: Icon(Icons.person),

                                    )),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Container(
                                // margin: EdgeInsets.only(left: 5, top: 30),
                                child: Text(
                              "Password ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            )),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'password',
                                  suffixIcon: Icon(Icons.password),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))
                                  // icon: Icon(Icons.security),
                                  )),
                        ),
                        SizedBox(height: 30.0),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                child: Text(
                                  'State Bloc',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                },
                              ),
                              BlocProvider(
                                create: (context) => LoginBloc(),
                                child: ElevatedButton(
                                    onPressed: () {
                                      login();
                                    },
                                    child: isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text('LogIn',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Second()));
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Don\'t have an account',
                              children: [
                                TextSpan(
                                  text: 'Signup',
                                  style: TextStyle(color: Color(0xffEE7B23)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        )));
  }
}
