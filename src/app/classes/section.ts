import { Task } from "./task";

export interface Section {
    position: number;
    name: String;
    id: number;
    active: boolean;
    boardId: number;
    tasks: Array<Task>
}

export interface SectionDTO {
    position: number;
    name: String;
    id: number;
    active: boolean;
    boardId: number;
}