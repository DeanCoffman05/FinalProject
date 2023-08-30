import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { FormsModule } from '@angular/forms';
import { ComponentsComponent } from './components/components.component';
import { HomeComponent } from './components/home/home.component';
import { NavigationComponent } from './components/navigation/navigation.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { NavBarComponent } from './components/nav-bar/nav-bar.component';
import { ProfileComponent } from './components/profile/profile.component';
import { UpdateprofileComponent } from './components/updateprofile/updateprofile.component';
import { RestaurantComponent } from './components/restaurant/restaurant.component';
import { MapComponent } from './components/map/map.component';
import { GoogleMapsModule } from '@angular/google-maps';
import { EnabledPipe } from './enabled.pipe';
import { RestaurantreviewComponent } from './components/restaurantreview/restaurantreview.component';


@NgModule({
  declarations: [
    AppComponent,
    ComponentsComponent,
    HomeComponent,
    NavigationComponent,
    NotFoundComponent,
    RegisterComponent,
    LoginComponent,
    LogoutComponent,
    NavBarComponent,
    ProfileComponent,
    UpdateprofileComponent,
    RestaurantComponent,
    MapComponent,
    EnabledPipe,
    RestaurantreviewComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    GoogleMapsModule

  ],
  providers: [EnabledPipe],
  bootstrap: [AppComponent]
})
export class AppModule { }
