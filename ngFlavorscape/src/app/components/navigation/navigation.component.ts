import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {
  constructor (
    private auth: AuthService,
    private router: Router) {}


  ngOnInit(): void {

  }

get isLoggedIn(): boolean {
      return this.auth.checkLogin();
}

logout() {
  this.auth.logout();
}
}
