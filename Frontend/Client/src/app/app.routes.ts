import { Routes } from '@angular/router';
import { NormalLoginComponent } from './login/normal-login/normal-login.component';
import { authGuard } from './core/guards/auth.guard';
import { HomeComponent } from './home/home.component';
import { NewuserComponent } from './newuser/newuser.component';

export const routes: Routes = [ 
    { path: '', redirectTo: 'login', pathMatch: 'full' },
    { path:'login', component:NormalLoginComponent},
    { path:'home', component:HomeComponent },
    { path: 'register', component: NewuserComponent }
];
