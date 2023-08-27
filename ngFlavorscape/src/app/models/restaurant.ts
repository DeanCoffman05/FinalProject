import { Address } from "./address";

export class Restaurant {
  id: number;
  name: String;
  enabled: boolean;
  restaurantUrl: string
  imageUrl: string;
  description: string;
  phoneNumber: string;
  address: Address;

  constructor(
    id: number = 0,
    name: string = '',
    enabled: boolean = false,
    restaurantUrl: string = '',
    imageUrl: string = '',
    description: string = '',
    phoneNumber: string = '',
    address: Address = new Address()
  ){
    this.id = id;
    this.name = name;
    this.enabled = enabled;
    this.restaurantUrl= restaurantUrl;
    this.imageUrl = imageUrl;
    this.description = description;
    this.phoneNumber = phoneNumber;
    this.address = address;
  }
}
