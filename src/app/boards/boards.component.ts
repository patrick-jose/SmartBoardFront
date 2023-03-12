import { Component, Input } from '@angular/core';
import { FormControl } from '@angular/forms';
import { User } from '../user';

@Component({
  selector: 'app-boards',
  templateUrl: './boards.component.html',
  styleUrls: ['./boards.component.css']
})
export class BoardsComponent {
  tabs = ['Board 1'];
  selected = new FormControl(0);
  editClicked = false;
  
  @Input() user: User = {
    name: '',
    password: '',
    login: false
  };

  addTab() {
    console.log(this.user);
    this.tabs.push('Board ' + (this.tabs.length + 1));
    this.selected.setValue(this.tabs.length - 1);
  }

  removeTab(index: number) {
    this.tabs.splice(index, 1);
  }
}