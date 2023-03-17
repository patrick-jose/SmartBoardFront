import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Section, SectionDTO } from '../classes/section';
import { Board } from '../classes/board';
import { Task, TaskDTO } from '../classes/task';
import { CommentDTO } from '../classes/commentDTO';
import { User } from '../classes/user';
import { StatusHistory } from '../classes/statusHistory';

@Injectable({
  providedIn: 'root'
})
export class MyDataService {

  constructor(private http: HttpClient) { }

  getBoards() {
    return this.http.get<Array<Board>>('https://localhost:7068/api/Board/GetAllActiveBoards');
  }
  postBoard(board: Board) {
    return this.http.post('https://localhost:7068/api/Board', board);
  }
  getAllSections() {
    return this.http.get<Array<Section>>('https://localhost:7068/api/Section/GetAllSections');
  }
  postSection(section: SectionDTO) {
    return this.http.post('https://localhost:7068/api/Section', section);
  }
  postTask(task: TaskDTO) {
    return this.http.post('https://localhost:7068/api/Task', task);
  }
  getSectionById(sectionId : number) {
    return this.http.get<Section>('https://localhost:7068/api/Section/GetSectionById?id=' + sectionId);
  }
  getAllSectionsByBoardId(boardId: number) {
    return this.http.get<Array<Section>>('https://localhost:7068/api/Section/GetAllSectionsByBoardId?boardId=' + boardId);
  }
  getAllTasksBySectionId(sectionId: number) {
    return this.http.get<Array<Task>>('https://localhost:7068/api/Task/GetAllTasksBySectionId?sectionId=' + sectionId);
  }
  getAllCommentsByTaskId(sectionId: number) {
    return this.http.get<Array<CommentDTO>>('https://localhost:7068/api/Comment/GetCommentByTaskId?taskId=' + sectionId);
  }
  getAllUsers() {
    return this.http.get<Array<User>>('https://localhost:7068/api/User/GetAllUsers');
  }
  getUserById(userId: number) {
    return this.http.get<User>('https://localhost:7068/api/User?id=' + userId);
  }
  getUserId(name: String, password: String) {
    return this.http.get<User>('https://localhost:7068/api/User/GetDetails?userName=' + name + '&password=' + password);
  }
  checkCredentials(userName: String, password: String){
    return this.http.get<boolean>('https://localhost:7068/api/User/CheckCredentials?userName=' + userName + '&password=' + password);
  }
  getStatusHistoryByTaskId(taskId: number) {
    return this.http.get<Array<StatusHistory>>('https://localhost:7068/api/StatusHistory/GetStatusHistoryByTaskId?taskId=' + taskId);
  }
}
