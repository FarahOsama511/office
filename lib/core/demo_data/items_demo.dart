import '../../features/Home/data/models/item_model.dart';

class ItemsDemoData {
  static List<ItemModel> getItems() {
    return [
      ItemModel(
        id: "1",
        name: "قهوة تركية",
        availability: "available",
        image:
            "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500",
      ),
      ItemModel(
        id: "2",
        name: "قهوة أمريكية",
        availability: "available",
        image:
            "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=500",
      ),
      ItemModel(
        id: "3",
        name: "كابتشينو",
        availability: "available",
        image:
            "https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=500",
      ),
      ItemModel(
        id: "4",
        name: "لاتيه",
        availability: "available",
        image:
            "https://images.unsplash.com/photo-1561882468-9110e03e0f78?w=500",
      ),
      ItemModel(
        id: "5",
        name: "اسبريسو",
        availability: "available",
        image:
            "https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=500",
      ),

      ItemModel(
        id: "7",
        name: "شاي بالنعناع",
        availability: "available",
        image:
            "https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=500",
      ),
      ItemModel(
        id: "8",
        name: "قهوة باردة",
        availability: "available",
        image:
            "https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?w=500",
      ),
    ];
  }
}
