import'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/categoriesData.dart';
import 'package:onlineshop3/models/orderData.dart';
import 'package:onlineshop3/models/orderDetailsData.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/subCategories.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {

  final String uid;
  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection("users");
  final CollectionReference orderCollection = Firestore.instance.collection("orders");
  final CollectionReference orderDetailsCollection = Firestore.instance.collection("ordersDetails");
  final CollectionReference productCollection = Firestore.instance.collection('products');
  final CollectionReference CategoryQuery = Firestore.instance.collection('categories');
  final CollectionReference cartCollection = Firestore.instance.collection('cart');


  DatabaseService({this.uid});
  // getting logged in user

  getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print('printing uid');
    String user_id = user.uid;
    print(user.uid);
    return user.uid;
  }
  Future updateUserData (String username, String email, String gender, int phone_number) async {
    return await userCollection.document(uid).setData({
        "user_id" : uid,
        "usernane" : username,
        "email" : email,
        "gender" : gender,
        "phone_number": phone_number,
        "payment_method" : 'Mpesa',
        "credit_number" : null,
        "id_no": null,
        "address" : null,
        "country" : 'Kenya',
        "city" : 'Nyahururu',
        "date_entered" : DateTime.now()


    });
}
  Future createOrder (String orderId, String uid) async {
    print('creating order on database');
    return await orderCollection.document(orderId).setData({

      "customer_id" : uid,
      "order_id" :  orderId,
      "payment_id": null,
      "ship_date" : null,
      "required_date": null,
      "order_status" : 'processing',
      "paid": false,
      "payment_date" : null,
      "order_date" : DateTime.now()

    });
  }

  void Add_order_Details(String order_id,String product_id,String productName,String image, String category,double price, int quantity){
    final Query order = Firestore.instance
        .collection('orders').where("order_id", isEqualTo: order_id);
    order.getDocuments().then((snaps) {
      final String id_doc = snaps.documents[0].documentID;
      orderDetailsCollection.document().setData({
        'order_id': order_id,
        'productName' : productName,
        'product_id' : product_id,
        'category' : category,
        'price' : price,
        'quantity' : quantity,
        'image' : image
      });
    });
  }

   // Add a roduct t cart with a user id
  void AddToCart(String product_id,String productName,String image, String category,double price,String user_id, int quantity){
    print('printing usr again');
    print(getUser());
    var id = Uuid();
    String cartId = id.v1();
        cartCollection.document(cartId).setData({
          'user_id': user_id,
          'productName' : productName,
          'id' : product_id,
          'category' : category,
          'price' : price,
          'quantity' : quantity,
          'image' : image,
        });
  }

    // user list from snapshot

  List<UserData>_userListFromSnapsht(QuerySnapshot snapshot){

    return snapshot.documents.map((doc){

      return UserData(
        user_id: doc.data['user_id'] ?? uid,
        payment_method: doc.data['payment_method'] ?? null,
        phone_number: doc.data['phone_number'] ?? null,
        email: doc.data['email'] ?? null,
        city: doc.data['city'] ?? null,
        address: doc.data['address'] ?? null,
        country: doc.data['country'] ?? null,
        gender: doc.data['gender'] ?? null,
        id_no: doc.data['id_no'] ?? null,
        credit_number: doc.data['credit_number'] ?? null,
        names:  doc.data['usernane'] ?? 'Unable to load name',



      );
    }).toList();
  }
//product list from snapshot

  List<ProductsData> productListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
