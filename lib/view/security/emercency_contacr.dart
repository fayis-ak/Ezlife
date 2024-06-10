import 'package:demo_project/controller/helperprovider.dart';
import 'package:demo_project/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmercencyContact extends StatelessWidget {
  EmercencyContact({super.key});

  final emercen = {
    'name': 'Police',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Emergency")),
        backgroundColor: Color.fromARGB(44, 24, 255, 216),
      ),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Card(
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                    'list[index].securityprofile',
                                  ))),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 17.0, left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('d'),
                                    Text(' number'),
                                    Text('location')
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 100,
                                ),
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
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: ResHelper.h(context) * .050,
                    );
                  },
                  itemCount: 2)
            ],
          )),
    );
    ;
  }
}
