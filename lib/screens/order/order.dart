import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/card.dart';
import 'package:nexacloth/components/card/cart_item_card.dart';
import 'package:nexacloth/components/header/back_header.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> orderTabs = const [
    Tab(text: 'Active'),
    Tab(text: 'Completed'),
    Tab(text: 'Cancelled'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: orderTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildOrderListView(String status) {
    // Placeholder for each tab content, replace with real order list/filter
    if (status == 'Active') {
      return buildActiveOrderCard(status);
    }
    if (status == 'Completed') {
      return buildActiveOrderCard(status);
    }
    if (status == 'Cancelled') {
      return buildActiveOrderCard(status);
    }
    return Center(child: Text('$status tab check'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            BackHeader(title: 'Orders'),
            Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                tabs: orderTabs,
                labelColor: CustomAppColor.black,
                unselectedLabelColor: Colors.black,
                indicatorColor: Theme.of(context).primaryColor,
                dividerColor: Colors.transparent,
                isScrollable: true, // Enable scrollable for start alignment
                tabAlignment:
                    TabAlignment.start, // Start align tabs if supported
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOrderListView('Active'),
                  _buildOrderListView('Completed'),
                  _buildOrderListView('Cancelled'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActiveOrderCard(String status) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) => Column(
              children: [
                CartItemCard(
                  imageUrl: 'https://picsum.photos/200/300',
                  productName: 'Product Name',
                  description: 'Rolex Watch',
                  price: '\$100',
                  quantity: 1,
                  onDelete: () {},
                  onDecrease: () {},
                  onIncrease: () {},
                  showTrackOrder: true,
                ),
                if (index != 9) SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
