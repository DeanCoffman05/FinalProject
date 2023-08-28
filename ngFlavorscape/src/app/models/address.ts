export class Address {
  id: number;
  street: string;
  street2: string;
  city: string;
  state: string;
  zipcode: number;
  latitude: number;
  longitude: number;

  constructor(
  id: number = 0,
  street: string = '',
  street2: string = '',
  city: string = '',
  state: string = '',
  zipcode: number = 0,
  latitude: number = 0,
  longitude: number = 0
  ) {
    this.id = id;
    this.street = street;
    this.street2 = street2;
    this.city = city;
    this.state = state;
    this.zipcode = zipcode;
    this.latitude = latitude;
    this.longitude = longitude;

  }
}
