// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/screens/homepage/widgets/iconrow.dart';
import 'package:machine_test/screens/homepage/widgets/images_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        label: const Text(
          'Chat',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        icon: Image.asset(
          'assets/icons/chat.png',
          height: 30,
          width: 30,
          color: Colors.white,
        ),
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 1)
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey,
                  //     blurRadius: 7,
                  //     spreadRadius: 1,
                  //     offset: Offset(2,3),
                  //   ),
                  // ],
                  ),
              child: Padding(
                padding:
                    const EdgeInsets.all(8.0), // Add padding around the Row
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.menu),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[500]!.withOpacity(0.2),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/logo.jpeg',
                                height: 30,
                              ),
                            ),

                            hintText: 'Search Here',
                            suffixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide
                                    .none), // Add border for better visibility
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.notifications_none_outlined),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const ImageCarosel(),
                    // const SizedBox(height: 10,),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadiusDirectional.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  const Color(0xFF0000FF).withOpacity(0.45),
                                  const Color(0xFF0000FF).withOpacity(0.55),
                                  const Color(0xFF0000FF).withOpacity(0.57),
                                  const Color(0xFF0000FF).withOpacity(0.60),

                                  // Colors.transparent,
                                ])),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'KYC Pending',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'You need to provide the required',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'documents for your account activation.',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.white))),
                                child: const Text(
                                  'Click Here',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IconRow(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildBlogView()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBlogView() {
    List<Map<String, dynamic>> blogData = [
      {
        'imagePath': 'assets/images/nokia.webp',
        'title': '₹',
        'description':
            'Nokia 8.1(iron,64GB)',
            'offers':'12% off'
      },
      {
        'imagePath': 'assets/images/oneplus.webp',
        'title': '₹',
        'description':
            "OnePlus NordCE2 Lite(Saphire Blue,128GB)",
                        'offers':'50% off'

      },
      {
        'imagePath': 'assets/images/realme.webp',
        'title': '₹',
        'description':
            'Redmi 13C 5G (6GB RAM, 128GB, Startrail Silver)',
                        'offers':'34% off'

      },
      {
        'imagePath': 'assets/images/redmi.webp',
        'title': '₹',
        'description':
            'OPPO A38 (Glowing Black, 128 GB)  (4 GB RAM)#JustHere',
                        'offers':'24% off'

      },
      {
        'imagePath': 'assets/images/oppo.jpeg',
        'title': '₹',
        'description':
            'realme 12x 5G (Twilight Purple, 128 GB)  (4 GB RAM)',
                        'offers':'15% off'

      },
    ];

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          
          gradient: LinearGradient(colors: 
          [
            Color.fromRGBO(31, 200, 247, 0.929),
          Color.fromRGBO(141, 209, 228, 0.922)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter)
          
         
          
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "EXCLUSIVE FOR YOU",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to view all blogs
                    },
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 30,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 350,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: blogData.length,
                itemBuilder: (context, index) {
                  final data = blogData[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                    
                      width: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children:[Padding(
                              padding:   const EdgeInsets.only(top: 28,left: 8,right: 8),
                              child: Center(
                                child: Image.asset(
                                  data['imagePath'],
                                  width: 200,
                                  height: 225,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 1,
                              child: Container(
                              height: 30,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green
                              ),
                              child: Center(child: Text(data['offers'],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))))]
                          ),
                          // const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(top: 5,left: 8,right: 8),
                            child: Text(
                              data['description'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
