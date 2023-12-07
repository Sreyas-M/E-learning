import 'package:elearning/model/replyViewModel.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/provider/replyViewprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Replies extends StatelessWidget {
  const Replies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Replies',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<ReplyModel>(
        future:Provider.of<ReplyViewProvider>(context, listen: false).repliesfromAdmin(userId: Provider.of<LoginProvider>(context,listen: false).user_id),
        builder: (BuildContext context, AsyncSnapshot<ReplyModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
            return Center(
              child: Text("No Replies available"),
            );
          }

            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(
                          snapshot.data!.data![index].reply!,
                        style:GoogleFonts.aBeeZee(fontSize: 25)
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Q.${snapshot.data!.data![index].queries! ?? "No data"}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Provider.of<ReplyViewProvider>(context, listen: false).removeReply(id: snapshot.data!.data![index].qId!);
                        },
                        child: Text("Clear"),
                      ),
                    ),
                  );
                },
              );
            } else {
            return Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
