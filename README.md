# 🎓 Andrews University (AU) Doctor of Ministry (DMin) — Typst Template & CSL System

> 🌐 **Language / Мова**: **English** | [Українська](README_UKR.md)

An official modular template for formatting doctoral project dissertations, proposals, and academic research in **Typst** according to the requirements of the **Doctor of Ministry Project Writing Manual (Andrews University, 4th Edition, August 2019)** and the **Turabian 8th/9th ed. (Author-Date / Chicago 17th ed.)** standard.

---

## 🌟 Key Features

- **Full Conformance to AU DMin Manual (4th ed.)**:
  - **Page Geometry**: **1.5"** left margin (for binding), **1.0"** top, bottom, and right margins. Major section/chapter first pages start at **2.0"** from the top edge.
  - **Spacing & Alignment**: Double-spaced text (24 pt baseline = 12 pt font + 12 pt leading), **0.5"** first-line paragraph indent, ragged right margin (not justified).
  - **Andrews University 5-Level Subheading Hierarchy** with automated spacing collapse.
  - **Complete Preliminary Pages**: Blank flyleaves, Abstract Title & 4-section Abstract Body, Title Page, Copyright Page, Approval Page, Dedication, Table of Contents, List of Illustrations, List of Tables, List of Abbreviations, Preface, and Vita.
- **Multilingual Support (i18n)**:
  - Supports 5 languages: **English (`en`)**, **Ukrainian (`uk`)**, **Russian (`ru`)**, **French (`fr`)**, and **Spanish (`es`)**.
  - Automatically translates all section headings, table/figure captions, preliminary pages, and bibliographic terms based on the document or entry language.
- **Centralized Metadata Management (`state`)**:
  - All project metadata (title, author, degree, advisor, second reader, third reader, program director, seminary dean, completion date, school) is defined **once** at the beginning of the document and automatically inherited by all preliminary pages.
- **Smart Table of Contents & Lists**:
  - Perfectly aligned leader dots (`fill-dots`) ending at a uniform vertical column regardless of page digit width (`1`, `24`, `150`, `iv`).
  - Hanging indents (`hanging-indent`) for multi-line subheadings.
  - Support for manual line breaks (`\ ` or `#linebreak()`) in titles, subheads, tables, and figures with proper indentation across text and TOC.

---

## 📂 Modular Project Structure

```
.
├── typ/                                              # ⚙️ TEMPLATE MODULES
│   ├── state.typ                                     # Global states & metadata (au-dmin-meta)
│   ├── i18n.typ                                      # Localized dictionaries for 5 languages
│   ├── layout.typ                                    # Page geometry, typography, show rules, TOC
│   ├── preliminary.typ                               # Preliminary pages (Title, Abstract, Approval, Vita, etc.)
│   ├── elements.typ                                  # Structural blocks (Chapter, Subhead5, Table, Figure, Appendix)
│   └── au-dmin.typ                                   # Root entry point (re-exports all modules)
├── csl/                                              # 📑 CITATION STYLES
│   ├── andrews-university-dmin-author-date.csl       # Multilingual AU DMin Author-Date style
│   ├── turabian-author-date.csl                      # Standard Turabian Author-Date (Chicago 17th ed.)
│   ├── chicago-author-date.csl                       # Chicago 18th ed. Author-Date
│   └── turabian-notes-bibliography.csl               # Turabian Notes-Bibliography (footnotes)
├── example/                                          # 📄 SAMPLE PROJECT
│   ├── main.typ                                      # Complete sample dissertation in Typst
│   ├── references.bib                                # Sample BibTeX bibliography
│   └── Vashchynin_сhapter_3/                         # Real dissertation chapter sample
├── doc/                                              # 📚 Official AU Documentation
├── README.md                                         # 📖 This documentation (English)
├── README_UKR.md                                     # 📖 Ukrainian documentation
├── typst.toml                                        # 📦 Typst package manifest
└── LICENSE                                           # ⚖️ MIT License
```

---

## 🚀 Step-by-Step Installation Guide

This guide will help you set up the environment and start writing your dissertation on any new computer (**Windows, macOS, or Linux**).

---

### Step 1. Install Typst

**Typst** is a modern, fast document compiler written in Rust.

