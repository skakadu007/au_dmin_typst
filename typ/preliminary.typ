// ==============================================================================
// 📄 AU DMin Preliminary Pages (Chapter 7, Exhibits A–H)
// Automatically retrieves metadata from au-dmin-meta unless overridden
// ==============================================================================

#import "state.typ": *
#import "i18n.typ": *

/// Blank Flyleaf Page (First and Last page of bound dissertation)
/// Completely empty, unnumbered, and uncounted
#let blank-page() = {
  page(header: none, footer: none)[]
}

/// Exhibit A: Abstract Title Page
#let abstract-title-page(
  title: auto,
  author: auto,
  adviser: auto,
  title-lines: 2,
) = context {
  let meta = au-dmin-meta.get()
  let s = dmin-get-strings(au-dmin-lang.get())

  let disp-title = if title != auto { title } else { meta.title }
  let disp-author = if author != auto { author } else { meta.author }
  let disp-adviser = if adviser != auto { adviser } else { meta.advisor }

  set page(footer: none)
  v(2.0in) // 1.0in margin + 2.0in = 3.0in from top edge
  align(center)[
    #set par(leading: 6pt, first-line-indent: 0pt)
    #text(size: 12pt)[#s.abstract]
  ]
  v(1.0in)
  align(center)[
    #set par(leading: if title-lines >= 3 { 6pt } else { 12pt }, first-line-indent: 0pt)
    #text(size: 12pt)[#upper(disp-title)]
  ]
  v(1.4in)
  align(center)[
    #set par(leading: 12pt, first-line-indent: 0pt)
    #text(size: 12pt)[
      #if s.by != "" [#s.by \ ]
      #v(6pt)
      #disp-author
    ]
  ]
  v(0.6in)
  align(center)[
    #set par(leading: 6pt, first-line-indent: 0pt)
    #text(size: 12pt)[#s.adviser #disp-adviser]
  ]
  pagebreak()
}

