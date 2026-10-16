// ==============================================================================
// 📄 AU DMin Preliminary Pages (Chapter 7, Exhibits A–H)
// Automatically retrieves metadata from au-dmin-meta unless overridden
// ==============================================================================

#import "state.typ": *
#import "i18n.typ": *
#import "layout.typ": (
  count-title-lines, format-title, get-title-leading, word-double-leading, word-single-leading, word-space-skip-1,
  word-space-skip-2, word-space-skip-3,
)

/// Blank Flyleaf Page (First and Last page of bound dissertation)
/// Completely empty, unnumbered, and uncounted
#let blank-page() = {
  page(header: none, footer: none)[]
}

/// Exhibit A: Abstract Title Page
/// Inch indicators in Exhibit A (3", 4", 6", 7") are measured from the top edge of the paper.
/// Since top page margin is 1.0in, dy values are (target_inch - 1.0in).
#let abstract-title-page(
  title: auto,
  author: auto,
  adviser: auto,
  title-lines: auto,
) = {
  pagebreak(weak: true)
  set page(footer: none)
  context {
    let meta = au-dmin-meta.get()
    let s = dmin-get-strings(au-dmin-lang.get())

    let raw-title = if title != auto { title } else { meta.title }
    let disp-author = if author != auto { author } else { meta.author }
    let disp-adviser = if adviser != auto { adviser } else { meta.advisor }

    let formatted-title = format-title(raw-title, to-upper: true)
    let title-leading = get-title-leading(formatted-title, title-lines, width: 5.5in)

    // [3" from top edge] = dy: 2.0in (1.0in top margin + 2.0in)
    place(top + left, dy: 2.0in)[
      #block(width: 100%)[
        #set align(center)
        #set par(leading: word-single-leading, first-line-indent: 0pt)
        #text(size: 12pt)[#s.abstract]
      ]
    ]

    // [4" from top edge] = dy: 3.0in (1.0in top margin + 3.0in)
    place(top + left, dy: 3.0in)[
      #block(width: 100%)[
        #set align(center)
        #block(width: 5.5in)[
          #set par(leading: title-leading, spacing: title-leading, first-line-indent: 0pt, justify: false)
          #set text(size: 12pt)
          #formatted-title
        ]
      ]
    ]

    // [6" from top edge] = dy: 5.0in (1.0in top margin + 5.0in)
    place(top + left, dy: 5.0in)[
      #block(width: 100%)[
        #set align(center)
        #set text(size: 12pt)
        #set par(leading: word-single-leading, first-line-indent: 0pt)
        #if s.by != "" [
          #block(above: 0pt, below: word-double-leading)[#s.by]
        ]
        #block(above: 0pt, below: 0pt)[#disp-author]
      ]
    ]

    // [7" from top edge] = dy: 6.0in (1.0in top margin + 6.0in) — Flush left per Exhibit A
    place(top + left, dy: 6.0in)[
      #block(width: 100%)[
        #set align(left)
        #set par(leading: word-single-leading, first-line-indent: 0pt)
        #text(size: 12pt)[#s.adviser #disp-adviser]
      ]
    ]
  }
  pagebreak()
}

