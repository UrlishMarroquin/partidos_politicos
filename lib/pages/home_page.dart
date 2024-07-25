import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection("users");
  CollectionReference candidatesReference =
      FirebaseFirestore.instance.collection("candidates");      

  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      appBar: AppBar(
        title: const Text("App de Votaciones"),
      ),
      body: StreamBuilder(
        stream: candidatesReference.snapshots(),
        // initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot userCollection = snapshot.data;
            List<QueryDocumentSnapshot> docs = userCollection.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(docs[index]["urlImage"], height: 40, width: 40,),
                  title: Text(docs[index]["nombrePartido"]),
                  subtitle: Text(docs[index]["representante"]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [            
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle_sharp,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          candidatesReference.doc(docs[index].id).update(
                            {
                              "nVotos": docs[index]["nVotos"] + 1,
                            },
                          );
                        },
                      ), 
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle_sharp,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          if(docs[index]["nVotos"] > 0){
                            candidatesReference.doc(docs[index].id).update(
                              {
                                "nVotos": docs[index]["nVotos"] - 1,
                              },
                            );  
                          }
                        },
                      ),                          
                      Text(
                        "#Votos ${docs[index]["nVotos"]}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        )
                      ),                                     
                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
