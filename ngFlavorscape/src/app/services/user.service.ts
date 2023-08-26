import { Injectable, Pipe, PipeTransform } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private url = environment.baseUrl + 'api/users/profiles';

  constructor(
    private http: HttpClient,
    private auth:AuthService) {}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }
  index(): Observable<User[]> {
    return this.http.get<User[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.index(): error retrieving User: ' + err)
        );
      })
    );
  }

  show(userId: number): Observable<User> {
    return this.http.get<User>(this.url + '/' + userId, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.show(): error retrieving user: ' + err)
        );
      })
    );
  }
  updateUser(updateUser: User): Observable<User> {
    return this.http.put<User>(this.url + '/' + updateUser.id, updateUser).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.update(): error retrieving user: ' + err)
        );
      })
    );
  }

destroyUser(userId: number): Observable<void> {
  return this.http.delete<void>(this.url + '/' + userId, this.getHttpOptions()).pipe(
    catchError((err:any) => {
      console.log(err);
      return throwError(
        () => new Error ('UserService.destroy(): error deleting user' + err)
      );
    })
  )
}


}

