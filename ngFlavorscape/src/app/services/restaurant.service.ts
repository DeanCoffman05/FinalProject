import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Restaurant } from '../models/restaurant';
import { AuthService } from './auth.service';
import { UserService } from './user.service';

@Injectable({
  providedIn: 'root'
})
export class RestaurantService {
private url = environment.baseUrl + "api/restaurants";

  constructor(
    private http: HttpClient,
    private userService: UserService,
    private authService: AuthService
    ) { }

  index(): Observable<Restaurant[]> {
    return this.http.get<Restaurant[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('RestaurantService.index(): error retrieving Restaurant: ' + err)
        );
      })
    );
  }
  citySearch(restaurantCitySearch: String): Observable<Restaurant[]> {
    return this.http.get<Restaurant[]>(this.url + "/city/" + restaurantCitySearch).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('RestaurantService.citySearch(): error retrieving Restaurant: ' + err)
        );
      })
    );
  }
  stateSearch(restaurantStateSearch: String): Observable<Restaurant[]> {
    return this.http.get<Restaurant[]>(this.url + "/state/" + restaurantStateSearch).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('RestaurantService.stateSearch(): error retrieving Restaurant: ' + err)
        );
      })
    );
  }

  show(restaurantId: number): Observable<Restaurant> {
    return this.http.get<Restaurant>(this.url + '/' + restaurantId).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('RestaurantService.show(): error retrieving Restaurant: ' + err)
        );
      })
    );
  }

  create(restaurant: Restaurant): Observable<Restaurant> {
    return this.http.post<Restaurant>(this.url, restaurant, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('RestaurantService.create(): error creating restaurant: ' + err)
        );
      })
    );
  }

  updateRestaurant(updateRestaurant: Restaurant): Observable<Restaurant> {
    return this.http.put<Restaurant>(this.url + '/' + updateRestaurant.id, updateRestaurant, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('RestaurantService.create(): error retrieving restaurant: ' + err)
        );
      })
    );
  }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.authService.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  deleteRestaurant(restaurantId: number){
    return this.http.put<Restaurant>(this.url + "/delete/" + restaurantId,restaurantId, this.getHttpOptions()).pipe(
      catchError((err:any) => {
        console.log(err);
        return throwError(
          () => new Error ('RestaurantService.deleteRestaurant(): error deleting restaurant' + err)
        );
      })
    )

  }
  rateRestaurant(restaurantId: number, rating: number): Observable<any> {
    const rateUrl = `${this.url}/${restaurantId}/rate/${rating}`
    return this.http.post(rateUrl, null, this.getHttpOptions()).pipe(
        catchError((err: any) => {
            console.log(err);
            return throwError(() => new Error(`RestaurantService.rateRestaurant(): error rating restaurant: ${err}`));
        })
    );
}

}
