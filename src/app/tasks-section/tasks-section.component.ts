import { Component, Input, Directive } from '@angular/core';
import { Section } from '../section';
import { Task } from '../task';

@Component({
  selector: 'app-tasks-section',
  templateUrl: './tasks-section.component.html',
  styleUrls: ['./tasks-section.component.css']
})
export class TasksSectionComponent {  
  @Input() editClicked = false;
  task: Task | undefined;
  taskList = new Array<Task>;
  section: Section | undefined;
  sections = new Array<Section>;

  ngOnInit() {
    /* let i = 1;

    for (; i <= 12; i++) {
      this.task = {
        title: 'Task ' + i,
        position: i
      }
      this.taskList?.push(this.task);
    } */
    this.section = {
      name: 'Backlog',
      tasks: this.taskList
    };

    this.sections.push(this.section);
    this.taskList = [];
    
    /* for (; i <= 18; i++) {
      this.task = {
        title: 'Task ' + i,
        position: i
      }
      this.taskList?.push(this.task);
    } */

    this.section = {
      name: 'To Do',
      tasks: this.taskList
    };

    this.sections.push(this.section);
    this.taskList = [];

    /* for (; i <= 21; i++) {
      this.task = {
        title: 'Task ' + i,
        position: i
      }
      this.taskList?.push(this.task);
    } */

    this.section = {
      name: 'Doing',
      tasks: this.taskList
    };

    this.sections.push(this.section);
    this.taskList = [];

    /* for (; i <= 25; i++) {
      this.task = {
        title: 'Task ' + i,
        position: i
      }
      this.taskList?.push(this.task);
    } */

    this.section = {
      name: 'Done',
      tasks: this.taskList
    };

    this.sections.push(this.section);
    this.taskList = [];

    /* for (; i <= 26; i++) {
      this.task = {
        title: 'Task ' + i,
        position: i
      }
      this.taskList?.push(this.task);
    } */

    this.section = {
      name: 'Testing',
      tasks: this.taskList
    };

    this.sections.push(this.section);
    this.taskList = [];
  }

  addTab(newSection: Section) {
    this.sections.push(newSection);
  }

  removeTab(index: number) {
    this.sections.splice(index, 1);
  }

  addTask(taskList: Task[]) {
    console.log(taskList);

    if (taskList.length != 0) {
      this.task = {
        title: 'Task ' + (taskList[taskList.length-1].position + 1),
        position: taskList[taskList.length-1].position + 1
      }
    }
    else {
      this.task = {
        title: 'Task 1',
        position: 1
      }
    }

    taskList.push(this.task);
  }
}
