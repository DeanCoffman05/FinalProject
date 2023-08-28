import { Component, OnInit, AfterViewInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { Restaurant } from 'src/app/models/restaurant';
import { RestaurantService } from 'src/app/services/restaurant.service';
// import { environment } from 'src/environments/environment';
import { AuthService } from 'src/app/services/auth.service';
import { User } from 'src/app/models/user';
import { GoogleMap } from '@angular/google-maps';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit, AfterViewInit {
  user: User = new User();
  marker!: { position: { lat: number, lng: number } };
  marker1!: { position: { lat: number, lng: number } };
  marker2!: { position: { lat: number, lng: number } };
  markers: any[] = [];

  mapOptions: google.maps.MapOptions = {
    disableDefaultUI: true,
    zoom : 8
  }

  restaurantSearchs: Restaurant[] = [];
  restaurantCitySearch: Restaurant[] = [];
  restaurantstateSearch: Restaurant[] = [];
  citySearchInput: string = '';
  stateSearchInput: string = '';

  @ViewChild(GoogleMap) map!: GoogleMap;

  constructor(
    private restaurantservice: RestaurantService,
    private router: Router,
    private authService: AuthService
  ) {
    this.marker = { position: { lat: 39.727383, lng: -104.995431 } };
    this.marker1 = { position: { lat: 39.779890, lng: -105.047502  } };
    this.marker2 = { position: { lat: 39.760622, lng: -105.032503 } };
    this.markers = [this.marker, this.marker1, this.marker2];
  }

  ngOnInit() {
    this.authService.getLoggedInUser().subscribe({
      next: (data: User) => {
        this.user = data;
      },
      error: (fail) => {
        console.error('Error getting User. ');
        console.error(fail);
      }
    });
  }

  ngAfterViewInit() {
    const bounds = this.getBounds();
    if (this.map.googleMap) {
      this.map.googleMap.fitBounds(bounds);
    }
  }

  getBounds(): google.maps.LatLngBoundsLiteral {
    let north: number | undefined;
    let south: number | undefined;
    let east: number | undefined;
    let west: number | undefined;

    for (const marker of this.markers) {
      north = north !== undefined ? Math.max(north, marker.position.lat) : marker.position.lat;
      south = south !== undefined ? Math.min(south, marker.position.lat) : marker.position.lat;
      east = east !== undefined ? Math.max(east, marker.position.lng) : marker.position.lng;
      west = west !== undefined ? Math.min(west, marker.position.lng) : marker.position.lng;
    }

    const bounds: google.maps.LatLngBoundsLiteral = { north: north!, south: south!, east: east!, west: west! };

    return bounds;
  }

  restaurantcitySearch() {
    console.log(this.citySearchInput);
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
