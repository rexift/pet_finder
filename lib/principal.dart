import 'package:flutter/material.dart';
import 'package:pet_finder/data.dart';
import 'package:pet_finder/pet_widget.dart';
import 'package:pet_finder/category_list.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {

  List<Pet> pets = getPetList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.sort,
          color: Colors.grey[800],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications_none,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Find Your",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Lovely pet in anywhere",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 24,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 0, 
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.only(right: 30,),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 16.0, left: 24.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "Pet Category",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),

                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),

                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildPetCategory(Category.HAMSTER, "56", Colors.orange[200], Icons.mouse),
                      buildPetCategory(Category.CAT, "210", Colors.blue[200], Icons.mouse),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildPetCategory(Category.BUNNY, "90", Colors.green[200], Icons.mouse),
                      buildPetCategory(Category.DOG, "340", Colors.red[200], Icons.mouse),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "Newest Pet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),

                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),

                ],
              ),
            ),

            Container(
              height: 280,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildNewestPet(),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "Vets Near You",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),

                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),

                ],
              ),
            ),

            Container(
              height: 130,
              child: PageView(
                physics: BouncingScrollPhysics(),
                children: [
                  buildVet("assets/images/vets/vet_0.png", "Animal Emergency", "(369) 133-8956"),
                  buildVet("assets/images/vets/vet_1.png", "Artemis Veterinary", "(706) 722-9159"),
                  buildVet("assets/images/vets/vet_2.png", "Big Lake Vet Hospital", "(598) 4986-9532"),
                  buildVet("assets/images/vets/vet_3.png", "Veterinary Medical Center", "(33) 8974-559-555"),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildPetCategory(Category category, String total, Color color, IconData iconData){
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryList(category: category)),
          );
        },
        child: Container(
          height: 70,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[200],
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [

              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.5),
                ),
              ),

              SizedBox(
                width: 12,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    category == Category.HAMSTER ? "Hamsters" : category == Category.CAT ? "Cats" : category == Category.BUNNY ? "Bunnies" : "Dogs",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Total of " + total,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildNewestPet(){
    List<Widget> list = [];
    for (var i = 0; i < pets.length; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            /* Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PetDetail(pet: pets[i])),
            ); */
          },
          child: buildPet(pets[i], i)
        )
      );
    }
    return list;
  }

  Widget buildVet(String imageUrl, String name, String phone){
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 4),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 1,
          color: Colors.grey[300],
        ),
      ),
      child: Row(
        children: [

          Container(
            height: 98,
            width: 98,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(
            width: 16,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                name,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 8,
              ),

              Row(
                children: [

                  Icon(
                    Icons.phone,
                    color: Colors.grey[800],
                  ),

                  SizedBox(
                    width: 8,
                  ),

                  Text(
                    phone,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),

            ],
          ),

        ],
      ),
    );
  }

}