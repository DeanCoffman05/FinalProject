import { Address } from "./address";
import { Menu } from "./menu";

export class Restaurant {
  id: number;
  name: String;
  enabled: boolean;
  restaurantUrl: string
  imageUrl: string;
  description: string;
  phoneNumber: string;
  address: Address;
  menus: Menu [];

  constructor(
    id: number = 0,
    name: string = '',
    enabled: boolean = false,
    restaurantUrl: string = '',
    imageUrl: string = '',
    description: string = '',
    phoneNumber: string = '',
    address: Address = new Address(),
    menus: Menu [] = []
  ){
    this.id = id;
    this.name = name;
    this.enabled = enabled;
    this.restaurantUrl= restaurantUrl;
    this.imageUrl = imageUrl;
    this.description = description;
    this.phoneNumber = phoneNumber;
    this.address = address;
    this.menus = menus;
  }
}