/// Exhibit B: Abstract Body
/// Header starts at 2" from top edge (1.0in margin + 1.0in v).
/// "Title:" starts at exactly 4" from top edge (after a 2.0in header container).
#let abstract-body(
  title: auto,
  author: auto,
  degree: auto,
  university: auto,
  school: auto,
  date: auto,
  adviser: auto,
  problem: [],
  method: [],
  results: [],
  conclusions: [],
) = {
  pagebreak(weak: true)
  set page(footer: none)
  context {
    let meta = au-dmin-meta.get()
    let s = dmin-get-strings(au-dmin-lang.get())

    let raw-title = if title != auto { title } else { meta.title }
    let disp-author = if author != auto { author } else { meta.author }
    let disp-degree = if degree != auto { degree } else { meta.degree }
    let disp-univ = if university != auto { university } else { meta.university }
    let disp-school = if school != auto { school } else { meta.school }
    let disp-date = if date != auto { date } else { meta.date }
    let disp-adviser = if adviser != auto { adviser } else { meta.advisor }

    let formatted-title = format-title(raw-title, to-upper: true)

    v(1.0in) // 2.0" from top edge of paper
    block(width: 100%, height: 2.0in, above: 0pt, below: 0pt)[
      #align(center)[
        #set par(leading: word-single-leading, spacing: word-single-leading, first-line-indent: 0pt)
        #block(above: 0pt, below: word-space-skip-1)[#s.abstract_header]
        #block(above: word-space-skip-1, below: word-space-skip-2)[#s.dissertation_type]
        #block(above: word-space-skip-2, below: word-space-skip-1)[#disp-univ]
        #block(above: word-space-skip-1, below: 0pt)[#disp-school]
      ]
    ]
    // Starts at exactly 4.0" from top edge of paper (1.0in margin + 1.0in v + 2.0in block)
    block(width: 100%, above: 0pt, below: word-space-skip-2)[
      #set par(leading: word-single-leading, spacing: word-single-leading, first-line-indent: 0pt, justify: false)
      #grid(
        columns: 100%,
        row-gutter: word-space-skip-1,
        grid(
          columns: (auto, 1fr),
          column-gutter: 0.4em,
          [#s.title_label], [#formatted-title],
        ),
        [#s.researcher_name #disp-author],
        [#s.adviser_name_degree #disp-adviser],
        [#s.date_completed #disp-date],
      )
    ]

    set par(
      leading: word-double-leading,
      spacing: word-double-leading,
      first-line-indent: (amount: 0.5in, all: true),
      justify: false,
    )

    block(width: 100%, above: word-space-skip-2, below: word-space-skip-1, sticky: true)[
      #align(center)[#text(size: 12pt, weight: "regular")[#s.problem]]
    ]
    problem

    block(width: 100%, above: word-space-skip-2, below: word-space-skip-1, sticky: true)[
      #align(center)[#text(size: 12pt, weight: "regular")[#s.method]]
    ]
    method

    block(width: 100%, above: word-space-skip-2, below: word-space-skip-1, sticky: true)[
      #align(center)[#text(size: 12pt, weight: "regular")[#s.results]]
    ]
    results

    block(width: 100%, above: word-space-skip-2, below: word-space-skip-1, sticky: true)[
      #align(center)[#text(size: 12pt, weight: "regular")[#s.conclusions]]
    ]
    conclusions
  }
  pagebreak()
}

/// Exhibit C: Title Page
#let title-page(
  title: auto,
  author: auto,
  degree: auto,
  month-year: auto,
  university: auto,
  school: auto,
  title-lines: auto,
  title_page_pres_1: auto,
  title_page_pres_2: auto,
  title_page_pres_3: auto,
  date: auto,
) = context {
  let meta = au-dmin-meta.get()
  let s = dmin-get-strings(au-dmin-lang.get())

  let raw-title = if title != auto { title } else { meta.title }
  let disp-author = if author != auto { author } else { meta.author }
  let disp-degree = if degree != auto { degree } else { meta.degree }
  let disp-date = if date != auto { date } else if month-year != auto { month-year } else { meta.date }
  let disp-univ = if university != auto { university } else { meta.university }
  let disp-school = if school != auto { school } else { meta.school }

  let disp-pres-1 = if title_page_pres_1 != auto {
    title_page_pres_1
  } else if "title_page_pres_1" in meta and meta.title_page_pres_1 != auto {
    meta.title_page_pres_1
  } else {
    s.title_page_pres_1
  }

  let disp-pres-2 = if title_page_pres_2 != auto {
    title_page_pres_2
  } else if "title_page_pres_2" in meta and meta.title_page_pres_2 != auto {
    meta.title_page_pres_2
  } else {
    s.title_page_pres_2
  }

  let disp-pres-3 = if title_page_pres_3 != auto {
    title_page_pres_3
  } else if "title_page_pres_3" in meta and meta.title_page_pres_3 != auto {
    meta.title_page_pres_3
  } else {
    s.title_page_pres_3
  }

  let formatted-title = format-title(raw-title, to-upper: true)
  let title-leading = get-title-leading(formatted-title, title-lines, width: 5.5in)

  set page(footer: none)

  // [2.5" from top edge] (dy: 1.5in below 1.0in top margin)
  place(top + left, dy: 1.5in)[
    #block(width: 100%)[
      #set align(center)
      #set text(size: 12pt)
      #set par(leading: word-single-leading, first-line-indent: 0pt)
      #block(above: 0pt, below: word-double-leading)[#disp-univ]
      #block(above: 0pt, below: 0pt)[#disp-school]
    ]
  ]

  // [4.5" from top edge] (dy: 3.5in below 1.0in top margin)
  place(top + left, dy: 3.5in)[
    #block(width: 100%)[
      #set align(center)
      #block(width: 5.5in)[
        #set par(leading: title-leading, spacing: title-leading, first-line-indent: 0pt, justify: false)
        #set text(size: 12pt)
        #formatted-title
      ]
    ]
  ]

  // [6.0" from top edge] (dy: 5.0in below 1.0in top margin)
  place(top + left, dy: 5.0in)[
    #block(width: 100%)[
      #set align(center)
      #set text(size: 12pt)
      #set par(leading: word-single-leading, first-line-indent: 0pt)
      #block(above: 0pt, below: word-double-leading)[#disp-pres-1]
      #block(above: 0pt, below: word-double-leading)[#disp-pres-2]
      #block(above: 0pt, below: word-double-leading)[#disp-pres-3]
      #block(above: 0pt, below: 0pt)[#disp-degree]
    ]
  ]

  // [8.5" from top edge] (dy: 7.5in below 1.0in top margin)
  place(top + left, dy: 7.5in)[
    #block(width: 100%)[
      #set align(center)
      #set text(size: 12pt)
      #set par(leading: word-single-leading, first-line-indent: 0pt)
      #if s.by != "" [
        #block(above: 0pt, below: word-double-leading)[#s.by]
      ]
      #block(above: 0pt, below: word-double-leading)[#disp-author]
      #block(above: 0pt, below: 0pt)[#disp-date]
    ]
  ]

  pagebreak()
}

