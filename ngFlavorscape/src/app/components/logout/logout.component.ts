import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent implements OnInit {
  constructor (
    private auth: AuthService,
    private router: Router) {}
  ngOnInit(): void {
    throw new Error('Method not implemented.');
  }


logout() {
  console.log('logging out:');
  this.auth.logout();
  this.router.navigateByUrl('/home')
}
}
