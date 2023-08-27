import { AuthService } from './../../services/auth.service';
import { RestaurantService } from './../../services/restaurant.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Restaurant } from 'src/app/models/restaurant';


@Component({
  selector: 'app-restaurant',
  templateUrl: './restaurant.component.html',
  styleUrls: ['./restaurant.component.css']
})
export class RestaurantComponent implements OnInit {
  restaurants: Restaurant[] = [];
  restaurantSearchs: Restaurant[] = [];
  newRestaurant: Restaurant = new Restaurant();
  editRestaurant: Restaurant | null = null;
  selected: Restaurant | null = null;


  constructor(
    private restaurantService: RestaurantService,
    private authService: AuthService,
    private activatedRoute: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit() {
    console.log('RestaurantComponent initialized.');
    this.reload();
    }

  reload() {
    this.restaurantService.index().subscribe ({
      next:(restaurants: Restaurant[]) => {
        console.log('Received restaurants:', restaurants);
        this.restaurants = restaurants;
      },
      error:(fail) => {
        console.error('RestaurantService.reload(): error getting restaurants');
        console.error(fail);
      }
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
    this.restaurantService.updateRestaurant(updatedRestaurant).subscribe({
      next: (updateRestaurant) => {
        if (setSelected) {
          this.selected = updateRestaurant;
        }
        this.editRestaurant = null;
        this.reload();
      },
      error: (fail) => {
        console.error('RestaurantComponent.updateRestaurant: error updating restaurant');
        console.error(fail);
      },
    });
  }



}