/// Copyright Page (Placed immediately after Title Page and before Approval Page)
/// Unnumbered and uncounted
#let copyright-page(
  author: auto,
  year: auto,
  content: auto,
) = context {
  let meta = au-dmin-meta.get()
  let s = dmin-get-strings(au-dmin-lang.get())

  let disp-author = if author != auto { author } else { meta.author }
  let disp-year = if year != auto {
    year
  } else {
    let m = meta.date.find(regex("\d{4}"))
    if m != none { m } else { "2026" }
  }

  set page(footer: none, header: none)
  v(3.5in)
  align(center)[
    #set par(leading: word-double-leading, spacing: word-double-leading, first-line-indent: 0pt)
    #set text(size: 12pt)
    #if content != auto [
      #content
    ] else [
      #block(above: 0pt, below: word-double-leading)[© Copyright by #disp-author #disp-year]
      #block(above: 0pt, below: 0pt)[
        #if au-dmin-lang.get() == "uk" [
          Всі права захищено
        ] else if au-dmin-lang.get() == "ru" [
          Все права защищены
        ] else if au-dmin-lang.get() == "fr" [
          Tous droits réservés
        ] else if au-dmin-lang.get() == "es" [
          Todos los derechos reservados
        ] else [
          All Rights Reserved
        ]
      ]
    ]
  ]
  pagebreak()
}

