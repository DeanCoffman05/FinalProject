import { Address } from 'src/app/models/address';
import { AuthService } from './../../services/auth.service';
import { RestaurantService } from './../../services/restaurant.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Restaurant } from 'src/app/models/restaurant';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-restaurant',
  templateUrl: './restaurant.component.html',
  styleUrls: ['./restaurant.component.css'],
})
export class RestaurantComponent implements OnInit {
  restaurants: Restaurant[] = [];
  restaurantSearchs: Restaurant[] = [];
  newRestaurant: Restaurant = new Restaurant();
  editRestaurant: Restaurant | null = null;
  selected: Restaurant | null = null;
  currentUser: User = new User();
  address: Address = new Address();

  constructor(
    private restaurantService: RestaurantService,
    private authService: AuthService,
    private activatedRoute: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit() {
    console.log('RestaurantComponent initialized.');
    this.reload();
  }

  reload() {
    this.restaurantService.index().subscribe({
      next: (restaurants: Restaurant[]) => {
        console.log('Received restaurants:', restaurants);
        this.restaurants = restaurants;
      },
      error: (fail) => {
        console.error('RestaurantService.reload(): error getting restaurants');
        console.error(fail);
      },
    });
  }
  displayRestaurant(restaurant: any) {
    this.selected = restaurant;
  }
  displayList() {
    this.selected = null;
  }
  setEditRestaurant() {
    this.editRestaurant = Object.assign({}, this.selected);
  }
  updateRestaurant(updatedRestaurant: Restaurant, setSelected: boolean = true) {
    this.loggedInUser();
    this.restaurantService.updateRestaurant(updatedRestaurant).subscribe({
      next: (updateRestaurant) => {
        if (setSelected) {
          this.selected = updateRestaurant;
        }
        this.editRestaurant = null;
        this.reload();
      },
      error: (fail) => {
        console.error(
          'RestaurantComponent.updateRestaurant: error updating restaurant'
        );
        console.error(fail);
      },
    });
  }
  loggedInUser() {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.currentUser = user;
      },
      error: (fail) => {
        console.error(
          'RestaurantComponent.loggedInUser: error updating restaurant'
        );
        console.error(fail);
      },
    });
  }

  addRestaurant(newResta: Restaurant) {
    newResta.address = this.address;
    this.loggedInUser();
    this.restaurantService.create(newResta).subscribe({
      next: () => {
        this.newRestaurant = new Restaurant();
        this.reload();
      },
      error: (fail) => {
        console.error(
          'RestaurantComponent.createRestaurant: error updating restaurant'
        );
        console.error(fail);
      },
    });
  }

getCurrentRole(){
return this.authService.getCurrentRole();
}


}
