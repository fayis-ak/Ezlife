import 'package:demo_project/model/guestmodel.dart';
import 'package:demo_project/controller/helperprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class VisiterHistory extends StatefulWidget {
  const VisiterHistory({super.key});

  @override
  State<VisiterHistory> createState() => _VisiterHistoryState();
}

class _VisiterHistoryState extends State<VisiterHistory> {
  List<Map<String, String>> data = [
    {
      "name": "Shiva",
      "type": "Swigg",
      "room": "D-303",
      "img":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6iUVzhZCoi1gffBwqglkcayiWsNQDl-Ld3PZIDZGhEqqdljJeo4ocVt8dJGgEnkRIIa4&usqp=CAU"
    },
    {
      "name": "Raman",
      "type": "Uber",
      "room": "F-506",
      "img":
          "https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg"
    },
  ];
  TextEditingController _dateController = TextEditingController();
  DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Residents Contacts")),
        backgroundColor: Color.fromARGB(44, 24, 255, 216),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.0, left: 10, right: 10),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: _dateController,
                readOnly: true, // make it read-only to prevent manual input
                onTap: () {
                  _selectDate(context);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: Icon(Icons.search),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'dd/mm/yyyy', // optional, you can remove this
                ),
              ),
              // SizedBox(height: 30,),
              Expanded(child: Consumer<HelperProvider>(
                builder: (context, helper, child) {
                  return StreamBuilder(
                    stream: helper.getgestdata(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List<GuestModel> guest = [];

                      guest = snapshot.data!.docs.map((e) {
                        return GuestModel.fromjsone(
                            e.data() as Map<String, dynamic>);
                      }).toList();

                      if (snapshot.hasData) {
                        return guest.isEmpty
                            ? Center(
                                child: Text('no guest data'),
                              )
                            : ListView.builder(
                                itemCount: guest.length,
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
                                                        image: NetworkImage(
                                                  guest[index].image,
                                                ))),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 17.0, left: 10),
                                              child: Column(
                                                children: [
                                                  Text(
                                                      'Guest name ${guest[index].guestname}'),
                                                  Text(
                                                      'Flore no : ${guest[index].florenumber}'),
                                                  Text(
                                                      'Room no :${guest[index].roomnumber}')
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: SizedBox(
                                                width: 90,
                                                height: 40,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.red,
                                                        foregroundColor:
                                                            Colors.black,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero)),
                                                    onPressed: () {},
                                                    child: Text("OUT")),
                                              ),
                                            )
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() => _dateController.text = _dateFormat.format(picked));
    }
  }
}
