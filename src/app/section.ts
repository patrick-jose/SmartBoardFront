import { Task } from "./task";

export interface Section {
    position: number;
    name: String;
    tasks: Task[];
}