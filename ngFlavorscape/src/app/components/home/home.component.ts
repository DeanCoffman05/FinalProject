import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Restaurant } from 'src/app/models/restaurant';
import { RestaurantService } from 'src/app/services/restaurant.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  restaurantSearchs: Restaurant[] = [];
  restaurantCitySearch: Restaurant[] = [];
  restaurantstateSearch: Restaurant[] = []; // Initialize as an empty string
  citySearchInput: string = ''; // Rename the variable
  stateSearchInput: string = '';
  constructor(private restaurantservice: RestaurantService, private router: Router) { }

  ngOnInit() {
  }

  restaurantcitySearch() { // Remove the argument as it's not needed
    console.log(this.citySearchInput); // Use this.citySearchInput
    this.restaurantservice.citySearch(this.citySearchInput).subscribe({
      next: (restaurants: Restaurant[]) => {
        console.log('Received restaurants:', restaurants);
        this.restaurantCitySearch = restaurants;
      },
      error: (fail) => {
        console.error('RestaurantComponent.searchByRestaurantCity: error finding restaurant');
        console.error(fail);
      }
    });
  }
  restaurantStateSearch(){
    console.log(this.stateSearchInput);
    this.restaurantservice.stateSearch(this.stateSearchInput).subscribe({
      next: (restaurants: Restaurant[]) => {
        console.log('Received restaurants:', restaurants);
        this.restaurantstateSearch = restaurants;
      },
      error: (fail) => {
        console.error('RestaurantComponent.searchByRestaurantState: error finding restaurant');
        console.error(fail);
      }
    });
  }

}
