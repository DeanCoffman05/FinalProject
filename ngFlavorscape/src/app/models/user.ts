import { Address } from "./address";

export class User {
  id: number;
  username: string;
  password: string;
  firstname: String;
  lastname: String;
  email: string;
  role: string;
  enabled: boolean;
  address: Address;

  constructor(
    id: number = 0,
    username: string = '',
    password: string = '',
    firstname: String = '',
    lastname: String = '',
    email:  string = '',
    role: string = '',
    enabled: boolean = false,
    address: Address = new Address()
  ){
    this.id = id;
    this.username = username;
    this.password = password;
    this.firstname = firstname;
    this.lastname = lastname;
    this.email = email;
    this.role = role;
    this.enabled = enabled;
    this.address = address;
  }

}