/// Exhibit B: Abstract Body
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
) = context {
  let meta = au-dmin-meta.get()
  let s = dmin-get-strings(au-dmin-lang.get())

  let disp-title = if title != auto { title } else { meta.title }
  let disp-author = if author != auto { author } else { meta.author }
  let disp-degree = if degree != auto { degree } else { meta.degree }
  let disp-univ = if university != auto { university } else { meta.university }
  let disp-school = if school != auto { school } else { meta.school }
  let disp-date = if date != auto { date } else { meta.date }
  let disp-adviser = if adviser != auto { adviser } else { meta.advisor }

  set page(footer: none)
  v(1.0in)
  align(center)[
    #set par(leading: 6pt, first-line-indent: 0pt)
    #text(weight: "regular")[#s.abstract_header]\
    #v(12pt)
    #text(weight: "regular")[#s.dissertation_type]\
    #v(24pt)
    #text(weight: "regular")[#disp-univ]\
    #v(12pt)
    #text(weight: "regular")[#disp-school]\
  ]
  v(0.6in)
  align(left)[
    #set par(leading: 6pt, first-line-indent: 0pt)
    #grid(
      columns: (auto, 1fr),
      gutter: 8pt,
      [#s.title_label], [#upper(disp-title)],
    )
    #v(12pt)
    #s.researcher_name #disp-author\
    #v(12pt)
    #s.adviser_name_degree #disp-adviser\
    #v(12pt)
    #s.date_completed #disp-date
  ]
  block(width: 100%, above: 36pt, below: 12pt, sticky: true)[
    #align(center)[#s.problem]
  ]
  problem

  block(width: 100%, above: 24pt, below: 12pt, sticky: true)[
    #align(center)[#s.method]
  ]
  method

  block(width: 100%, above: 24pt, below: 12pt, sticky: true)[
    #align(center)[#s.results]
  ]
  results

  block(width: 100%, above: 24pt, below: 12pt, sticky: true)[
    #align(center)[#s.conclusions]
  ]
  conclusions

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
) = context {
  let meta = au-dmin-meta.get()
  let s = dmin-get-strings(au-dmin-lang.get())

  let disp-title = if title != auto { title } else { meta.title }
  let disp-author = if author != auto { author } else { meta.author }
  let disp-degree = if degree != auto { degree } else { meta.degree }
  let disp-date = if month-year != auto { month-year } else { meta.date }
  let disp-univ = if university != auto { university } else { meta.university }
  let disp-school = if school != auto { school } else { meta.school }

  let test-block = block(width: 5.5in)[
    #set par(leading: 12pt, first-line-indent: 0pt, justify: false)
    #set text(size: 12pt)
    #upper(disp-title)
  ]
  let m = measure(test-block)
  let is-multi-line = if title-lines == auto {
    m.height > 45pt
  } else {
    title-lines >= 3
  }
  let title-leading = if is-multi-line { 6pt } else { 12pt }

  set page(footer: none)

  // [2.5" from top edge] (dy: 1.5in below 1.0in top margin)
  place(top + left, dy: 1.5in)[
    #block(width: 100%)[
      #set align(center)
      #set par(leading: 6pt, first-line-indent: 0pt)
      #text(size: 12pt)[#disp-univ\ \ #disp-school]
    ]
  ]

  // [4.5" from top edge] (dy: 3.5in below 1.0in top margin)
  place(top + left, dy: 3.5in)[
    #block(width: 100%)[
      #set align(center)
      #block(width: 5.5in)[
        #set par(leading: title-leading, first-line-indent: 0pt, justify: false)
        #set text(size: 12pt)
        #upper(disp-title)
      ]
    ]
  ]

  // [6.0" from top edge] (dy: 5.0in below 1.0in top margin)
  place(top + left, dy: 5.0in)[
    #block(width: 100%)[
      #set align(center)
      #set par(leading: 12pt, first-line-indent: 0pt)
      #text(size: 12pt)[
        #s.title_page_pres_1\
        #s.title_page_pres_2\
        #s.title_page_pres_3\
        #disp-degree
      ]
    ]
  ]

  // [8.5" from top edge] (dy: 7.5in below 1.0in top margin)
  place(top + left, dy: 7.5in)[
    #block(width: 100%)[
      #set align(center)
      #set par(leading: 12pt, first-line-indent: 0pt)
      #text(size: 12pt)[
        #if s.by != "" [#s.by \ ]
        #disp-author\
        #disp-date
      ]
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
    #set par(leading: 6pt, first-line-indent: 0pt)
    #set text(size: 12pt)
    #if content != auto [
      #content
    ] else [
      © Copyright by #disp-author #disp-year \
      #v(6pt)
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
  title-lines: 2,
) = context {
  let meta = au-dmin-meta.get()
  let s = dmin-get-strings(au-dmin-lang.get())

  let disp-title = if title != auto { title } else { meta.title }
  let disp-author = if author != auto { author } else { meta.author }
  let disp-degree = if degree != auto { degree } else { meta.degree }
  let disp-advisor = if advisor != auto { advisor } else { meta.advisor }
  let disp-second = if second-reader != auto { second-reader } else { meta.second-reader }
  let disp-third = if third-reader != auto { third-reader } else { meta.third-reader }
  let disp-director = if director != auto { director } else { meta.program-director }
  let disp-dean = if dean != auto { dean } else { meta.dean }
  let disp-date-approved = if date-approved != auto { date-approved } else { meta.date-approved }

  set page(footer: none)
  v(1.0in)
  align(center)[
    #block(width: 5.5in)[
      #set par(leading: if title-lines >= 3 { 6pt } else { 12pt }, first-line-indent: 0pt)
      #text(size: 12pt)[#upper(disp-title)]
    ]
  ]
  v(0.8in)
  align(center)[
    #block(width: 5.5in)[
      #set par(leading: 6pt, first-line-indent: 0pt)
      #text(size: 12pt)[
        #s.title_page_pres_1\
        #s.title_page_pres_2\
        #s.title_page_pres_3\
        #disp-degree
      ]
    ]
  ]
  v(0.8in)
  align(center)[
    #set par(leading: 12pt, first-line-indent: 0pt)
    #text(size: 12pt)[
      #if s.by != "" [#s.by \ ]
      #v(4pt)
      #disp-author\
      #v(16pt)
      #s.approval_by
    ]
  ]
  v(0.6in)
  align(left)[
    #set text(size: 12pt)
    #set par(leading: 4pt, first-line-indent: 0pt)
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 0.5in,
      row-gutter: 24pt,
      [
        #line(length: 2.7in)\
        #s.committee_adviser\
        #disp-advisor
      ],
      [
        #line(length: 2.7in)\
        #s.committee_director\
        #disp-director
      ],

      [
        #line(length: 2.7in)\
        #if disp-second != none [
          #s.committee_second\
          #disp-second
        ] else [
          #s.committee_second
        ]
      ],
      [
        #line(length: 2.7in)\
        #s.committee_dean\
        #disp-dean
      ],

      if disp-third != none [
        #line(length: 2.7in)\
        #disp-third
      ] else [
        #line(length: 2.7in)
      ],
      [
        #line(length: 2.7in)\
        #s.committee_date\
        #if disp-date-approved != "Month Day, Year" and disp-date-approved != auto [
          #disp-date-approved
        ]
      ],
    )
  ]
  pagebreak()
}

