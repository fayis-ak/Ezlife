import 'package:demo_project/model/securitymodel.dart';
import 'package:demo_project/controller/helperprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Securitycontacts extends StatefulWidget {
  const Securitycontacts({super.key});

  @override
  State<Securitycontacts> createState() => _ContactPageState();
}

class _ContactPageState extends State<Securitycontacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Security Contacts")),
          backgroundColor: Color.fromARGB(44, 24, 255, 216),
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
                child: Column(children: [
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "location",
                        prefixIcon: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  Expanded(child: Consumer<HelperProvider>(
                    builder: (context, helper, child) {
                      return StreamBuilder(
                        stream: helper.getSecurities(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<Securitymodel> list = [];

                          list = snapshot.data!.docs.map((e) {
                            return Securitymodel.fromjsone(
                                e.data() as Map<String, dynamic>);
                          }).toList();

                          if (snapshot.hasData) {
                            return list.isEmpty
                                ? Center(
                                    child: Text('no data'),
                                  )
                                : ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Card(
                                          child: Container(
                                            width: double.infinity,
                                            height: 100,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                      list[index]
                                                          .securityprofile,
                                                    ))),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 17.0, left: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(list[index]
                                                          .securityEmail),
                                                      Text(' number'),
                                                      Text('location')
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 100,
                                                  ),
                                                  child: CircleAvatar(
                                                    radius: 25,
                                                    backgroundColor:
                                                        Colors.green,
                                                    child: Icon(Icons.phone),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                          }
                          return Container();
                        },
                      );
                    },
                  )),
                ]))));
  }
}
