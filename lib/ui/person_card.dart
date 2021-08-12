import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String username;
  final String name;
  final String email;
  const PersonCard({Key key, this.username, this.name, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(username),
           ),
           Text(name),
           Text(email),
           SizedBox(height: 6,),
         ],
        ),


      ),
    );
  }
}

/*
return ListTile(
      leading: CircleAvatar(
        child: Text(username),
      ),
      title: Text(name),
      subtitle: Text(email),
    );
 */