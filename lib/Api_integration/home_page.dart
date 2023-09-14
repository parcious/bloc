import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'model/user_model.dart';
import 'repo/repositories.dart';

import 'bloc/user_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(),
      )..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state is UserLoadedState) {
            List<Datum> userList = state.users.data;
            return Column(
              children: [
                SizedBox(height: 35),
                Container(
                  margin: EdgeInsets.only(left: 280),
                  child: Container(
                    height: 40,
                    width: 40,
                    //child: Image.NetworkImage(userList[index].avatar.toString()),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://reqres.in/img/faces/9-image.jpg'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          "Providers",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (_, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            child: Card(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text(
                                      '${userList[index].firstName} ${userList[index].lastName}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  subtitle: Text(
                                    '${userList[index].email}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  trailing: Container(
                                    width: 65,
                                    height: 30,
                                    // color: Colors.grey.shade300,
                                    child: const Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.person,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' offline ',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    //child: Image.NetworkImage(userList[index].avatar.toString()),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            userList[index].avatar.toString()),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                )));
                      }),
                ),
                Container(
                  height: 90,
                  width: 1000,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)),
                    color: Color.fromARGB(255, 217, 229, 249),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(children: [
                      Column(
                        children: [Icon(Icons.weekend), Text('waiting')],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [Icon(Icons.dashboard), Text('dashboard')],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [Icon(Icons.people), Text('providers')],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [Icon(Icons.history), Text('history')],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [Icon(Icons.settings), Text('setting')],
                      ),
                    ]),
                  ),
                )
              ],
            );
          }
          if (state is UserErrorState) {
            return const Center(
              child: Text(
                "Error ",
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
