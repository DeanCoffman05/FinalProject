import { Cuisine } from './../../models/cuisine';
import { Restaurant } from './../../models/restaurant';
import {
  Component,
  OnInit,
  AfterViewInit,
  ViewChild,
  ElementRef,
} from '@angular/core';
import { Router } from '@angular/router';

import { RestaurantService } from 'src/app/services/restaurant.service';
// import { environment } from 'src/environments/environment';
import { AuthService } from 'src/app/services/auth.service';
import { User } from 'src/app/models/user';
import { GoogleMap } from '@angular/google-maps';
import { EnabledPipe } from 'src/app/enabled.pipe';
import { CuisineService } from 'src/app/services/cuisine.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent implements OnInit, AfterViewInit {
  user: User = new User();
  marker!: { position: { lat: number; lng: number } };
  marker1!: { position: { lat: number; lng: number } };
  marker2!: { position: { lat: number; lng: number } };
  markers: any[] = [];

  mapOptions: google.maps.MapOptions = {
    disableDefaultUI: true,
    zoom: 8,
  };

  cuisines: Cuisine[] = [];
  restaurantSearchs: Restaurant[] = [];
  restaurantCitySearch: Restaurant[] = [];
  restaurantstateSearch: Restaurant[] = [];
  citySearchInput: string = '';
  stateSearchInput: string = '';
  selected: Restaurant | null = null;
  showEnabled: boolean = false;
  selectedCuisineType: String = 'All';

  @ViewChild(GoogleMap) map!: GoogleMap;
  @ViewChild('widgetsContent', { read: ElementRef })
  public widgetsContent!: ElementRef<any>;

  constructor(
    private restaurantservice: RestaurantService,
    private router: Router,
    private authService: AuthService,
    private showenabled: EnabledPipe,
    private cuisineService: CuisineService
  ) {}

  ngOnInit() {
    this.authService.getLoggedInUser().subscribe({
      next: (data: User) => {
        this.user = data;
      },
      error: (fail) => {
        console.error('Error getting User. ');
        console.error(fail);
      },
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
      north =
        north !== undefined
          ? Math.max(north, marker.position.lat)
          : marker.position.lat;
      south =
        south !== undefined
          ? Math.min(south, marker.position.lat)
          : marker.position.lat;
      east =
        east !== undefined
          ? Math.max(east, marker.position.lng)
          : marker.position.lng;
      west =
        west !== undefined
          ? Math.min(west, marker.position.lng)
          : marker.position.lng;
    }

    const bounds: google.maps.LatLngBoundsLiteral = {
      north: north!,
      south: south!,
      east: east!,
      west: west!,
    };

    return bounds;
  }

  displayRestaurant(restaurant: any) {
    this.selected = restaurant;
  }
  displayHome() {
    this.selected = null;
  }
  restaurantcitySearch() {
    // Remove the argument as it's not needed
    console.log(this.citySearchInput); // Use this.citySearchInput
    this.searchByCuisine();
    this.restaurantservice.citySearch(this.citySearchInput).subscribe({
      next: (restaurants: Restaurant[]) => {
        this.markers = [];
        for (let i = 0; i < restaurants.length; i++) {
          let marker = new google.maps.Marker({
            position: new google.maps.LatLng(
              parseFloat(restaurants[i].address.latitude),
              parseFloat(restaurants[i].address.longitude)
            ),
          });

          this.markers.push(marker);
        }
        var bounds = new google.maps.LatLngBounds();
        for (var i in this.markers) // your marker list here
          bounds.extend(this.markers[i].position); // your marker position, must be a LatLng instance

        this.map.fitBounds(bounds);
        console.log('Received restaurants:', restaurants);
        this.restaurantCitySearch = restaurants;
      },
      error: (fail) => {
        console.error(
          'RestaurantComponent.searchByRestaurantCity: error finding restaurant'
        );
        console.error(fail);
      },
    });
  }

  restaurantStateSearch() {
    console.log(this.stateSearchInput);
    this.restaurantservice.stateSearch(this.stateSearchInput).subscribe({
      next: (restaurants: Restaurant[]) => {
        console.log('Received restaurants:', restaurants);
        this.restaurantstateSearch = restaurants;
      },
      error: (fail) => {
        console.error(
          'RestaurantComponent.searchByRestaurantState: error finding restaurant'
        );
        console.error(fail);
      },
    });
  }

  public scrollRight(): void {
    this.widgetsContent.nativeElement.scrollTo({
      left: this.widgetsContent.nativeElement.scrollLeft + 150,
      behavior: 'smooth',
    });
  }

  public scrollLeft(): void {
    this.widgetsContent.nativeElement.scrollTo({
      right: this.widgetsContent.nativeElement.scrollRight + 150,
      behavior: 'smooth',
    });
  }

  searchByCuisine() {
    this.cuisineService.index().subscribe({
      next: (cuisines: Cuisine[]) => {
        console.log('received cuisines', cuisines);
        this.cuisines = cuisines;
      },
      error: (fail) => {
        console.error('cuisineService.index error getting cuisines');
        console.error(fail);
      },
    });
  }
}
