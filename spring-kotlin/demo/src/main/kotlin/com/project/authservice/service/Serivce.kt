package com.project.authservice.service

// klasa do autoryzacji jako singleton
class AuthService private constructor() {

    // instancja jest tworzona od razu przy ładowaniu klasy (Eager)
    companion object {
        val instance: AuthService = AuthService()
    }

    // zasymulowana baza użytkowników
    private val mockDatabase = mapOf(
        "Marek" to "haslomaslo123",
        "Łukasz" to "niewiem123"
    )

    fun authorize(username: String, pass: String): Boolean {
        // sprawdza czy użytkownik istnieje i czy hasło się zgadza
        return mockDatabase[username] == pass
    }
}