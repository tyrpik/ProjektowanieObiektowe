"""
Testy Selenium – walidacja formularza rejestracji
Uruchom: python -m pytest tests/ -v
"""

import os
import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


FORM_PATH = os.path.abspath(
    os.path.join(os.path.dirname(__file__), "..", "form", "index.html")
)
FORM_URL = f"file:///{FORM_PATH.replace(os.sep, '/')}"


@pytest.fixture(scope="module")
def driver():
    """Uruchamia Chrome (headless) i zamyka go po testach."""
    opts = Options()
    opts.add_argument("--headless=new")
    opts.add_argument("--no-sandbox")
    opts.add_argument("--disable-dev-shm-usage")
    opts.add_argument("--window-size=1280,900")

    drv = webdriver.Chrome(options=opts)
    drv.implicitly_wait(4)
    yield drv
    drv.quit()


@pytest.fixture(autouse=True)
def open_form(driver):
    """Przed każdym testem otwiera świeżą stronę formularza."""
    driver.get(FORM_URL)
    WebDriverWait(driver, 5).until(
        EC.presence_of_element_located((By.ID, "submit-btn"))
    )


def fill(driver, username="", email="", password="", confirm=""):
    for field_id, value in [
        ("username", username),
        ("email", email),
        ("password", password),
        ("confirm", confirm),
    ]:
        el = driver.find_element(By.ID, field_id)
        el.clear()
        if value:
            el.send_keys(value)


def click_submit(driver):
    driver.find_element(By.ID, "submit-btn").click()


def error_visible(driver, msg_id: str) -> bool:
    el = driver.find_element(By.ID, msg_id)
    return "visible" in el.get_attribute("class")


def success_visible(driver) -> bool:
    el = driver.find_element(By.ID, "success-msg")
    return el.is_displayed()


class TestRequiredFields:

    def test_TC01_all_fields_empty(self, driver):
        """Kliknięcie bez danych - błędy przy wszystkich polach."""
        click_submit(driver)
        assert error_visible(driver, "username-error"), "Brak błędu: username"
        assert error_visible(driver, "email-error"), "Brak błędu: email"
        assert error_visible(driver, "password-error"), "Brak błędu: password"
        assert error_visible(driver, "confirm-error"), "Brak błędu: confirm"
        assert not success_visible(driver)

    def test_TC02_only_username_filled(self, driver):
        """Tylko username - błędy pozostałych pól."""
        fill(driver, username="jan_kowalski")
        click_submit(driver)
        assert not error_visible(driver, "username-error")
        assert error_visible(driver, "email-error")
        assert error_visible(driver, "password-error")
        assert not success_visible(driver)

    def test_TC03_missing_username(self, driver):
        """Brak username przy reszcie poprawnej - błąd tylko username."""
        fill(driver, email="jan@example.com", password="secret1", confirm="secret1")
        click_submit(driver)
        assert error_visible(driver, "username-error")
        assert not error_visible(driver, "email-error")
        assert not error_visible(driver, "password-error")
        assert not success_visible(driver)

    def test_TC04_missing_email(self, driver):
        """Brak e-maila - błąd tylko email."""
        fill(driver, username="jan", password="secret1", confirm="secret1")
        click_submit(driver)
        assert not error_visible(driver, "username-error")
        assert error_visible(driver, "email-error")
        assert not success_visible(driver)

    def test_TC05_missing_password(self, driver):
        """Brak hasła - błąd password."""
        fill(driver, username="jan", email="jan@example.com", confirm="secret1")
        click_submit(driver)
        assert error_visible(driver, "password-error")
        assert not success_visible(driver)

    def test_TC06_missing_confirm(self, driver):
        """Brak powtórzenia hasła - błąd confirm."""
        fill(driver, username="jan", email="jan@example.com", password="secret1")
        click_submit(driver)
        assert error_visible(driver, "confirm-error")
        assert not success_visible(driver)



