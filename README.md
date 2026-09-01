# 🎓 Andrews University (AU) Doctor of Ministry (DMin) — Typst Template & CSL System

Офіційний модульний шаблон для оформлення докторських дисертацій, проєктів та академічних досліджень у системі **Typst** згідно з вимогами **Doctor of Ministry Project Writing Manual (Andrews University, 4th Edition, August 2019)** та стандартом **Turabian 8th/9th ed. (Author-Date / Chicago 17th ed.)**.

---

## 🌟 Основні можливості

- **Повна відповідність AU DMin Manual (4th ed.)**:
  - **Геометрія сторінки**: ліве поле **1.5"** (для палітурки), верхнє/нижнє/праве **1.0"**, початкова сторінка розділу — **2.0"** від верхнього краю.
  - **Інтервали та вирівнювання**: подвійний інтервал (24 pt baseline), абзацний відступ **0.5"**, нерівний правий край (ragged right).
  - **Ієрархія підзаголовків 1–5 рівнів** Andrews University з автоматичним керуванням інтервалами.
  - **Повний набір службових сторінок**: порожні форзаци, Abstract, Title Page, Copyright Page, Approval Page, Dedication, TOC, List of Tables, List of Illustrations, Vita.
- **Багатомовна підтримка (i18n)**:
  - Підтримка 5 мов: **українська (`uk`)**, **англійська (`en`)**, **російська (`ru`)**, **французька (`fr`)**, **іспанська (`es`)**.
  - Автоматичний переклад усіх заголовків, таблиць, рисунків, службових сторінок та бібліографічних термінів.
- **Централізоване керування метаданими (`state`)**:
  - Усі дані дослідження (назва, автор, ступінь, керівник, комісія, дата, заклад) вказуються **один раз** на початку документа. Усі службові сторінки підтягують їх автоматично.
- **Розумний Зміст та Списки**:
  - Ідеальне вирівнювання точок (`fill-dots`) незалежно від кількості цифр у номері сторінки.
  - Нависаючий відступ (`hanging-indent`) для багаторядкових підзаголовків.
  - Підтримка ручного переносу рядка (`\ ` або `#linebreak()`) у заголовках розділів, таблиць та рисунків.

---

## 📂 Модульна структура проєкту

```
.
├── typ/                                              # ⚙️ ПАПКА МОДУЛІВ ШАБЛОНУ
│   ├── state.typ                                     # Глобальні стани та метадані (au-dmin-meta)
│   ├── i18n.typ                                      # Словники для 5 мов (uk, en, ru, fr, es)
│   ├── layout.typ                                    # Геометрія сторінок, правила заголовків, таблиць, змісту
│   ├── preliminary.typ                               # Попередні сторінки (Title, Abstract, Approval, Vita тощо)
│   ├── elements.typ                                  # Структурні блоки (Chapter, Subhead5, Table, Figure, Appendix)
│   └── au-dmin.typ                                   # Головна точка входу (реекспорт усіх модулів)
├── csl/                                              # 📑 СТИЛІ ЦИТУВАННЯ
│   ├── andrews-university-dmin-author-date.csl       # Багатомовний стиль AU DMin Author-Date
│   ├── turabian-author-date.csl                      # Базовий Turabian Author-Date (Chicago 17th ed.)
│   ├── chicago-author-date.csl                       # Chicago 18th ed. Author-Date
│   └── turabian-notes-bibliography.csl               # Turabian Notes-Bibliography (виноски)
├── example/                                          # 📄 ПРИКЛАДИ
│   ├── main.typ                                      # Повний зразок дисертації
│   ├── references.bib                                # Зразок бібліографії
│   └── Vashchynin_сhapter_3/                         # Зразок реального розділу дисертації
├── doc/                                              # 📚 Офіційна документація AU
└── README.md                                         # 📖 Ця документація
```

---

## 🚀 Покрокове встановлення та запуск з нуля (Installation Guide)

