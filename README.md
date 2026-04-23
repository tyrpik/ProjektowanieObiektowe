# ProjektowanieObiektowe

### Zadanie1 Pascal

3.0 Procedura do generowania 50 losowych liczb od 0 do 100 https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/pascal/zad_3_0/zad_3_0.pas

3.5 Procedura do sortowania liczb https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/pascal/zad_3_5/zad_3_5.pas

4.0 Dodanie parametrów do procedury losującej określającymi zakres losowania: od, do, ile https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/pascal/zad_4_0/zad_4_0.pas

4.5 5 testów jednostkowych testujące procedury https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/pascal/zad_4_5/zad_4_5.pas

5.0 Skrypt w bashu do uruchamiania aplikacji w Pascalu via docker https://github.com/tyrpik/ProjektowanieObiektowe/tree/main/pascal/zad_5_0

link do zadania 1: https://github.com/tyrpik/ProjektowanieObiektowe/tree/main/pascal

wideo: https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/pascal/pascal.mkv


### Zadanie 2 Wzorce architektury

Symfony (PHP)

Należy stworzyć aplikację webową na bazie frameworka Symfony na obrazie kprzystalski/projobj-php:latest. Baza danych dowolna, sugeruję SQLite.

3.0 Należy stworzyć jeden model z kontrolerem z produktami, zgodnie z CRUD (JSON): 
https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/symfony/projekt/src/Entity/Product.php 
https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/symfony/projekt/src/Controller/ProductController.php

3.5 Należy stworzyć skrypty do testów endpointów via curl (JSON): https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/symfony/projekt/test_curl.sh

4.0 Należy stworzyć dwa dodatkowe kontrolery wraz z modelami  (JSON): https://github.com/tyrpik/ProjektowanieObiektowe/tree/main/symfony/projekt/src/Entity 
https://github.com/tyrpik/ProjektowanieObiektowe/tree/main/symfony/projekt/src/Controller

4.5 Należy stworzyć widoki do wszystkich kontrolerów: https://github.com/tyrpik/ProjektowanieObiektowe/tree/main/symfony/projekt/templates

link do zadania 2: https://github.com/tyrpik/ProjektowanieObiektowe/tree/main/symfony

wideo: https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/symfony/symfony.mkv


### Zadanie 3 Wzorce kreacyjne Spring Boot (Kotlin)
Proszę stworzyć prosty serwis do autoryzacji, który zasymuluje autoryzację użytkownika za pomocą przesłanej nazwy użytkownika oraz hasła. Serwis powinien zostać wstrzyknięty do kontrolera (4.5).
Aplikacja ma oczywiście zawierać jeden kontroler i powinna zostać napisana w języku Kotlin. Oparta powinna zostać na frameworku Spring Boot. Serwis do autoryzacji powinien być singletonem.

3.0 Należy stworzyć jeden kontroler wraz z danymi wyświetlanymi z listy na endpoint’cie w formacie JSON - Kotlin + Spring Boot: https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/spring-kotlin/demo/src/main/kotlin/com/project/authservice/controller/Controller.kt

3.5 Należy stworzyć klasę do autoryzacji (mock) jako Singleton w formie eager: https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/spring-kotlin/demo/src/main/kotlin/com/project/authservice/service/Serivce.kt

4.0 Należy obsłużyć dane autoryzacji przekazywane przez użytkownika: https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/spring-kotlin/demo/src/main/kotlin/com/project/authservice/controller/Controller.kt

link do zadania 3: https://github.com/tyrpik/ProjektowanieObiektowe/tree/main/spring-kotlin

wideo: https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/spring-kotlin/spring-kotlin.mkv

### Zadanie 4 Wzorce strukturalne

Echo (Go)
Należy stworzyć aplikację w Go na frameworku echo. Aplikacja ma mieć jeden endpoint, minimum jedną funkcję proxy, która pobiera dane np. o pogodzie, giełdzie, etc. (do wyboru) z zewnętrznego API. Zapytania do endpointu można wysyłać w jako GET lub POST.

3.0 Należy stworzyć aplikację we frameworki echo w j. Go, która będzie miała kontroler Pogody, która pozwala na pobieranie danych o pogodzie (lub akcjach giełdowych): https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/go/main.go

3.5 Należy stworzyć model Pogoda (lub Giełda) wykorzystując gorm, a dane załadować z listy przy uruchomieniu: https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/go/models.go
https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/go/main.go

4.0 Należy stworzyć klasę proxy, która pobierze dane z serwisu zewnętrznego podczas zapytania do naszego kontrolera: https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/go/proxy.go

4.5 Należy zapisać pobrane dane z zewnątrz do bazy danych: https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/go/proxy.go

5.0 Należy rozszerzyć endpoint na więcej niż jedną lokalizację (Pogoda), lub akcje (Giełda) zwracając JSONa: https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/go/main.go

link do zadania 4: https://github.com/tyrpik/ProjektowanieObiektowe/tree/main/go

wideo: https://github.com/tyrpik/ProjektowanieObiektowe/blob/main/go/go_pogoda.mkv
