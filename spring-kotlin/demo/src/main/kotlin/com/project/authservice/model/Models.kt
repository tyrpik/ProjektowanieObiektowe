package com.project.authservice.model

// dane logowania przekazywane przez użytkownika
data class LoginRequest(
    val username: String,
    val password: String
)

// odpowiedź po próbie logowania
data class AuthResponse(
    val success: Boolean,
    val message: String
)

// dane zwracane w formie json
data class UserDto(
    val id: Int,
    val role: String,
    val username: String
)