class TestEmailValidation:

    INVALID_EMAILS = [
        ("TC07", "plaintext", "brak @ i domeny"),
        ("TC08", "missing@domain", "brak TLD"),
        ("TC09", "@nodomain.com", "brak nazwy przed @"),
        ("TC10", "space @example.com", "spacja w adresie"),
        ("TC11", "double@@example.com","podwójny @"),
        ("TC12", "noDot@domaincom", "brak kropki w domenie"),
    ]

    @pytest.mark.parametrize("tc_id,email,desc", INVALID_EMAILS)
    def test_invalid_email(self, driver, tc_id, email, desc):
        """Niepoprawny format e-mail - błąd walidacji."""
        fill(driver, username="jan", email=email, password="secret1", confirm="secret1")
        click_submit(driver)
        assert error_visible(driver, "email-error"), (
            f"{tc_id}: oczekiwano błędu e-mail dla '{email}' ({desc})"
        )
        assert not success_visible(driver)

    VALID_EMAILS = [
        ("TC13", "jan@example.com", "standardowy"),
        ("TC14", "jan.kowalski@firma.pl", "z kropką w nazwie"),
        ("TC15", "jan+tag@example.org", "z tagiem +"),
        ("TC16", "jan@sub.example.com", "subdomena"),
    ]

    @pytest.mark.parametrize("tc_id,email,desc", VALID_EMAILS)
    def test_valid_email_accepted(self, driver, tc_id, email, desc):
        """Poprawny e-mail - brak błędu walidacji."""
        fill(driver, username="jan", email=email, password="secret1", confirm="secret1")
        click_submit(driver)
        assert not error_visible(driver, "email-error"), (
            f"{tc_id}: nie oczekiwano błędu dla '{email}' ({desc})"
        )
        assert success_visible(driver)



class TestPasswordValidation:

    def test_TC17_password_too_short(self, driver):
        """Hasło < 6 znaków - błąd password."""
        fill(driver, username="jan", email="jan@example.com", password="abc", confirm="abc")
        click_submit(driver)
        assert error_visible(driver, "password-error")
        assert not success_visible(driver)

    def test_TC18_passwords_mismatch(self, driver):
        """Hasła różne - błąd confirm."""
        fill(driver, username="jan", email="jan@example.com", password="secret1", confirm="secret2")
        click_submit(driver)
        assert error_visible(driver, "confirm-error")
        assert not success_visible(driver)

    def test_TC19_password_exactly_6_chars(self, driver):
        """Hasło dokładnie 6 znaków - brak błędu."""
        fill(driver, username="jan", email="jan@example.com", password="abcdef", confirm="abcdef")
        click_submit(driver)
        assert not error_visible(driver, "password-error")
        assert not error_visible(driver, "confirm-error")
        assert success_visible(driver)


class TestSuccessfulRegistration:

    def test_TC20_all_valid_data(self, driver):
        """Wszystkie pola poprawne - sukces, brak błędów."""
        fill(
            driver,
            username="jan_kowalski",
            email="jan.kowalski@example.com",
            password="Tajne123",
            confirm="Tajne123",
        )
        click_submit(driver)
        assert not error_visible(driver, "username-error")
        assert not error_visible(driver, "email-error")
        assert not error_visible(driver, "password-error")
        assert not error_visible(driver, "confirm-error")
        assert success_visible(driver), "Komunikat sukcesu powinien być widoczny"

    def test_TC21_error_clears_after_correction(self, driver):
        """Błąd e-mail - poprawienie - błąd znika, sukces widoczny."""
        fill(driver, username="jan", email="bledny-email", password="secret1", confirm="secret1")
        click_submit(driver)
        assert error_visible(driver, "email-error")

        fill(driver, username="jan", email="jan@example.com", password="secret1", confirm="secret1")
        click_submit(driver)
        assert not error_visible(driver, "email-error")
        assert success_visible(driver)