/// Dedication Page
#let dedication-page(content) = [
  #v(2.5in)
  #align(center)[
    #block(width: 4.5in)[
      #set par(leading: 12pt, first-line-indent: 0pt)
      #emph(content)
    ]
  ]
  #pagebreak()
]

/// Exhibit E: Table of Contents
#let dmin-toc(title: auto, show-page-number: false) = {
  seen-chapter.update(false)
  seen-appendix.update(false)
  is-first-subhead.update(true)
  pagebreak(weak: true)
  if not show-page-number {
    set page(footer: none)
    v(1.0in)
    block(width: 100%, below: 24pt)[
      #align(center)[
        #set text(size: 12pt)
        #set par(leading: 6pt, first-line-indent: 0pt)
        #context {
          let s = dmin-get-strings(au-dmin-lang.get())
          if title == auto { s.toc } else { upper(title) }
        }
      ]
    ]
    outline(title: none)
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
    v(1.0in)
    block(width: 100%, below: 24pt)[
      #align(center)[
        #set text(size: 12pt)
        #set par(leading: 6pt, first-line-indent: 0pt)
        #context {
          let s = dmin-get-strings(au-dmin-lang.get())
          if title == auto { s.toc } else { upper(title) }
        }
      ]
    ]
    outline(title: none)
  }
}

/// Exhibit F: List of Illustrations / Figures (Placed first per AU DMin Manual)
#let list-of-illustrations(title: auto) = {
  context {
    let s = dmin-get-strings(au-dmin-lang.get())
    let display-title = if title == auto { s.list_illustrations } else { upper(title) }
    heading(level: 1, numbering: none, outlined: true)[#display-title]
  }
  outline(
    title: none,
    target: figure.where(kind: image),
  )
}

/// Exhibit F: List of Tables (Placed after List of Illustrations)
/// Set pagebreak: true if you want it on a separate page; false (default) puts it on the same page as illustrations.
#let list-of-tables(title: auto, pagebreak: false) = {
  if pagebreak {
    context {
      let s = dmin-get-strings(au-dmin-lang.get())
      let display-title = if title == auto { s.list_tables } else { upper(title) }
      heading(level: 1, numbering: none, outlined: true)[#display-title]
    }
  } else {
    context {
      let s = dmin-get-strings(au-dmin-lang.get())
      let display-title = if title == auto { s.list_tables } else { upper(title) }
      heading(level: 1, numbering: none, supplement: [same-page], outlined: true)[#display-title]
    }
  }
  outline(
    title: none,
    target: figure.where(kind: table),
  )
}

/// Exhibit G: List of Abbreviations
#let list-of-abbreviations(title: auto, items: ()) = context {
  let s = dmin-get-strings(au-dmin-lang.get())
  let display-title = if title == auto { s.list_abbreviations } else { upper(title) }
  heading(level: 1, numbering: none, outlined: true)[#display-title]
  align(left)[
    #set par(leading: 6pt, first-line-indent: 0pt)
    #grid(
      columns: (1.2in, 1fr),
      row-gutter: 10pt,
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
#let preface-page(title: auto, body) = context {
  let s = dmin-get-strings(au-dmin-lang.get())
  let display-title = if title == auto { s.acknowledgments } else { upper(title) }
  heading(level: 1, numbering: none, outlined: true)[#display-title]
  set par(leading: 12pt, first-line-indent: 0.5in, justify: false)
  body
}

/// Vita Page — Chapter 2 (p. 5/11)
#let vita-page(title: auto, author: auto, content) = context {
  let meta = au-dmin-meta.get()
  let s = dmin-get-strings(au-dmin-lang.get())
  let display-title = if title == auto { s.vita } else { upper(title) }
  let disp-author = if author != auto { author } else { meta.author }

  heading(level: 1, numbering: none, outlined: true)[#display-title]
  align(left)[
    #set par(leading: 12pt, first-line-indent: 0pt, justify: false)
    #content
  ]
}
