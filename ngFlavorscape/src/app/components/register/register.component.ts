import { Component } from "@angular/core";
import { Router } from "@angular/router";
import { Address } from "src/app/models/address";
import { User } from "src/app/models/user";
import { AuthService } from "src/app/services/auth.service";


@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent {
newUser: User = new User();
address: Address = new Address();


constructor (
  private auth: AuthService,
  private router: Router) {}



register(user: User): void {
  console.log(user);
  console.log('Registering user:');
  user.address = this.address;
  console.log(user);
  this.auth.register(user).subscribe({
    next: (registeredUser) => {
      this.auth.login(user.username, user.password).subscribe({
        next: (loggedInUser) => {
          console.log('User Data to Send: ', user);
          this.router.navigateByUrl('/profile');
        },
        error: (problem) => {
          console.error('RegisterComponent.register(): Error logging in user:');
          console.error(problem);
        }
      });
    },
    error: (fail) => {
      console.error('RegisterComponent.register(): Error registering account');
      console.error(fail);
    }
  });
}
}
