import 'package:exchange/features/domain/entities/coin_entity.dart';

class CoinModel extends Coin {
  const CoinModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.image,
    required super.currentPrice,
    required super.priceChange,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      priceChange: (json['price_change_percentage_24h'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'symbol': symbol, 'name': name, 'image': image, 'current_price': currentPrice, 'price_change_percentage_24h': priceChange};
  }

  Coin toCoin() {
    return Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, priceChange: priceChange);
  }
}