/// Exhibit D: Approval Page
#let approval-page(
  title: auto,
  author: auto,
  degree: auto,
  advisor: auto,
  second-reader: auto,
  third-reader: auto,
  director: auto,
  dean: auto,
  date-approved: auto,
  title-lines: auto,
) = context {
  let meta = au-dmin-meta.get()
  let s = dmin-get-strings(au-dmin-lang.get())

  let raw-title = if title != auto { title } else { meta.title }
  let disp-author = if author != auto { author } else { meta.author }
  let disp-degree = if degree != auto { degree } else { meta.degree }
  let disp-advisor = if advisor != auto { advisor } else { meta.advisor }
  let disp-second = if second-reader != auto { second-reader } else { meta.second-reader }
  let disp-third = if third-reader != auto { third-reader } else { meta.third-reader }
  let disp-director = if director != auto { director } else { meta.program-director }
  let disp-dean = if dean != auto { dean } else { meta.dean }
  let disp-date-approved = if date-approved != auto { date-approved } else { meta.date-approved }

  let formatted-title = format-title(raw-title, to-upper: true)
  let title-leading = get-title-leading(formatted-title, title-lines, width: 5.5in)

  set page(footer: none)

  // [2.0" from top edge] (dy: 1.0in below 1.0in top margin)
  place(top + left, dy: 1.0in)[
    #block(width: 100%)[
      #set align(center)
      #block(width: 5.5in)[
        #set par(
          leading: title-leading,
          spacing: title-leading,
          first-line-indent: 0pt,
        )
        #text(size: 12pt)[#formatted-title]
      ]
    ]
  ]

  // [3.5" from top edge] (dy: 2.5in below 1.0in top margin)
  place(top + left, dy: 2.5in)[
    #block(width: 100%)[
      #set align(center)
      #block(width: 5.5in)[
        #set text(size: 12pt)
        #set par(leading: word-single-leading, first-line-indent: 0pt)
        #block(above: 0pt, below: word-single-leading)[#s.title_page_pres_1]
        #block(above: 0pt, below: word-single-leading)[#s.title_page_pres_2]
        #block(above: 0pt, below: word-single-leading)[#s.title_page_pres_3]
        #block(above: 0pt, below: 0pt)[#disp-degree]
      ]
    ]
  ]

  // [5.0" from top edge] (dy: 4.0in below 1.0in top margin)
  place(top + left, dy: 4.0in)[
    #block(width: 100%)[
      #set align(center)
      #set text(size: 12pt)
      #set par(leading: word-single-leading, first-line-indent: 0pt)
      #if s.by != "" [
        #block(above: 0pt, below: word-double-leading)[#s.by]
      ]
      #block(above: 0pt, below: 0pt)[#disp-author]
    ]
  ]

  // [6.5" from top edge] (dy: 5.5in below 1.0in top margin)
  place(top + left, dy: 5.5in)[
    #block(width: 100%)[
      #set align(left)
      #set text(size: 12pt)
      #set par(leading: word-single-leading, spacing: word-single-leading, first-line-indent: 0pt)
      #block(above: 0pt, below: word-space-skip-2)[#s.approval_by]

      #let sig-block(body) = stack(
        spacing: 4pt,
        line(length: 2.7in),
        body,
      )

      #grid(
        columns: (1fr, 1fr),
        column-gutter: 0.5in,
        row-gutter: word-space-skip-2,
        sig-block[
          #s.committee_adviser #linebreak()
          #disp-advisor
        ],
        sig-block[
          #s.committee_director #linebreak()
          #disp-director
        ],

        sig-block[
          #if disp-second != none [
            #s.committee_second #linebreak()
            #disp-second
          ] else [
            #s.committee_second
          ]
        ],
        sig-block[
          #s.committee_dean #linebreak()
          #disp-dean
        ],

        if disp-third != none {
          sig-block[#disp-third]
        } else {
          sig-block[]
        },
        sig-block[
          #s.committee_date #linebreak()
          #if disp-date-approved != "Month Day, Year" and disp-date-approved != auto [
            #disp-date-approved
          ]
        ],
      )
    ]
  ]

  pagebreak()
}

/// Dedication Page
#let dedication-page(content) = [
  #v(2.5in)
  #align(center)[
    #block(width: 4.5in)[
      #set par(leading: word-double-leading, spacing: word-double-leading, first-line-indent: 0pt)
      #emph(content)
    ]
  ]
  #pagebreak()
]

