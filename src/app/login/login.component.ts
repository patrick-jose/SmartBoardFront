import { Component, Output, EventEmitter } from '@angular/core';
import { FormControl, Validators } from '@angular/forms';
import { User } from '../classes/user';
import { MyDataService } from '../services/my-data.service';

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

  constructor(private myDataService: MyDataService) {}

  @Output() loginSucessEvent = new EventEmitter<boolean>();

  username = new FormControl('', [Validators.required]);
  hide = this.user.login;

  getErrorMessage() {
    if (this.username.hasError('required')) {
      return 'You must enter a user name';
    }

    return this.username.hasError('username') ? 'Not a valid username' : '';
  }

  changeLoginStatus(user: User) {
    if (user.name != '' && user.password != '')
    {
      this.myDataService.checkCredentials(user.name, user.password).subscribe({
        next: result => { user.login = result; }, 
        complete: () => this.myDataService.getUserId(user.name, user.password).subscribe(result => { user.id = result.id; })
      });
    }

    this.loginSucessEvent.emit(user.login);
  }
}
