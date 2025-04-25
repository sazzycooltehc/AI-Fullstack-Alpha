import { Routes } from '@angular/router';
import { NormalLoginComponent } from './login/normal-login/normal-login.component';
import { authGuard } from './core/guards/auth.guard';

export const routes: Routes = [ 
    { path: '', redirectTo: 'login', pathMatch: 'full' },
    { path:'login', component:NormalLoginComponent}
];