/// Exhibit E: Table of Contents
/// AU DMin Manual (p. 6 & 9): TOC must reflect only first three levels of subheadings (depth: 4).
#let dmin-toc(title: auto, show-page-number: true, depth: 4) = {
  seen-chapter.update(false)
  seen-appendix.update(false)
  is-first-subhead.update(true)
  is-first-toc-entry.update(true)
  pagebreak(weak: true)
  if not show-page-number {
    set page(footer: none)
    v(1.0in)
    block(width: 100%, above: 0pt, below: word-space-skip-2)[
      #align(center)[
        #set text(size: 12pt, weight: "regular")
        #set par(leading: word-single-leading, spacing: word-single-leading, first-line-indent: 0pt)
        #context {
          let s = dmin-get-strings(au-dmin-lang.get())
          if title == auto { s.toc } else { upper(title) }
        }
      ]
    ]
    outline(title: none, depth: depth)
    pagebreak()
    set page(
      numbering: "i",
      footer: context {
        align(center)[
          #text(size: 12pt)[
            #counter(page).display("i")
          ]
        ]
      },
    )
  } else {
    set page(
      numbering: "i",
      footer: context {
        align(center)[
          #text(size: 12pt)[
            #counter(page).display("i")
          ]
        ]
      },
    )
    v(1.0in)
    block(width: 100%, above: 0pt, below: word-space-skip-2)[
      #align(center)[
        #set text(size: 12pt, weight: "regular")
        #set par(leading: word-single-leading, spacing: word-single-leading, first-line-indent: 0pt)
        #context {
          let s = dmin-get-strings(au-dmin-lang.get())
          if title == auto { s.toc } else { upper(title) }
        }
      ]
    ]
    outline(title: none, depth: depth)
  }
}

/// Exhibit F: List of Illustrations / Figures (Placed first per AU DMin Manual)
#let list-of-illustrations(title: auto) = {
  is-first-fig-entry.update(true)
  heading(level: 1, numbering: none, outlined: true)[
    #context {
      let s = dmin-get-strings(au-dmin-lang.get())
      if title == auto { s.list_illustrations } else { upper(title) }
    }
  ]
  outline(
    title: none,
    target: figure.where(kind: image),
  )
}

/// Exhibit F: List of Tables (Placed after List of Illustrations)
/// Set pagebreak: true if you want it on a separate page; false (default) puts it on the same page as illustrations.
#let list-of-tables(title: auto, pagebreak: false) = {
  is-first-table-entry.update(true)
  heading(
    level: 1,
    numbering: none,
    supplement: if pagebreak { none } else { [same-page] },
    outlined: true,
  )[
    #context {
      let s = dmin-get-strings(au-dmin-lang.get())
      if title == auto { s.list_tables } else { upper(title) }
    }
  ]
  outline(
    title: none,
    target: figure.where(kind: table),
  )
}

/// Exhibit G: List of Abbreviations
#let list-of-abbreviations(title: auto, items: ()) = {
  heading(level: 1, numbering: none, outlined: true)[
    #context {
      let s = dmin-get-strings(au-dmin-lang.get())
      if title == auto { s.list_abbreviations } else { upper(title) }
    }
  ]
  align(left)[
    #set par(leading: word-single-leading, spacing: word-single-leading, first-line-indent: 0pt)
    #grid(
      columns: (1.2in, 1fr),
      row-gutter: word-space-skip-1,
      ..items
        .map(pair => (
          [#text(weight: "regular")[#pair.at(0)]],
          [#pair.at(1)],
        ))
        .flatten()
    )
  ]
}

/// Exhibit H: Preface / Acknowledgments
#let preface-page(title: auto, body) = {
  heading(level: 1, numbering: none, outlined: true)[
    #context {
      let s = dmin-get-strings(au-dmin-lang.get())
      if title == auto { s.acknowledgments } else { upper(title) }
    }
  ]
  set par(
    leading: word-double-leading,
    spacing: word-double-leading,
    first-line-indent: (amount: 0.5in, all: true),
    justify: false,
  )
  body
}

/// Vita Page — Chapter 2 (p. 4, 11)
#let vita-page(title: auto, author: auto, content) = {
  heading(level: 1, numbering: none, outlined: true)[
    #context {
      let s = dmin-get-strings(au-dmin-lang.get())
      if title == auto { s.vita } else { upper(title) }
    }
  ]
  align(left)[
    #set par(
      leading: word-double-leading,
      spacing: word-double-leading,
      first-line-indent: 0pt,
      justify: false,
    )
    #content
  ]
}
