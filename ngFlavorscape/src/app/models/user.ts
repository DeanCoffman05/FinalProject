import { Address } from "./address";

export class User {
  id: number;
  username: string;
  password: string;
  firstName: String;
  lastName: String;
  email: string;
  role: string;
  enabled: boolean;
  imageUrl: string;
  aboutMe: string;
  address: Address;

  constructor(
    id: number = 0,
    username: string = '',
    password: string = '',
    firstName: String = '',
    lastName: String = '',
    email:  string = '',
    role: string = '',
    enabled: boolean = false,
    imageUrl: string = '',
    aboutMe: string = '',
    address: Address = new Address()
  ){
    this.id = id;
    this.username = username;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.role = role;
    this.enabled = enabled;
    this.imageUrl = imageUrl;
    this.aboutMe = aboutMe;
    this.address = address;
  }

}
