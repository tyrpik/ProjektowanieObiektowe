package com.project.authservice.controller

import com.project.authservice.model.AuthResponse
import com.project.authservice.model.LoginRequest
import com.project.authservice.model.UserDto
import com.project.authservice.service.AuthService
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api")
class AuthController {

    // kontroler z danymi wyświetlanymi z listy w formacie JSON
    @GetMapping("/users")
    fun getUsers(): ResponseEntity<List<UserDto>> {
        val userList = listOf(
            UserDto(1, "ADMIN", "Marek"),
            UserDto(2, "USER", "Łukasz"),
            UserDto(3, "GUEST", "Ewa")
        )
        return ResponseEntity.ok(userList)
    }

    // obsługa danych autoryzacji przekazywanych przez użytkownika
    @PostMapping("/login")
    fun login(@RequestBody request: LoginRequest): ResponseEntity<AuthResponse> {
        
        // wykorzystanie klasy Singleton do weryfikacji danych
        val isAuthorized = AuthService.instance.authorize(request.username, request.password)
        return if (isAuthorized) {
            ResponseEntity.ok(AuthResponse(true, "Autoryzacja powiodła się. Witaj ${request.username}!"))
        } else {
            ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(AuthResponse(false, "Błędna nazwa użytkownika lub hasło."))
        }
    }
}