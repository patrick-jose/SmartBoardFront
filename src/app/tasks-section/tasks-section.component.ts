import { Component, Inject, Input } from '@angular/core';
import { Section } from '../section';
import { Task } from '../task';
import { User } from '../user';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

export interface DialogData {
  newStatus: Section;
  newTask: Task;
  task: Task;
  sections: Section[];
}

@Component({
  selector: 'tasks-section-new-status.component.dialog',
  templateUrl: 'tasks-section-new-status.component.dialog.html',
  styleUrls: ['./tasks-section.component.css']
})
export class TasksSectionNewStatusComponentDialog {
  constructor(
    public dialogRef: MatDialogRef<TasksSectionNewStatusComponentDialog>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData, 
    ) {}

  onNoClick(): void {
    this.dialogRef.close(false);
  }
}

@Component({
  selector: 'tasks-section-new-task.component.dialog',
  templateUrl: 'tasks-section-new-task.component.dialog.html',
  styleUrls: ['./tasks-section.component.css']
})
export class TasksSectionNewTaskComponentDialog {
  constructor(
    public dialogRef: MatDialogRef<TasksSectionNewTaskComponentDialog>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData, 
    ) {}

  onNoClick(): void {
    this.dialogRef.close(false);
  }

  setBlocked(){
    this.data.newTask.blocked = !this.data.newTask.blocked
    console.log(this.data.newTask.blocked);
  }
}

@Component({
  selector: 'tasks-section-task-details.component.dialog',
  templateUrl: 'tasks-section-task-details.component.dialog.html',
  styleUrls: ['./tasks-section.component.css']
})
export class TasksSectionTaskDetailsComponentDialog {
  constructor(
    public dialogRef: MatDialogRef<TasksSectionTaskDetailsComponentDialog>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData, 
    ) {}

  onNoClick(): void {
    this.dialogRef.close(false);
  }

  editEnabled = false;

  editTask(){
    this.editEnabled = !this.editEnabled;
  }
}

@Component({
  selector: 'app-tasks-section',
  templateUrl: './tasks-section.component.html',
  styleUrls: ['./tasks-section.component.css']
})
export class TasksSectionComponent {
  @Input() user: User = {
    name: '',
    password: '',
    login: false
  };
  @Input() editClicked = false;
  sections = new Array<Section>;
  newStatusName = '';
  newTask: Task = {
    title: '',
    position: 1,
    description: '',
    lastModified: new Date(),
    comments: [],
    blocked: false,
    history: [],
    assignee: '',
    status: '',
    creator: this.user.name
  };

  constructor(public dialog: MatDialog) {}

  openNewStatusDialog(): void {
    const dialogRef = this.dialog.open(TasksSectionNewStatusComponentDialog, {
      data: { newStatusName: this.newStatusName },
    });
    
    dialogRef.afterClosed().subscribe(result => {
      if (result != false && result != '' && result != undefined)
      {
        console.log(result);
        this.newStatusName = result;
        this.addTab(this.newStatusName, 1);
      }
      this.newStatusName = '';
    });
  }

  openNewTaskDialog(section: Section): void {
    this.newTask.status = section.name;
    this.newTask.creator = this.user.name;
    this.newTask.description = '';
    this.newTask.history.push('Created by ' + this.newTask.creator + ' at ' + new Date());
    this.newTask.blocked = false;

    const dialogRef = this.dialog.open(TasksSectionNewTaskComponentDialog, {
      data: { newTask: this.newTask },
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result != false && this.newTask.title != '')
        this.addTask(section, result);
      this.newTask.title = '';
      this.newTask.history.pop();
    });
  }

  openTaskDetailsDialog(task: Task): void {
    const dialogRef = this.dialog.open(TasksSectionTaskDetailsComponentDialog, {
      data: { task: task, sections: this.sections },
    });
  }

  /* newMockTask1: Task = {
    title: 'Mock task1',
    position: 1,
    description: `Lorem ipsum dolor sit amet. Est provident voluptatem cum atque quisquam est iste consequatur in voluptas recusandae. Aut tempore adipisci est quidem recusandae et eveniet quia.                 
                  Et rerum rerum qui quos quaerat et aspernatur libero id galisum facere et facere iure. Non mollitia repellat eum esse corrupti et voluptas tempora sit neque iusto et porro obcaecati eum molestias delectus et atque excepturi. 
                  Ab velit laudantium sed rerum iste ut omnis sunt a temporibus galisum sed asperiores sunt est error ipsa non odio dignissimos. Sed dolor sunt ea nobis doloremque ut similique doloribus aut blanditiis perferendis sit vero laborum ut enim possimus. Sed dicta error qui error maxime qui atque voluptatem aut nisi temporibus qui quas expedita quo quidem vitae aut galisum dolorum.`,
    lastModified: new Date(),
    comments: ['Lorem ipsum dolor sit amet. Est provident voluptatem cum atque quisquam est iste consequatur in voluptas recusandae. Aut tempore adipisci est quidem recusandae et eveniet quia.',
                'Et rerum rerum qui quos quaerat et aspernatur libero id galisum facere et facere iure. Non mollitia repellat eum esse corrupti et voluptas tempora sit neque iusto et porro obcaecati eum molestias delectus et atque excepturi.',
                'Ab velit laudantium sed rerum iste ut omnis sunt a temporibus galisum sed asperiores sunt est error ipsa non odio dignissimos. Sed dolor sunt ea nobis doloremque ut similique doloribus aut blanditiis perferendis sit vero laborum ut enim possimus. Sed dicta error qui error maxime qui atque voluptatem aut nisi temporibus qui quas expedita quo quidem vitae aut galisum dolorum.'
              ],
    blocked: false,
    history: ['Lorem ipsum dolor sit amet.', 'Lorem ipsum dolor sit amet.', 'Lorem ipsum dolor sit amet.'],
    assignee: 'Patrick',
    status: 'Mock Status',
    creator: this.user.name
  };

  newMockTask2: Task = {
    title: 'Mock task2',
    position: 2,
    description: '',
    lastModified: new Date(),
    comments: [],
    blocked: false,
    history: [],
    assignee: '',
    status: 'Mock Status',
    creator: this.user.name
  };

  newMockTask3: Task = {
    title: 'Mock task2',
    position: 3,
    description: '',
    lastModified: new Date(),
    comments: [],
    blocked: false,
    history: [],
    assignee: '',
    status: 'Mock Status',
    creator: this.user.name
  };

  mockTaskList: Array<Task> = [this.newMockTask1, this.newMockTask2, this.newMockTask3];

  mockSection: Section = {
    position: 1,
    name: 'Mock Status',
    tasks: this.mockTaskList 
  } */

  addTab(name: string, position: number) {
    let newSection: Section = {
      name: name,
      position: position,
      tasks: new Array<Task>
    };

    this.sections.push(newSection);
  }

  removeTab(index: number) {
    this.sections.splice(index, 1);
  }

  addTask(section: Section, task: Task) {
    let newTask: Task = {
      title: task.title,
      position: 1,
      description: task.description,
      lastModified: task.lastModified,
      comments: task.comments,
      blocked: task.blocked,
      history: task.history,
      assignee: task.assignee,
      status: task.status,
      creator: task.creator
    };

    if (section.tasks.length != 0) {
      newTask.position = section.tasks[section.tasks.length-1].position + 1;
    }

    console.log(section);

    section.tasks.push(newTask);
  }

  openTaskDetails(task: Task) {
    this.openTaskDetailsDialog(task);
  }
}
