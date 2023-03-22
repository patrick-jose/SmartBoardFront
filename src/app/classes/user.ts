export interface User {
    name: String,
    password: String,
    login: boolean,
    id: number
}

export interface UserDTO {
    name: String,
    id: number,
    password?: String
}