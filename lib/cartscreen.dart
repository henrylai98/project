import 'package:flutter/material.dart';
import 'package:comforrtzone2020/user.dart';
import 'package:comforrtzone2020/orderdetailscreen.dart';

class CartScreen extends StatefulWidget {
  final User user;

  const CartScreen({Key key, this.user}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How we can help you?'),
      ),
      body: ListView(
        controller: controller,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Our home services",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ServicesCard(
                        image: "assets/cart.png",
                        title: "Basic Housekeeping",
                        isActive: true,
                        press: () {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){return OrderDetailScreen();}));},
                      ),
                      ServicesCard(
                        image: "assets/spring.png",
                        title: "Spring Cleaning",
                        press: () {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){return OrderDetailScreen();}));},
                      ),
                      ServicesCard(
                        image: "assets/iron.png",
                        title: "Premium Ironing",
                        press: () {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){return OrderDetailScreen();}));},
                      ),
                      
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Need a helping hand?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ActivityCard(
                  text: "Kitchen Helper",
                  press: () {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {return OrderDetailScreen();}));},
                ),
                ActivityCard(
                  text: "Event Assistance",
                  press: () {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){return OrderDetailScreen();}));},
                ),
                ActivityCard(
                  text: "Packing/Unpacking",
                  press: () {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){return OrderDetailScreen();}));},
                ),
                ActivityCard(
                  text: "Others",
                  press: () {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){return OrderDetailScreen();}));},
                ),
                SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String text;
  final Function press;
  const ActivityCard({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 50,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 50,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServicesCard extends StatelessWidget {
  final String image;
  final String title;
  final Function press;
  final bool isActive;
  const ServicesCard({
    Key key,
    this.image,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Colors.brown,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: Colors.brown,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image, height: 90),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
