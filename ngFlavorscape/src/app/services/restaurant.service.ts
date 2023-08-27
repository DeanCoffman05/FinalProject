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
    return this.http.post<Restaurant>(this.url, restaurant).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('RestaurantService.create(): error creating restaurant: ' + err)
        );
      })
    );
  }

  updateRestaurant(updateRestaurant: Restaurant): Observable<Restaurant> {
    return this.http.put<Restaurant>(this.url + '/' + updateRestaurant.id, updateRestaurant).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('RestaurantService.create(): error retrieving restaurant: ' + err)
        );
      })
    );
  }

}
