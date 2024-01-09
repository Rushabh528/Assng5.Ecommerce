import 'package:ecommerce/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Provider1(),
      child: MaterialApp(
        title: 'Ecommerce',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<Provider1>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("CATALOG"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                }),
          ),
        ],
      ),
      body: Consumer<Provider1>(
        builder: (BuildContext context, Provider1 value, Widget? child) {
          return ListView(
            children: [
              shop("Apple(1 kg)", "\$", 5,
                  "http://images6.fanpop.com/image/photos/34500000/Red-Apples-3-red-34590404-1920-1200.jpg"),
              shop("Amazon Fire Stick", "\$", 50,
                  "https://s3.amazonaws.com/images.ecwid.com/images/1107006/2327147861.jpg"),
              shop("IPhone 13 Pro Max", "\$", 1099,
                  "https://tse2.mm.bing.net/th?id=OIP.VZTYcMzlnel-_ptS5jygsgHaEK&pid=Api&P=0&h=180"),
              shop("Hand Gripper", "\$", 9,
                  "https://tse4.mm.bing.net/th?id=OIP.lOmzVcP_SsmRvLpMzSK4xgHaHa&pid=Api&P=0&h=180"),
              shop("Wireless Mouse", "\$", 15,
                  "https://tse1.mm.bing.net/th?id=OIP.erW-hH-pP-CJBtLmNsu8NgHaHa&pid=Api&P=0&h=180"),
              shop("Chocolates Pack", "\$", 10,
                  "https://tse4.mm.bing.net/th?id=OIP.j0ETHcrTqRggJAIDfVF9BwHaHa&pid=Api&P=0&h=180"),
              shop("Boat Airdopes", "\$", 19,
                  "https://tse4.mm.bing.net/th?id=OIP.um6M4su5vGg_ash3YLd1UQHaHT&pid=Api&P=0&h=180"),
              shop("Smart Watch", "\$", 60,
                  "https://tse4.mm.bing.net/th?id=OIP.z8FnZH-EdzeOPJLvW86V_QHaHa&pid=Api&P=0&h=180"),
              shop("Mountain bike", "\$", 100,
                  "https://tse2.mm.bing.net/th?id=OIP._xrU9JNsTV9gGVD0cCTsYwHaFj&pid=Api&P=0&h=180"),
              shop("Macbook Air M2", "\$", 1499,
                  "https://tse1.mm.bing.net/th?id=OIP.hM2iTMIWz7iRr_RPxdeqNAHaFj&pid=Api&P=0&h=180"),
            ],
          );
        },
      ),
    );
  }

  ListTile shop(String name, String dollar, int price, String image) {
    final provider = Provider.of<Provider1>(context, listen: false);

    return ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
          )),
      trailing: IconButton(
          onPressed: () {
            provider.add1(name);
            provider.addprice(price);
            provider.sum(price);
          },
          icon: (provider.items.contains(name))
              ? const Text("Remove from cart")
              : const Text("ADD")),
      title: Text(name),
      subtitle: Text("$dollar$price"),
    );
  }
}

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Provider1>(context, listen: true);

    if (provider.items.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          backgroundColor: const Color.fromARGB(68, 12, 191, 241),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in provider.items)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("• $item"),
                ),
              const Center(
                child: Text(
                  "Respective prices:",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              for (var price in provider.prices)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("• \$$price"),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      color: Colors.blue.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Total: \$${provider.total}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 40,
                            )),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        provider.items.clear();
                        provider.prices.clear();
                        provider.nfy();
                        provider.t0();
                        const snackBar =
                            SnackBar(content: Text("Successfully Purchased!!"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Text("Buy"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          backgroundColor: const Color.fromARGB(68, 12, 191, 241),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: const Center(
          child: Center(
            child: (Text(
              "Cart is empty!",
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      );
    }
  }
}
