import { Component, Output, EventEmitter } from '@angular/core';
import { FormControl, Validators } from '@angular/forms';
import { User } from '../classes/user';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  user: User = {
    name: '',
    password: '',
    login: false,
    id: 0
  };

  @Output() loginSucessEvent = new EventEmitter<boolean>();

  username = new FormControl('', [Validators.required]);
  hide = true;

  getErrorMessage() {
    if (this.username.hasError('required')) {
      return 'You must enter a user name';
    }

    return this.username.hasError('username') ? 'Not a valid username' : '';
  }

  changeLoginStatus(user: User) {
    if (user.name != '' && user.password != '')
      user.login = true;
    this.loginSucessEvent.emit(user.login);
  }
}
