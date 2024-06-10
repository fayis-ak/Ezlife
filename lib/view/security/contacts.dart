import 'package:demo_project/model/usermodel.dart';
import 'package:demo_project/controller/helperprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Map<String, String>> data = [
    {
      "name": "Shiva",
      "num": "9754567898",
      "room": "D-303",
      "img":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6iUVzhZCoi1gffBwqglkcayiWsNQDl-Ld3PZIDZGhEqqdljJeo4ocVt8dJGgEnkRIIa4&usqp=CAU"
    },
    {
      "name": "Raman",
      "num": "8646789006",
      "room": "F-506",
      "img":
          "https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Residents Contacts")),
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
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Flat No",
                    prefixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              Expanded(child: Consumer<HelperProvider>(
                builder: (context, helper, child) {
                  return StreamBuilder(
                    stream: helper.getuser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List<Usermodel> list = [];

                      list = snapshot.data!.docs.map((e) {
                        return Usermodel.fromjsone(
                            e.data() as Map<String, dynamic>);
                      }).toList();

                      if (snapshot.hasData) {
                        return list.isEmpty
                            ? Center(
                                child: Text('no user'),
                              )
                            : ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Card(
                                      child: Container(
                                        width: double.infinity,
                                        height: 100,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(list[
                                                                index]
                                                            .userprofileimg))),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 17.0, left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(list[index].username),
                                                  Text(list[index].phonenumber),
                                                  Text(list[index].rooomnumber)
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 120),
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor: Colors.green,
                                                child: Icon(Icons.phone),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                      }
                      return Container();
                    },
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
