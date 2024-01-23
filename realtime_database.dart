import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:siuu/create_bottom.dart';
import 'package:siuu/update_bottom.dart';

class RealTimeDatabase extends StatefulWidget{
  const RealTimeDatabase({super.key});

  @override
  State<RealTimeDatabase> createState() => _RealTimeDatabaseState();
}
final databaseReference = FirebaseDatabase.instance.ref("footballers");
class _RealTimeDatabaseState extends State<RealTimeDatabase>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "MyData",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: FirebaseAnimatedList(query: databaseReference,
          itemBuilder: (context, snapshot, index, animation){
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(snapshot.child("name").value.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                  ),
                ),
                subtitle:
                  Text(snapshot.child("address").value.toString()),
                trailing: PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) =>[
                    //Update Data
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        onTap: (){
                          updateBottomSheet(context,
                              snapshot.child("name").value.toString(),
                              snapshot.child("id").value.toString(),
                              snapshot.child("address").value.toString());
                        },
                        leading: const Icon(Icons.edit),
                        title: const Text("Edit"),
                      ),
                    ),
                    //Delete Data
                    PopupMenuItem(
                      value: 2,
                      child: ListTile(
                        onTap: (){
                          databaseReference
                              .child(
                              snapshot.child('id').value.toString())
                              .remove();
                        },
                        leading: const Icon(Icons.delete),
                        title: const Text("Delete"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }))
        ],
      ),
      //Create Data
      floatingActionButton: FloatingActionButton(
        onPressed: () => createBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}