#### 🪟 Windows:
Open **PowerShell** or **Command Prompt** and run one of the following:
```powershell
# Option 1 (via Windows Package Manager — Recommended):
winget install --id Typst.Typst

# Option 2 (via Chocolatey):
choco install typst

# Option 3 (via Scoop):
scoop install typst
```
*(Or download the `.zip` binary from [Typst GitHub Releases](https://github.com/typst/typst/releases) and add `typst.exe` to your PATH).*

#### 🍏 macOS:
Open **Terminal** and install via [Homebrew](https://brew.sh):
```bash
brew install typst
```

#### 🐧 Linux (Ubuntu / Debian / Arch):
```bash
# Ubuntu / Debian (via Snap):
sudo snap install typst --classic

# Arch Linux:
sudo pacman -S typst

# Or universal Rust Cargo installation:
cargo install --locked typst-cli
```

*Verify installation:*
```bash
typst --version
# Should output: typst 0.11.x (or newer)
```

---

### Step 2. Clone the Repository from GitHub

Open your terminal in your desired project directory (e.g., `Documents` or `Dev`):

```bash
# 1. Clone repository
git clone https://github.com/skakadu007/au_dmin_typst.git

# 2. Enter project folder
cd au_dmin_typst
```

---

### Step 3. Configure Your Editor (VS Code — Recommended)

For syntax highlighting, code completion, and instant side-by-side live PDF preview:

1. Download and install [Visual Studio Code](https://code.visualstudio.com/).
2. Open VS Code and install the **[Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamit.tinymist)** extension (`Ctrl+Shift+X` $\rightarrow$ search `Tinymist`).
3. Open the project folder in VS Code:
   ```bash
   code .
   ```
4. Open `example/main.typ` and click the **«Show Preview»** button in the top-right corner of the editor (or press `Ctrl+K V`).
   - *A live PDF preview will appear side-by-side, updating in real time as you type!*

---

### Step 4. Font Verification

The Andrews University manual requires **Times New Roman** (12 pt).
- **Windows & macOS**: Installed by default.
- **Linux**: If you see `warning: unknown font family: times new roman`, install Microsoft Core Fonts:
  ```bash
  sudo apt install ttf-mscorefonts-installer fonts-liberation
  ```

---

### Step 5. Setting Up Your Dissertation

1. The main entry point for your dissertation is `example/main.typ`. You can edit it directly or create a copy.
2. Configure your dissertation metadata at the top of the file:
   ```typst
   #import "typ/au-dmin.typ": *

   #show: au-dmin.with(
     title: "YOUR DISSERTATION TITLE IN ALL CAPS",
     author: "Your Full Name",
     degree: "Doctor of Ministry",
     advisor: "Advisor Name, Ph.D.",
     second-reader: "Second Reader Name, D.Min.",
     third-reader: none, // or "Reader Name, Ph.D."
     program-director: "Stanley E. Patterson, Ph.D.",
     dean: "Jiří Moskala, Th.D., Ph.D.",
     date: "August 2026",
     lang: "en", // "en" (English) or "uk" (Ukrainian), "ru", "fr", "es"
   )
   ```
3. Add your references to `example/references.bib` (or export from Zotero).

---

### Step 6. Compiling to PDF via Terminal

From the root project directory (`au_dmin_typst`):

```bash
# 1. Single compile:
typst compile --root . example/main.typ example/main.pdf

# 2. Live Watch mode (recompiles automatically on save):
typst watch --root . example/main.typ example/main.pdf
```

> **⚠️ IMPORTANT**: Always include the `--root .` flag so Typst can locate the `typ/` modules and `csl/` styles.

---

## 📖 Component & Function Reference

Below is the complete reference of all available components with their parameters and defaults.

---

### 1. Blank Flyleaf Page — `#blank-page()`

Used as the **first** and **last** page of the bound dissertation (binding requirement). It is unnumbered, uncounted, and has no headers or footers.

```typst
#blank-page()
```

---

### 2. Abstract — Exhibits A & B

The Abstract consists of two parts (unnumbered and uncounted):

#### a) Abstract Title Page — `#abstract-title-page(...)`
Automatically retrieves the title, author, and advisor from `au-dmin`:
```typst
#abstract-title-page()

// Optional manual overrides:
#abstract-title-page(
  title: "CUSTOM TITLE",
  author: "Author Name",
  adviser: "Advisor Name",
  title-lines: 2, // If >= 3 lines, leading is compressed automatically
)
```

#### b) Abstract Body with 4 Sections — `#abstract-body(...)`
```typst
#abstract-body(
  problem: [Statement of the problem...],
  method: [Research methodology...],
  results: [Empirical findings...],
  conclusions: [Conclusions and ministry implications...],
)
```

---

### 3. Title Page — `#title-page()` (Exhibit C)

Positions the university block at 2.5", title at 4.5", degree presentation at 6.0", and author/date at 8.5" from the top edge.

```typst
#title-page()
```

---

### 4. Copyright Page — `#copyright-page(...)`

Placed immediately **after the Title Page** and **before the Approval Page**. Unnumbered and uncounted.

```typst
#copyright-page()

// Optional customization:
#copyright-page(
  author: "Author Name",
  year: "2026",
  content: auto, // Default: © Copyright by Author Name 2026 \ All Rights Reserved
)
```

---

### 5. Approval Page — `#approval-page()` (Exhibit D)

Automatically generates signature lines for the Advisor, Second Reader, Third Reader (if present), Program Director, Seminary Dean, and Approval Date.

```typst
#approval-page()
```

---

### 6. Dedication Page — `#dedication-page(...)`

Optional preliminary page with centered italicized text (p. iii):

```typst
#dedication-page[
  Dedicated to my family...
]
```

---

### 7. Table of Contents — `#dmin-toc(...)` (Exhibit E)

Generates the Table of Contents with leader dots, hanging indents for subheadings, and optional page number suppression:

```typst
#dmin-toc()

// Hide page number on the TOC page itself:
#dmin-toc(show-page-number: false)

// Custom TOC title:
#dmin-toc(title: "TABLE OF CONTENTS")
```

---

### 8. List of Illustrations & List of Tables — `#list-of-illustrations()` & `#list-of-tables()` (Exhibit F)

Per the AU DMin Manual, the **List of Illustrations** comes first, followed by the **List of Tables**. If short, both share a single page:

```typst
#list-of-illustrations()
#list-of-tables(pagebreak: false) // Keeps tables on the same page as illustrations

// If there are many tables requiring a separate page:
#list-of-tables(pagebreak: true)
```

---

### 9. List of Abbreviations — `#list-of-abbreviations(...)` (Exhibit G)

```typst
#list-of-abbreviations(items: (
  ("AUSS", "Andrews University Seminary Studies"),
  ("BDAG", "Bauer, Danker, Arndt, and Gingrich, Greek-English Lexicon"),
  ("GC", "General Conference of Seventh-day Adventists"),
))
```

---

### 10. Preface / Acknowledgments — `#preface-page(...)` (Exhibit H)

```typst
#preface-page(title: auto)[
  Text of acknowledgments or preface...
]
```

---

### 11. Dissertation Chapters — `#dmin-chapter(...)` (Exhibit I)

Starts a new page at 2.0" from the top edge and generates the `CHAPTER N` heading:

```typst
#dmin-chapter(
  title: "The Use of Science in Theology: \ Introduction and Historical Background",
)
```

> **Tip**: Use `\ ` to manually break long chapter titles into an inverted pyramid shape.

---

### 12. Subheading Hierarchy (AU Levels 1–5)

| AU Level | Typst Syntax | Formatting | Example |
|---|---|---|---|
| **Level 1** | `#heading(level: 2)[...]` | Centered, **Bold**, Title Case | `#heading(level: 2)[Introduction]` |
| **Level 2** | `#heading(level: 3)[...]` | Centered, Regular (not bold), Title Case | `#heading(level: 3)[The Limits of Science]` |
| **Level 3** | `#heading(level: 4)[...]` | Left margin, **Bold**, Title Case | `#heading(level: 4)[Nature of Theology]` |
| **Level 4** | `#heading(level: 5)[...]` | Left margin, Regular (not bold), Sentence case | `#heading(level: 5)[Curricular innovations]` |
| **Level 5** | `#subhead5[Heading][Text...]` | Run-in paragraph, **Bold.**, 0.5" indent | `#subhead5[Students][Paragraph text...]` |

---

### 13. Block Quotations — `#blockquote[...]`

For quotations of 5 lines or more (single-spaced, 0.25" left indent, double-spaced before and after):

```typst
#blockquote[
  Extended quotation text... @gilkey1989[p. 11]
]
```

---

### 14. Tables — `#dmin-table(...)`

```typst
#dmin-table(
  number: 1, // or auto
  title: "Factors Influencing Student Program Selection (N = 24)",
  table(
    columns: (3.2in, 1.5in),
    stroke: (x, y) => if y == 0 { (bottom: 1pt + black, top: 1pt + black) } 
                      else if y == 4 { (bottom: 1pt + black) } else { none },
    align: (left, right),
    [#text(weight: "bold")[Criterion]], [#text(weight: "bold")[Percentage (%)]],
    [Flexible schedule], [30.2],
    [Mentorship quality], [22.1],
  ),
  note: [Note. Data from DMin cohort survey, Summer 2026.],
)
```

---

### 15. Figures & Illustrations — `#dmin-figure(...)`

```typst
#dmin-figure(
  number: 1, // or auto
  caption: "Conceptual Model of Integrative \ Pastoral Formation",
  rect(width: 4.5in, height: 1.5in, stroke: 1pt + luma(100), radius: 4pt)[
    #align(center + horizon)[Diagram or Chart Image]
  ],
  source: [Source: Adapted from Leadership Guide.],
)
```

---

### 16. Appendices — `#appendix-section(...)` (Exhibit E & Ch. 2 p. 11)

Supports both formats defined by Andrews University:

#### Option A: With Divider Cover Sheet (`cover-sheet: true`)
Creates a centered divider sheet (`APPENDIX A \ TITLE`), with appendix content starting on the following page without duplicating the header:
```typst
#appendix-section(title: "RESEARCH QUESTIONNAIRE", cover-sheet: true)[
  #heading(level: 2)[Survey Instrument]
  Questionnaire contents...
]
```

#### Option B: Without Cover Sheet (`cover-sheet: false` — default)
The appendix starts directly at the top of a new page (2.0" top margin):
```typst
#appendix-section(title: "LETTERS OF PERMISSION")[
  Official documentation text...
]
```

---

### 17. Reference List / Bibliography — `#dmin-bibliography(...)`

```typst
#dmin-bibliography(
  "../example/references.bib", 
  title: auto, // Defaults to "REFERENCE LIST" (EN) or "СПИСОК ВИКОРИСТАНИХ ДЖЕРЕЛ" (UK)
  style: "../csl/andrews-university-dmin-author-date.csl",
)
```

---

### 18. Vita Page — `#vita-page(...)`

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

## 📚 How to Cite Sources (Citations & Bibliography)

The template utilizes the **Author-Date** style of **Turabian 8th/9th ed. / Chicago 17th ed.** in full compliance with **AU DMin Writing Manual (Chapters 4 & 5)** via the custom CSL style `csl/andrews-university-dmin-author-date.csl`.

---

### 1. In-Text Citation Formats in Typst

You can cite sources using standard `@key` syntax or using the `#cite(...)` function with the `form` parameter:

| Citation Type | Typst Syntax | Result in Text | Description / Use Case |
|---|---|---|---|
| **Parenthetical** | `@smith2018` | `(Smith 2018)` | Standard parenthetical reference |
| **With Page Number** | `@smith2018[p. 45]` | `(Smith 2018, 45)` | Specific page reference |
| **With Page Range** | `@smith2018[pp. 45-48]` | `(Smith 2018, 45–48)` | Multi-page range |
| **With Volume & Page** | `@calvin1960[20:45]` | `(Calvin 1960, 20:45)` | Multi-volume works |
| **Year Only** (author in text) | `#cite(<smith2018>, form: "year")` | `2018` | When author is named in the sentence |
| **Author Only** | `#cite(<smith2018>, form: "author")` | `Smith` | Prints author's surname only |
| **Narrative / Prose** | `#cite(<smith2018>, form: "prose")` | `Smith (2018)` | Author in text, year in parentheses |
| **Narrative with Page** | `#cite(<smith2018>, form: "prose", supplement: [45])` | `Smith (2018, 45)` | Ideal for sentence leads |
| **Multiple Sources** | `#cite(<smith2018>, <craigie1983>)` | `(Smith 2018; Craigie 1983)` | Semicolon-separated references |
| **With Prefix** (*see*, *cf.*) | `#cite(<smith2018>, prefix: [see ], supplement: [p. 12])` | `(see Smith 2018, 12)` | Introductory words |
| **In Blockquote** | `#blockquote[Text... @gilkey1989[p. 11]]` | `... (Gilkey 1989, 11)` | Blockquote attribution |

> **💡 Example using `form: "year"` and `form: "prose"` in text**:
> ```typst
> // Option 1: Author named in sentence, year in parentheses
> As Craigie (#cite(<craigie1983>, form: "year", supplement: [p. 15])) argues, Ugaritic texts...
> // Result: As Craigie (1983, 15) argues, Ugaritic texts...
> 
> // Option 2: Prose form
> The study by #cite(<gordiienko_2019>, form: "prose", supplement: [p. 40]) demonstrates urban trends...
> // Result: The study by Gordiienko (2019, 40) demonstrates urban trends...
> ```

---

### 2. AU DMin Special Citation Rules

1. **Edited Books**:
   - In text, cite **surname only without `ed.` or `ред.`**: `(Gordiienko 2019)`.
   - In the bibliography, the full description is automatically appended: `Gordiienko, N. M., ed. 2019.`.
2. **Author Count**:
   - **1–3 authors**: all names are listed (`(Smith, Jones, and Brown 2020)`).
   - **4 or more authors**: shortened to `et al.` (`(Glaser et al. 1968)`).
3. **Repeated Authors in Bibliography (3-em dash)**:
   - Successive works by the exact same author automatically replace the name with a **3-em dash** (`———.`):
     ```
     Andrews University. 2019. Doctor of Ministry Project Writing Manual.
     ———. 2024. Seminary Guidelines.
     ```
4. **Electronic Resources (URL)**:
   - Access date precedes the URL: `Accessed August 25, 2026. https://...`.

---

### 3. Bibliography Entry Samples (`.bib`)

Include the `language = {english}` or `language = {ukrainian}` field for proper localized terms.

#### a) Book with Author (`@book`)
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

#### b) Edited Book (`editor`)
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

#### c) Journal Article (`@article`)
```bibtex
@article{vashchynin_2024,
  author    = {Serhii Vashchynin},
  title     = {Theological and Scientific Dialogue in Pastoral Practice},
  journal   = {Ukrainian Theological Journal},
  volume    = {12},
  number    = {2},
  pages     = {45--62},
  year      = {2024},
  language  = {english}
}
```

#### d) Book Chapter / Essay in Edited Volume (`@incollection`)
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

#### e) Dissertation or Thesis (`@phdthesis` / `@thesis`)
```bibtex
@phdthesis{vashchynin_dmin_2026,
  author    = {Serhii Vashchynin},
  title     = {An Integrative Model for Pastoral Leadership Amidst Technological Challenges},
  school    = {Seventh-day Adventist Theological Seminary, Andrews University},
  address   = {Berrien Springs, MI},
  year      = {2026},
  type      = {D.Min. Project Dissertation},
  language  = {english}
}
```

#### f) Website or Online Document (`@misc` / `@online`)
```bibtex
@misc{andrews_manual_2024,
  author    = {{Andrews University}},
  title     = {Doctor of Ministry Project Writing Manual},
  year      = {2024},
  url       = {https://www.andrews.edu/sem/dmin/project/},
  urldate   = {2026-08-25},
  language  = {english}
}
```

---

### 4. 📥 Exporting References from Zotero to Typst

**Typst** natively parses **BibTeX (`.bib`)** files. You can easily export your library from **Zotero**:

#### Option A: Single Export (Standard Zotero)
1. In Zotero, right-click on your **Collection** or **My Library**.
2. Select **«Export Collection...»**.
3. In the **Format** dropdown, choose: **`BibTeX`** or **`Better BibTeX`**.
4. Ensure **`Unicode (UTF-8)`** encoding is selected.
5. Save the file as `references.bib` inside your project directory (e.g., `example/references.bib`).

#### Option B: Live Auto-Sync (Recommended via Better BibTeX)
If you add references continuously, the [Better BibTeX for Zotero](https://retorque.re/zotero-better-bibtex/) plugin automatically keeps your `.bib` file updated:
1. Install **Better BibTeX for Zotero**.
2. Right-click your collection $\rightarrow$ **«Export Collection...»**.
3. Choose **`Better BibLaTeX`** or **`Better BibTeX`**.
4. Check **☑ «Keep updated»** (Auto-export).
5. Save the file into your project folder.
   - *Whenever you add or edit a reference in Zotero, the `.bib` file updates automatically, and Typst in `typst watch` mode instantly updates the PDF!*

#### 💡 Multilingual Tip for Zotero:
- In Zotero's **Language** field, specify `en` or `english` for English entries, and `uk` or `ukrainian` for Ukrainian entries.
- The AU DMin CSL style will automatically apply the correct language rules and terms (`ed.`, `pp.`, `vol.`, `Accessed` vs `ред.`, `с.`, `т.`, `дата звернення`).

---

## 📄 License

MIT License. Developed for doctoral candidates and faculty of the Doctor of Ministry program at Andrews University.