//      print(doc.data['images']);
      return ProductsData(
        producsId: doc.data['id'] ?? null,
        productName: doc.data['productName'] ?? 'unable to get name',
        productDescription: doc.data['description'] ?? 'unable to load description',
        productPrice: doc.data['price'] ?? '0',
        productsAvailable: doc.data['available'] ?? '0',
        productQuantity: doc.data['quantity'] ?? '0',
        productSize: doc.data['hasSize'] ?? '0',
        productRating: doc.data['hasRating'] ?? '0',
        producthaColor: doc.data['hasColor'] ?? 'colorless',
        producsCategory: doc.data['category'] ?? 'none',
        images: doc.data['images'] ?? 'unable to load images',


      );
    }).toList();

  }

  List<CategoriesData>_categoryListFromSnapsht(QuerySnapshot snapshot){

    return snapshot.documents.map((doc){
      print(doc.data['category']);
      return CategoriesData(
          categoryName: doc.data['category'] ?? 'Unable to get name',
          categoryDescription: doc.data['description'],
          categoryImage: doc.data['image']

      );
    }).toList();
  }
  List<OrderDetailsData>orderDetaisListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.documents.map((doc){
      print('again');

      try{
        return OrderDetailsData(
          order_id: doc.data['order_id'] ?? 'unable to load order id',
          product_id: doc.data['product_id']  ?? 'unable to load product id',
          image: doc.data['image'] ?? 'unable to load image',
          quantity: doc.data['quantity'] ?? 0,
          productName: doc.data['productName'] ?? 'unable to load product name',
          category: doc.data['category'] ?? 'unable to load category',
          price: doc.data['price'] ?? 0

        );
      } catch(e){
        print(e.toString());
        return null;

      }

    }).toList();
  }
  List<OrderData>orderListFromSnapsht(QuerySnapshot snapshot){

    return snapshot.documents.map((doc){
      print('again');

      try{
        return OrderData(
          order_id: doc.data['order_id'],
          user_id: doc.data['customer_id'],
          payment_id: doc.data['payment_id'] ?? null,
          paid: doc.data['paid'] ?? false,
          ship_date: doc.data['ship_date'] ?? null,
          order_status: doc.data['order_status'] ?? null,
          required_date: doc.data['required_date'] ?? null,
          status: doc.data['status']
        );
      } catch(e){
        print(e.toString());
        return null;

      }

    }).toList();
  }

  List<CartData>_cartListFromSnapsht(QuerySnapshot snapshot){

    return snapshot.documents.map((doc){
      print('again');

       try{
         return CartData(
           productId: doc.data['id'] ,
           user_id: doc.data['user_id'],
           quantity: doc.data['quantity'] ?? 0,
           price: doc.data['price'] ?? null,
           productame: doc.data['productName'] ?? 'unable to get name',
           category: doc.data['category'] ?? 'unable to lad category',
           image: doc.data['image'] ?? 'unable to lad image',

         );
       } catch(e){
         print(e.toString());
         return null;

       }

    }).toList();
  }

  //sub category data
  List<SubCategoryData>_subcategoryListFromSnapsht(QuerySnapshot snapshot){

    return snapshot.documents.map((doc){
      print(doc.data['category']);
      return SubCategoryData(
        subCategoryName: doc.data['subCategory'] ?? 'Unable to get name',

      );
    }).toList();
  }
 // get user stream

Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
}

  Stream<List<UserData>>  usersById(String user_id){

    return Firestore.instance.collection('users').where("user_id", isEqualTo: user_id).snapshots()
        .map(_userListFromSnapsht);
  }

  Stream<List<ProductsData>> get products {
    return productCollection.snapshots()
        .map(productListFromSnapshot);
  }

  Stream<List<ProductsData>>  productsByCategory(String category) {
    if(category == null){
      return productCollection.snapshots()
          .map(productListFromSnapshot);
    }else{
      return Firestore.instance.collection('products').where("category", isEqualTo: category).snapshots()
          .map(productListFromSnapshot);
    }

  }

  //getting products by id

  Stream<List<ProductsData>>  productsById(String productId) {
    try{
      print('proxxcjd to qee');
      print(productId);
      Firestore.instance.collection('products').where("id", isEqualTo: productId).snapshots()
          .map(productListFromSnapshot);
    }catch(e){
      print(e.toString());
    }
  }

  Stream<List<ProductsData>>  get recentProducts {
    try{
      Firestore.instance.collection('products').limit(4).snapshots()
          .map(productListFromSnapshot);
    }catch(e){
      print(e.toString());
    }


  }
  Stream<List<CategoriesData>> get categoriesList {
    return CategoryQuery.snapshots()
        .map(_categoryListFromSnapsht);
  }

  Stream<List<SubCategoryData>> subcategories(String category){
    final Query available_categories = Firestore.instance.collection('categories').where("category", isEqualTo: category);


    available_categories.getDocuments().then((snaps) {
      final String id_doc = snaps.documents[0].documentID;
      print(id_doc);
      final CollectionReference subCollection = Firestore.instance
          .collection('categories')
          .document(id_doc)
          .collection(category);
      return  subCollection.snapshots().map(_subcategoryListFromSnapsht);

    });
  }
  // get cart data
  Stream<List<CartData>> cartProducts(String uid) {
      print('this is the uid we use for query');
      print(uid);
      return Firestore.instance.collection('cart').where("user_id", isEqualTo: uid).snapshots()
          .map(_cartListFromSnapsht);
  }
  Stream<List<CartData>> cartProductsByProductId(String product_id) {
    print('this is the uid we use for query');
    print(uid);
    return Firestore.instance.collection('cart').where("id", isEqualTo: product_id).snapshots()
        .map(_cartListFromSnapsht);
  }

  Stream<List<OrderData>>  ordersByOID(String order_id) {
    return Firestore.instance.collection('orders').where('order_id', isEqualTo: order_id).snapshots()
        .map(orderListFromSnapsht);

  }

  Stream<List<OrderData>>  ordersByUID(String user_id) {
    return Firestore.instance.collection('orders').where('customer_id', isEqualTo: user_id).snapshots()
        .map(orderListFromSnapsht);}


  Stream<List<OrderDetailsData>>  ordersDetails(String order_id) {
    print(order_id);
    print('order_id');
    return Firestore.instance.collection('ordersDetails').where('order_id', isEqualTo: order_id).snapshots()
        .map(orderDetaisListFromSnapshot);
  }
}