Ця інструкція допоможе розгорнути середовище та розпочати роботу над дисертацією на будь-якому новому комп'ютері (**Windows, macOS або Linux**).

---

### Крок 1. Встановлення Typst

**Typst** — це сучасний, надшвидкий компілятор документів нового покоління (написаний на Rust).

#### 🪟 Windows:
Відкрийте **PowerShell** або **Командний рядок** та виконайте (один із варіантів):
```powershell
# Варіант 1 (через Windows Package Manager — рекомендовано):
winget install --id Typst.Typst

# Варіант 2 (через Chocolatey):
choco install typst

# Варіант 3 (через Scoop):
scoop install typst
```
*(Або завантажте готовий `.zip` архів із сторінки [Typst GitHub Releases](https://github.com/typst/typst/releases) та додайте `typst.exe` до змінної PATH).*

#### 🍏 macOS:
Відкрийте **Термінал** та виконайте (через [Homebrew](https://brew.sh)):
```bash
brew install typst
```

#### 🐧 Linux (Ubuntu / Debian / Arch):
```bash
# Ubuntu / Debian (через Snap):
sudo snap install typst --classic

# Arch Linux:
sudo pacman -S typst

# Або універсальний спосіб через Cargo (Rust):
cargo install --locked typst-cli
```

*Перевірте коректність встановлення:*
```bash
typst --version
# Має вивести: typst 0.11.x (або новішу версію)
```

---

### Крок 2. Клонування репозиторію з GitHub

Відкрийте термінал у папці, де ви хочете розмістити свій проєкт (наприклад, `Documents` або `Dev`), та виконайте:

```bash
# 1. Клонувати репозиторій
git clone https://github.com/skakadu007/au_dmin_typst.git

# 2. Перейти у папку проєкту
cd au_dmin_typst
```

---

### Крок 3. Налаштування редактора (VS Code — Рекомендовано)

Для максимального комфорту, автодоповнення коду та миттєвого попереднього перегляду PDF у реальному часі:

1. Завантажте та встановіть [Visual Studio Code](https://code.visualstudio.com/).
2. Відкрийте VS Code та встановіть розширення **[Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamit.tinymist)** (вкладка Extensions / `Ctrl+Shift+X` $\rightarrow$ пошук `Tinymist`).
3. Відкрийте папку проєкту у VS Code:
   ```bash
   code .
   ```
4. Відкрийте файл `example/main.typ` і натисніть кнопку **«Show Preview»** (іконка попереднього перегляду у верхньому правому кутку редактора) або комбінацію `Ctrl+K V`.
   - *Праворуч від коду відкриється live-вікно з PDF, яке автоматично оновлюється під час друку тексту!*

---

### Крок 4. Перевірка шрифтів

Стандарт Andrews University вимагає використання шрифту **Times New Roman** (12 pt).
- **Windows та macOS**: шрифт встановлено за замовчуванням у системі.
- **Linux**: якщо з'являється попередження `warning: unknown font family: times new roman`, встановіть базові шрифти Microsoft:
  ```bash
  sudo apt install ttf-mscorefonts-installer fonts-liberation
  ```

---

### Крок 5. Створення вашої дисертації на основі шаблону

1. Головний вхідний файл дисертації — `example/main.typ`. Ви можете редагувати його або створити копію.
2. Вкажіть метадані вашого дослідження на початку документа:
   ```typst
   #import "typ/au-dmin.typ": *

   #show: au-dmin.with(
     title: "НАЗВА ВАШОЇ ДИСЕРТАЦІЇ ВЕЛИКИМИ ЛІТЕРАМИ",
     author: "Ім'я Прізвище Здобувача",
     degree: "Doctor of Ministry",
     advisor: "Ім'я Наукового Керівника, Ph.D.",
     second-reader: "Ім'я Другого Рецензента, D.Min.",
     program-director: "Stanley E. Patterson, Ph.D.",
     dean: "Jiří Moskala, Th.D., Ph.D.",
     date: "August 2026",
     lang: "uk", // "uk" (українська) або "en" (англійська)
   )
   ```
3. Додайте ваші джерела у файл `example/references.bib` (або експортуйте їх із Zotero).

---

### Крок 6. Компіляція документа у PDF через термінал

З кореневої папки проєкту (`au_dmin_typst`) виконайте:

```bash
# 1. Одноразова компіляція у PDF:
typst compile --root . example/main.typ example/main.pdf

# 2. Режим «живого перегляду» (Live Watch):
# Компілятор залишається активним і автоматично оновлює PDF при кожному збереженні файлу (Ctrl+S)
typst watch --root . example/main.typ example/main.pdf
```

> **⚠️ ВАЖЛИВО**: Завжди вказуйте прапорець `--root .` (або повний шлях до кореня), щоб Typst мав доступ до модулів шаблону в папці `typ/` та стилів цитування `csl/`.

---

## 📖 Довідник елементів та функцій

Нижче наведено повний перелік усіх доступних елементів із параметрами та прикладами.

---

### 1. Порожня сторінка (Форзац / Flyleaf) — `#blank-page()`

Використовується як **найперша** та **найостання** сторінка у готовій дисертації (вимога для переплетення). Не має колонтитулів, нумерації та не рахується у пагінацію.

```typst
#blank-page()
```

---

### 2. Анотація (Abstract) — Exhibits A & B

Анотація складається з двох частин (не нумерується і не рахується):

#### а) Титульний лист анотації — `#abstract-title-page()`
Автоматично бере назву, автора та керівника з `au-dmin`:
```typst
#abstract-title-page()

// За потреби можна перевизначити вручну:
#abstract-title-page(
  title: "КАСТОМНА НАЗВА",
  author: "Автор",
  adviser: "Керівник",
  title-lines: 2, // якщо >= 3 рядки, інтервал автоматично стискається
)
```

#### б) Текст анотації з 4 розділами — `#abstract-body(...)`
```typst
#abstract-body(
  problem: [Текст проблеми дослідження...],
  method: [Текст методології...],
  results: [Текст результатів...],
  conclusions: [Текст висновків...],
)
```

---

### 3. Титульна сторінка — `#title-page()` (Exhibit C)

Розміщує блок університету на 2.5", назву на 4.5", ступінь на 6.0" та автора з датою на 8.5" від верхнього краю.

```typst
#title-page()
```

---

### 4. Сторінка авторського права — `#copyright-page()`

Розміщується одразу **після титульної сторінки** та **перед листом схвалення**. Не нумерується і не рахується.

```typst
#copyright-page()

// За потреби можна вказати кастомний рік або текст:
#copyright-page(
  author: "Taras Shevchenko",
  year: "2026",
  content: auto, // за замовчуванням: Copyright © 2026 by Taras Shevchenko \ Всі права захищено
)
```

---

### 5. Лист схвалення комісією — `#approval-page()` (Exhibit D)

Автоматично генерує блок підписів для наукового керівника, другого рецензента, третього рецензента (якщо є), директора програми DMin, декана семінарії та дати схвалення.

```typst
#approval-page()
```

---

### 6. Сторінка присвяти — `#dedication-page(...)`

Необов'язкова сторінка з курсивним текстом по центру (стор. iii):

```typst
#dedication-page[
  Присвячується моїй родині...
]
```

---

### 7. Зміст — `#dmin-toc(...)` (Exhibit E)

Генерує зміст із точками лідерів, нависаючими відступами для підзаголовків та опцією приховування номера сторінки:

```typst
#dmin-toc()

// Якщо потрібно приховати номер сторінки на самому аркуші змісту:
#dmin-toc(show-page-number: false)

// З кастомним заголовком:
#dmin-toc(title: "ЗМІСТ РОБОТИ")
```

---

### 8. Списки ілюстрацій та таблиць — `#list-of-illustrations()` та `#list-of-tables()` (Exhibit F)

За правилами AU DMin, спочатку йде **Список ілюстрацій**, а потім **Список таблиць**. Якщо обидва списки короткі, вони розміщуються **на одній сторінці**:

```typst
#list-of-illustrations()
#list-of-tables(pagebreak: false) // розміщує таблиці на тій самій сторінці

// Якщо таблиць багато і потрібна окрема сторінка:
#list-of-tables(pagebreak: true)
```

---

### 9. Список скорочень — `#list-of-abbreviations(...)` (Exhibit G)

```typst
#list-of-abbreviations(items: (
  ("AUSS", "Andrews University Seminary Studies"),
  ("BDAG", "Bauer, Danker, Arndt, and Gingrich, Greek-English Lexicon"),
  ("GC", "General Conference of Seventh-day Adventists"),
))
```

---

### 10. Передмова / Подяки — `#preface-page(...)` (Exhibit H)

```typst
#preface-page(title: auto)[
  Текст подяк або передмови...
]
```

---

### 11. Розділи дисертації — `#dmin-chapter(...)` (Exhibit I)

Починає нову сторінку з відступом 2.0" від верхнього краю та генерує заголовок `РОЗДІЛ N` (або `CHAPTER N`):

```typst
#dmin-chapter(
  title: "Використання науки в богослов'ї: \ Вступ та історичний контекст",
)
```

> **Підказка**: Щоб вручну перенести довгу назву розділу на новий рядок, використовуйте `\ `.

---

### 12. Ієрархія підзаголовків (AU Subheadings Levels 1–5)

| Рівень AU | Команда у Typst | Форматування | Приклад |
|---|---|---|---|
| **Level 1** | `#heading(level: 2)[...]` | По центру, **Жирний**, Title Case | `#heading(level: 2)[Вступ]` |
| **Level 2** | `#heading(level: 3)[...]` | По центру, Звичайний, Title Case | `#heading(level: 3)[Межі науки \ та віри]` |
| **Level 3** | `#heading(level: 4)[...]` | По лівому краю, **Жирний**, Title Case | `#heading(level: 4)[Природа богослов'я]` |
| **Level 4** | `#heading(level: 5)[...]` | По лівому краю, Звичайний, Sentence case | `#heading(level: 5)[Інновації в освіті]` |
| **Level 5** | `#subhead5[Заголовок][Текст...]` | В підбір (врізний), **Жирний.**, 0.5" відступ | `#subhead5[Студенти][Текст абзацу...]` |

---

### 13. Блокова цитата — `#blockquote[...]`

Для цитат від 5 рядків (одинарний інтервал, відступ 0.25", подвійний інтервал до і після):

```typst
#blockquote[
  Текст розлогої цитати... @gilkey1989[p. 11]
]
```

---

### 14. Таблиці — `#dmin-table(...)`

```typst
#dmin-table(
  number: 1, // або auto
  title: "Фактори впливу на вибір студентів \ програми DMin (N = 24)",
  table(
    columns: (3.2in, 1.5in),
    stroke: (x, y) => if y == 0 { (bottom: 1pt + black, top: 1pt + black) } 
                      else if y == 4 { (bottom: 1pt + black) } else { none },
    align: (left, right),
    [#text(weight: "bold")[Критерій]], [#text(weight: "bold")[Відсоток (%)]],
    [Гнучкий графік], [30.2],
    [Якість наставництва], [22.1],
  ),
  note: [Примітка. Дані опитування когорти DMin, літо 2026.],
)
```

---

### 15. Рисунки та ілюстрації — `#dmin-figure(...)`

```typst
#dmin-figure(
  number: 1, // або auto
  caption: "Концептуальна модель інтеграційного \ пасторського формування",
  rect(width: 4.5in, height: 1.5in, stroke: 1pt + luma(100), radius: 4pt)[
    #align(center + horizon)[Діаграма або графік]
  ],
  source: [Джерело: Адаптовано з керівництва з лідерства.],
)
```

---

### 16. Додатки — `#appendix-section(...)` (Exhibit E & Ch. 2 p. 11)

Підтримуються два варіанти оформлення згідно з правилами Andrews University:

#### Варіант А: З окремим титульним аркушем-роздільником (`cover-sheet: true`)
Створює титульний аркуш із заголовком по центру сторінки (`ДОДАТОК A \ НАЗВА`), а сам контент додатку починається на наступній сторінці без дублювання заголовка:
```typst
#appendix-section(title: "ОПИТУВАЛЬНИК ДОСЛІДЖЕННЯ", cover-sheet: true)[
  #heading(level: 2)[Інструмент опитування]
  Текст анкети...
]
```

#### Варіант Б: Без титульного аркуша (`cover-sheet: false` — за замовчуванням)
Додаток починається безпосередньо зверху нової сторінки (відступ 2.0" від верхнього краю):
```typst
#appendix-section(title: "ОФІЦІЙНІ ДОЗВОЛИ")[
  Текст документа або скановані форми...
]
```

---

### 17. Список використаних джерел — `#dmin-bibliography(...)`

```typst
#dmin-bibliography(
  "../example/references.bib", 
  title: auto, // за замовчуванням: "СПИСОК ВИКОРИСТАНИХ ДЖЕРЕЛ" або "REFERENCE LIST"
  style: "../csl/andrews-university-dmin-author-date.csl",
)
```

---

### 18. Відомості про автора (Vita) — `#vita-page(...)`

```typst
#vita-page()[
  #grid(
    columns: (1.5in, 1fr),
    row-gutter: 12pt,
    [Personal:], [Born in Kyiv, Ukraine. Married with two children.],
    [Education:], [
      - D.Min. in Leadership, Andrews University, 2026.
      - M.Div., Andrews University Theological Seminary, 2018.
    ],
    [Experience:], [
      - Senior Pastor, Central Church, 2018--present.
    ],
  )
]
```

---

## 📚 Як робити посилання на джерела (Цитування та бібліографія)

Шаблон використовує систему **Author-Date** стандарту **Turabian 8th/9th ed. / Chicago 17th ed.** у повній відповідності до вимог **AU DMin Writing Manual (Chapter 4 & 5)** через фірмовий CSL-стиль `csl/andrews-university-dmin-author-date.csl`.

---

### 1. Формати цитування у тексті Typst

У Typst можна цитувати як стандартним способом через `@key`, так і за допомогою функції `#cite(...)` з параметром `form`:

| Тип цитування | Синтаксис у Typst | Результат у тексті | Опис / Застосування |
|---|---|---|---|
| **Звичайне посилання** | `@smith2018` | `(Smith 2018)` | Стандартне посилання в дужках |
| **Зі сторінкою** | `@smith2018[p. 45]` або `@smith2018[с. 45]` | `(Smith 2018, 45)` | Посилання на конкретну сторінку |
| **З діапазоном сторінок** | `@smith2018[pp. 45-48]` | `(Smith 2018, 45–48)` | Посилання на діапазон сторінок |
| **З томом і сторінкою** | `@calvin1960[20:45]` | `(Calvin 1960, 20:45)` | Багатотомні видання |
| **Тільки рік** (автор у тексті) | `#cite(<smith2018>, form: "year")` | `2018` | Коли автора названо в реченні |
| **Тільки автор** | `#cite(<smith2018>, form: "author")` | `Smith` | Виводить тільки прізвище автора |
| **Розповідне (Prose)** | `#cite(<smith2018>, form: "prose")` | `Smith (2018)` | Автор поза дужками, рік у дужках |
| **Розповідне зі сторінкою** | `#cite(<smith2018>, form: "prose", supplement: [45])` | `Smith (2018, 45)` | Зручно для початку речення |
| **Декілька джерел разом** | `#cite(<smith2018>, <craigie1983>)` | `(Smith 2018; Craigie 1983)` | Кілька посилань через крапку з комою |
| **З префіксом** (*див.*, *пор.*) | `#cite(<smith2018>, prefix: [див. ], supplement: [с. 12])` | `(див. Smith 2018, 12)` | Посилання з ввідними словами |
| **У блоковій цитаті** | `#blockquote[Текст... @gilkey1989[p. 11]]` | `... (Gilkey 1989, 11)` | Оформлення довгих цитат |

> **💡 Приклад використання `form: "year"` та `form: "prose"` у тексті**:
> ```typst
> // Варіант 1: Автор у тексті, рік у дужках
> Як переконливо доводить Крейгі (#cite(<craigie1983>, form: "year", supplement: [с. 15])), угаритські тексти...
> // Результат: Як переконливо доводить Крейгі (1983, 15), угаритські тексти...
> 
> // Варіант 2: Розповідна форма (prose)
> Дослідження #cite(<gordiienko_2019>, form: "prose", supplement: [с. 40]) демонструє урбаністичні тенденції...
> // Результат: Дослідження Гордієнко (2019, 40) демонструє урбаністичні тенденції...
> ```

---

### 2. Особливі правила цитування за стандартом AU DMin

1. **Книги за редакцією (Edited Books)**:
   - У тексті вказується **тільки прізвище редактора без позначки `ed.` або `ред.`**: `(Гордієнко 2019)`.
   - У списку літератури автоматично додається повний опис: `Гордієнко, Н. М., ред. 2019.` (для EN: `Gordiienko, N. M., ed. 2019.`).
2. **Кількість авторів**:
   - **1–3 автори**: перелічуються всі прізвища (`(Smith, Jones, and Brown 2020)` / `(Сміт, Джонс і Браун 2020)`).
   - **4 і більше авторів**: виводиться перший автор + `et al.` / `та ін.` (`(Glaser et al. 1968)` / `(Глазер та ін. 1968)`).
3. **Повторення того самого автора підряд у Списку джерел**:
   - Якщо в списку літератури йде кілька праць одного автора, починаючи з другої праці ім'я замінюється на **3-em dash** (`———.`):
     ```
     Andrews University. 2019. Doctor of Ministry Project Writing Manual.
     ———. 2024. Seminary Guidelines.
     ```
4. **Електронні ресурси (URL)**:
   - Дата доступу передує посиланню: `Дата звернення 25 серпень 2026. https://...` (для EN: `Accessed August 25, 2026. https://...`).

---

### 3. Підключення списку використаних джерел

У кінці документа (після додатків або основного тексту) викликається функція `#dmin-bibliography(...)`:

```typst
#dmin-bibliography(
  "../example/references.bib", 
  title: auto, // Автоматично: "СПИСОК ВИКОРИСТАНИХ ДЖЕРЕЛ" (UK) або "REFERENCE LIST" (EN)
  style: "../csl/andrews-university-dmin-author-date.csl",
)
```

---

### 4. Зразки оформлення джерел у файлі `.bib`

Для кожного запису рекомендується додавати поле `language = {ukrainian}` або `language = {english}`.

#### а) Книга з одним або кількома авторами (`@book`)
```bibtex
@book{craigie1983,
  author    = {Peter C. Craigie},
  title     = {Ugarit and the Old Testament},
  publisher = {William B. Eerdmans},
  address   = {Grand Rapids, MI},
  year      = {1983},
  language  = {english}
}
```

#### б) Книга за редакцією (`editor`)
```bibtex
@book{gordiienko_2019,
  editor    = {Гордієнко, Н. М.},
  title     = {Соціологія міста: Навчальний посібник},
  publisher = {Видавництво Ліра-К},
  address   = {Київ},
  year      = {2019},
  language  = {ukrainian}
}
```

#### в) Стаття у науковому журналі (`@article`)
```bibtex
@article{vashchynin_2024,
  author    = {Ващинін, Сергій},
  title     = {Науково-богословський діалог у пасторській практиці},
  journal   = {Український богословський вісник},
  volume    = {12},
  number    = {2},
  pages     = {45--62},
  year      = {2024},
  language  = {ukrainian}
}
```

#### г) Розділ у збірнику статей або колективній монографії (`@incollection`)
```bibtex
@incollection{gilkey1989,
  author    = {Langdon Gilkey},
  title     = {The Creationist Issue: A Theologian's Perspective},
  booktitle = {Creationism and the Law},
  editor    = {Marcel C. LaFollette},
  publisher = {MIT Press},
  address   = {Cambridge, MA},
  pages     = {11--34},
  year      = {1989},
  language  = {english}
}
```

#### ґ) Дисертація чи магістерський проєкт (`@phdthesis` / `@thesis`)
```bibtex
@phdthesis{vashchynin_dmin_2026,
  author    = {Ващинін, Сергій},
  title     = {Інтеграційна модель пасторського служіння в умовах технологічних викликів},
  school    = {Seventh-day Adventist Theological Seminary, Andrews University},
  address   = {Berrien Springs, MI},
  year      = {2026},
  type      = {Професійна дисертація D.Min.},
  language  = {ukrainian}
}
```

#### д) Веб-сайт, інтернет-публікація чи інструкція (`@misc` / `@online`)
```bibtex
@misc{andrews_manual_2024,
  author    = {{Andrews University}},
  title     = {Doctor of Ministry Project Writing Manual},
  year      = {2024},
  url       = {https://www.andrews.edu/sem/dmin/project/},
  urldate   = {2026-08-25},
  language  = {ukrainian}
}
```

---

### 5. 📥 Експорт джерел із Zotero у Typst

Система **Typst** безпосередньо зчитує бібліографічні бази даних у форматі **BibTeX (`.bib`)**. Ви можете легко експортувати бібліотеку або окрему папку із бібліографічного менеджера **Zotero**:

#### Варіант А: Одноразовий експорт (Стандартний Zotero)
1. У Zotero клікніть правою кнопкою миші на потрібну **Колекцію** або **My Library**.
2. Оберіть пункт **«Export Collection...»** (Експортувати колекцію).
3. У полі **Format** (Формат) виберіть: **`BibTeX`** або **`Better BibTeX`**.
4. Переконайтеся, що встановлено кодування **`Unicode (UTF-8)`**.
5. Збережіть файл під назвою `references.bib` у папку вашого проєкту (наприклад, `example/references.bib`).

#### Варіант Б: Автоматична Live-синхронізація (Рекомендовано через Better BibTeX)
Якщо ви регулярно додаєте джерела під час написання дисертації, плагін **Better BibTeX for Zotero** дозволяє тримати файл `.bib` завжди оновленим:
1. Встановіть плагін [Better BibTeX for Zotero](https://retorque.re/zotero-better-bibtex/).
2. Клікніть правою кнопкою на колекцію $\rightarrow$ **«Export Collection...»**.
3. Оберіть формат **`Better BibLaTeX`** або **`Better BibTeX`**.
4. Поставте прапорець **☑ «Keep updated»** (Тримати оновленим / Автоекспорт).
5. Збережіть файл у папку проєкту.
   - *Тепер щоразу, коли ви додаєте або змінюєте джерело в Zotero, файл `.bib` автоматично перезберігається, а Typst у режимі `typst watch` миттєво оновлює PDF-документ!*

#### 💡 Порада для багатомовних джерел у Zotero:
- У Zotero в полі **Language** (Мова) для українських джерел вказуйте `uk` або `ukrainian`, а для англійських — `en` або `english`.
- При експорті це поле автоматично запишеться у `.bib` як `language = {ukrainian}`, і стиль цитування AU DMin самостійно застосує правильні правила та локалізовані терміни (`ред.`, `с.`, `т.`, `дата звернення`).

---

## 📄 Ліцензія

MIT License. Розроблено для здобувачів наукових ступенів та викладачів програми Doctor of Ministry Andrews University.
