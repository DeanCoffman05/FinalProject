import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { ProfileComponent } from './components/profile/profile.component';
import { UpdateprofileComponent } from './components/updateprofile/updateprofile.component';
import { RestaurantComponent } from './components/restaurant/restaurant.component';
import { RestaurantreviewComponent } from './components/restaurantreview/restaurantreview.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: HomeComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'login', component: LoginComponent},
  { path: 'profile', component: ProfileComponent},
  { path: 'updateprofile', component: UpdateprofileComponent},
  { path: 'restaurant', component: RestaurantComponent},
  { path: 'restaurantreview', component: RestaurantreviewComponent},
  { path: '**', component: NotFoundComponent },


];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
