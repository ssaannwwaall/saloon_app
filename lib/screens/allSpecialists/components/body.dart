import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/components/item_card.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/models/specialist.dart';
import 'package:saloon_app/providers/specialistProvider.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/editSpecialist/edit_specialist_screen.dart';
import 'package:saloon_app/services/specialist.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future <List<Specialist>> allSpecialists;

  SpecialistService specialistService = SpecialistService();
  List<Specialist> specialists = [];
  Future<List<Specialist>> getAllSpecialists () async {
    specialists =  await specialistService.getAllSpecialists();
    return specialists;
  }

   @override
  initState() {
    super.initState();
    allSpecialists = getAllSpecialists();
    print("All Specialists");
    print(allSpecialists); 
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    var specialistsProvider = Provider.of<SpecialistsProvider>(context);

    return FutureBuilder(
      future:getAllSpecialists(),
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
         if (snapshot.data == null) {
            return Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            );
          } else {
                  return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: (itemWidth / itemHeight),),
          itemCount: snapshot.data.length,
          
          itemBuilder: (context, index) {
        SpecialistService specialistService = SpecialistService();
        return ItemCard(
          image:snapshot.data[index].image, 
          title:snapshot.data[index].firstName, 
          edit: () => {
          Navigator.pushNamed(
              context, EditSpecialistsScreen.routeName,
              arguments: SpecialistDetailsArguments(
              specialist: snapshot.data[index])),
          },
          delete: (){
            showAlertDialog(context,snapshot.data[index].id);
          }
          
        );
        
          }),
        
        
        
      );
             }       }
    );
  }
 showAlertDialog(BuildContext context, id ) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget okButton = TextButton(
    child: Text("Ok"),
    onPressed:  () {
       specialistService.removeSpecialist(id);
             Navigator.pushNamed(
              context, AllSpecialistScreen.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Text("Do you want to delete?"),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
}
