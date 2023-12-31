import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { Cuisine } from '../models/cuisine';
import { Observable, catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CuisineService {

  private Url = environment.baseUrl + "api/cuisines";

  constructor(private http: HttpClient, private auth : AuthService) { }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index(): Observable<Cuisine[]> {
    return this.http.get<Cuisine[]>(this.Url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('CuisineService.index(): error retrieving cuisine: ' + err)
        );
      })
    );
  }

}
