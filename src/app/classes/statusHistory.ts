import { Section } from "./section";

export interface StatusHistory {
    userId: number,
    previousSectionId: number,
    actualSectionId: number,
    dateModified: Date,
    taskId: number,
    previousSectionName?: String,
    actualSectionName?: String
}