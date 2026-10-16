// ==============================================================================
// 📐 AU DMin Layout, Typography, Spacing & Show Rules
// Conforms to: Doctor of Ministry Project Writing Manual (4th Edition, Aug 2019)
// ==============================================================================

#import "state.typ": *
#import "i18n.typ": *

// ==============================================================================
// 📏 Spacing Constants (Strictly integer pt values / MS Word & AU DMin Standard)
// Line box height at 12pt (top-edge: 0.8em, bottom-edge: -0.2em) = 12pt.
// 1 single line baseline-to-baseline = 14pt.
// ==============================================================================
#let word-single-leading = 2pt      // Single space (0 skipped lines: 14pt baseline - 12pt box = 2pt)
#let word-double-leading = 16pt     // Double space (1 skipped line:  28pt baseline - 12pt box = 16pt)
#let word-space-skip-1 = 16pt       // Double space (skip 1 single line  = 28pt baseline)
#let word-space-skip-2 = 30pt       // Triple space (skip 2 single lines = 42pt baseline)
#let word-space-skip-3 = 44pt       // Quadruple space (skip 3 single lines = 56pt baseline)
#let word-space-skip-4 = 44pt       // Alias for quadruple space (4 spaces / skip 3 lines)


/// Helper to handle string/content line breaks with \ or \n and uppercase conversion
#let format-title(t, to-upper: false) = {
  if type(t) == str {
    let s = if to-upper { upper(t) } else { t }
    let s-norm = s.replace("\\", "\n")
    let lines = s-norm.split("\n").map(l => l.trim()).filter(l => l.len() > 0)
    if lines.len() > 1 {
      lines.join(linebreak())
    } else {
      s
    }
  } else if type(t) == content {
    if to-upper { upper(t) } else { t }
  } else {
    t
  }
}

/// Helper to determine the number of manual line breaks in a title
#let count-title-lines(t) = {
  if type(t) == str {
    let s-norm = t.replace("\\", "\n")
    let lines = s-norm.split("\n").map(l => l.trim()).filter(l => l.len() > 0)
    calc.max(1, lines.len())
  } else if type(t) == content {
    let rep = repr(t)
    let breaks = rep.matches("linebreak").len()
    breaks + 1
  } else {
    1
  }
}

/// Helper to measure actual rendered title lines within a given width (default 6.0in full text width)
#let get-title-leading(body, user-lines, width: 6.0in) = {
  if user-lines != auto {
    if user-lines >= 3 { word-single-leading } else { word-double-leading }
  } else {
    let test-m = measure(block(width: width)[
      #set text(size: 12pt, weight: "regular")
      #set par(leading: 0pt, spacing: 0pt, justify: false, first-line-indent: 0pt)
      #upper(body)
    ])
    // 1 line = 12pt, 2 lines = 24pt, 3+ lines >= 36pt
    if test-m.height >= 30pt {
      word-single-leading
    } else {
      word-double-leading
    }
  }
}


#let apply-dmin-layout(lang: "en", body) = {
  // ============================================================================
  // PAGE GEOMETRY — Chapter 3 (p. 12)
  // Left margin: 1.5" (for binding); Right/Top/Bottom: 1.0"
  // Page numbers: 0.5" from bottom center (footer-descent: 0.5in)
  // ============================================================================
  set page(
    paper: "us-letter",
    margin: (
      left: 1.5in,
      right: 1.0in,
      top: 1.0in,
      bottom: 1.0in,
    ),
    footer-descent: 0.5in,
    header: none,
    footer: context {
      align(center)[
        #text(size: 12pt)[
          #counter(page).display()
        ]
      ]
    },
  )

  // ============================================================================
  // TYPOGRAPHY — Chapter 1 (p. 1)
  // "Fonts similar to Times New Roman... serif... 10-12 points"
  // ============================================================================
  set text(
    font: ("Times New Roman", "Liberation Serif", "Nimbus Roman"),
    size: 12pt,
    lang: lang,
    top-edge: 0.8em,
    bottom-edge: -0.2em,
    costs: (widow: 300%, orphan: 300%, runt: 300%),
    hyphenate: false,
  )

  // Запобігання висячим коротким прийменникам, сполучникам та числам з крапкою
  // Використовуємо [ ] замість \s, щоб регулярний вираз НЕ з'їдав переноси рядків (\n / \)
  show regex("(?:\b|^)([а-яА-ЯіІїЇєЄґҐa-zA-Z]{1,2}|[0-9]+\.)[ ]"): it => {
    it.text.trim() + sym.space.nobreak
  }

  // ============================================================================
  // SPACING — Chapter 3 (p. 12-13)
  // All text: double-spaced (28pt baseline = 12pt font box + 16pt leading)
  // Ragged right margin (NOT justified)
  // Paragraph indent: 0.5 inches
  // ============================================================================
  set par(
    leading: word-double-leading,
    spacing: word-double-leading,
    first-line-indent: (amount: 0.5in, all: true),
    justify: false,
  )

  show par: it => consecutive-subhead.update(false) + it

  // ============================================================================
  // BIBLIOGRAPHY — Chapter 5 & Appendix A
  // Запобігання розриву окремих бібліографічних записів між сторінками
  // ============================================================================
  show bibliography: set grid.cell(breakable: false)

  // ============================================================================
  // FOOTNOTES — Chapter 3 (p. 13) & Chapter 5 (p. 21)
  // 10pt font, single-spaced within, double space between, 0.5in indent,
  // 20-space separator line, double space after separator line.
  // ============================================================================
  set footnote.entry(
    clearance: word-single-leading,
    gap: word-space-skip-1,
    separator: [
      #line(length: 1.65in, stroke: 0.5pt)
      #v(word-space-skip-1, weak: true)
    ],
  )
  show footnote.entry: it => {
    set text(size: 10pt)
    set par(leading: 2pt, spacing: word-space-skip-1, first-line-indent: 0.5in, justify: false)
    it
  }

  // ============================================================================
  // HEADINGS — Chapter 2 (p. 9-10) & Chapter 3 (p. 13-14) & Exhibit I
  // ============================================================================
  set heading(numbering: none)
  show heading: it => {
    if it.level == 1 {
      if it.has("supplement") and it.supplement == [Appendix-cover] {
        // Handled by appendix cover sheet, do not render duplicate heading on content page
        none
      } else if it.has("supplement") and (it.supplement == [same-page] or repr(it.supplement) == "[same-page]") {
        // Section on same page without pagebreak (e.g., List of Tables right after List of Illustrations)
        // Quadruple space above (word-space-skip-3 = 44pt), triple space below (word-space-skip-2 = 30pt)
        block(width: 100%, above: word-space-skip-3, below: word-space-skip-2, sticky: true)[
          #align(center)[
            #set text(size: 12pt, weight: "regular")
            #set par(leading: word-single-leading, spacing: word-single-leading, justify: false, first-line-indent: 0pt)
            #upper(it.body)
          ]
          #consecutive-subhead.update(true)
        ]
      } else {
        // Major Section / Chapter: 2" from top edge of paper (1.0in margin + 1.0in v)
        pagebreak(weak: true)
        // Reset footnote counter on each new chapter per Chapter 5 (p. 21, Rule 2)
        if it.numbering != none {
          counter(footnote).update(0)
        }
        v(1.0in)
        if it.numbering != none {
          if it.has("supplement") and it.supplement == [Appendix] {
            block(width: 100%, above: 0pt, below: word-space-skip-2, sticky: true)[
              #align(center)[
                #set text(size: 12pt, weight: "regular")
                #context {
                  let s = dmin-get-strings(au-dmin-lang.get())
                  block(width: 100%, above: 0pt, below: word-space-skip-2)[
                    #set par(leading: word-single-leading, first-line-indent: 0pt)
                    #s.appendix #appendix-counter.display("A")
                  ]
                }
                #context {
                  let user-lines = dmin-chapter-lines.get()
                  let title-leading = get-title-leading(it.body, user-lines, width: 6.0in)
                  block(width: 100%, above: 0pt, below: 0pt)[
                    #set par(leading: title-leading, spacing: title-leading, justify: false, first-line-indent: 0pt)
                    #upper(it.body)
                  ]
                }
              ]
              #consecutive-subhead.update(true)
            ]
          } else {
            block(width: 100%, above: 0pt, below: word-space-skip-2, sticky: true)[
              #align(center)[
                #set text(size: 12pt, weight: "regular")
                #context {
                  let s = dmin-get-strings(au-dmin-lang.get())
                  block(width: 100%, above: 0pt, below: word-space-skip-2)[
                    #set par(leading: word-single-leading, first-line-indent: 0pt)
                    #s.chapter #counter(heading).display("1")
                  ]
                }
                #context {
                  let user-lines = dmin-chapter-lines.get()
                  let title-leading = get-title-leading(it.body, user-lines, width: 6.0in)
                  block(width: 100%, above: 0pt, below: 0pt)[
                    #set par(leading: title-leading, spacing: title-leading, justify: false, first-line-indent: 0pt)
                    #upper(it.body)
                  ]
                }
              ]
              #consecutive-subhead.update(true)
            ]
          }
        } else {
          // Unnumbered Major Section (LIST OF ILLUSTRATIONS, PREFACE, REFERENCE LIST, VITA, etc.)
          // Followed by triple space (word-space-skip-2 = 30pt) per p. 13 & Exhibits E-H
          block(width: 100%, above: 0pt, below: word-space-skip-2, sticky: true)[
            #align(center)[
              #set text(size: 12pt, weight: "regular")
              #context {
                let user-lines = dmin-chapter-lines.get()
                let title-leading = get-title-leading(it.body, user-lines, width: 6.0in)
                block(width: 100%, above: 0pt, below: 0pt)[
                  #set par(leading: title-leading, spacing: title-leading, justify: false, first-line-indent: 0pt)
                  #upper(it.body)
                ]
              }
            ]
            #consecutive-subhead.update(true)
          ]
        }
      }
    } else if it.level == 2 {
      // AU Level 1 Subheading: Centered, Bold, Title Case
      // Triple space before (30pt); Double space after (16pt); Double space between consecutive subheads (16pt)
      context {
        let is-consec = (
          it.has("supplement") and (it.supplement == [consecutive] or repr(it.supplement) == "[consecutive]")
        )
        let was-subhead = consecutive-subhead.get()
        let abv = if is-consec or was-subhead { word-space-skip-1 } else { word-space-skip-2 }
        block(width: 100%, above: abv, below: word-space-skip-1, sticky: true)[
          #align(center)[
            #block(width: 4.75in, above: 0pt, below: 0pt)[
              #set text(size: 12pt, weight: "bold")
              #set par(
                leading: word-single-leading,
                spacing: word-single-leading,
                justify: false,
                first-line-indent: 0pt,
              )
              #it.body
            ]
          ]
          #consecutive-subhead.update(true)
        ]
      }
    } else if it.level == 3 {
      // AU Level 2 Subheading: Centered, Regular (not bold), Title Case
      context {
        let is-consec = (
          it.has("supplement") and (it.supplement == [consecutive] or repr(it.supplement) == "[consecutive]")
        )
        let was-subhead = consecutive-subhead.get()
        let abv = if is-consec or was-subhead { word-space-skip-1 } else { word-space-skip-2 }
        block(width: 100%, above: abv, below: word-space-skip-1, sticky: true)[
          #align(center)[
            #block(width: 4.75in, above: 0pt, below: 0pt)[
              #set text(size: 12pt, weight: "regular")
              #set par(
                leading: word-single-leading,
                spacing: word-single-leading,
                justify: false,
                first-line-indent: 0pt,
              )
              #it.body
            ]
          ]
          #consecutive-subhead.update(true)
        ]
      }
    } else if it.level == 4 {
      // AU Level 3 Subheading: Left margin, Bold, Title Case (max 3.0in width)
      context {
        let is-consec = (
          it.has("supplement") and (it.supplement == [consecutive] or repr(it.supplement) == "[consecutive]")
        )
        let was-subhead = consecutive-subhead.get()
        let abv = if is-consec or was-subhead { word-space-skip-1 } else { word-space-skip-2 }
        block(width: 100%, above: abv, below: word-space-skip-1, sticky: true)[
          #align(left)[
            #block(width: 3.0in, above: 0pt, below: 0pt)[
              #set text(size: 12pt, weight: "bold")
              #set par(
                leading: word-single-leading,
                spacing: word-single-leading,
                justify: false,
                first-line-indent: 0pt,
              )
              #it.body
            ]
          ]
          #consecutive-subhead.update(true)
        ]
      }
    } else if it.level == 5 {
      // AU Level 4 Subheading: Left margin, Regular (not bold), Sentence style (max 3.0in width)
      context {
        let is-consec = (
          it.has("supplement") and (it.supplement == [consecutive] or repr(it.supplement) == "[consecutive]")
        )
        let was-subhead = consecutive-subhead.get()
        let abv = if is-consec or was-subhead { word-space-skip-1 } else { word-space-skip-2 }
        block(width: 100%, above: abv, below: word-space-skip-1, sticky: true)[
          #align(left)[
            #block(width: 3.0in, above: 0pt, below: 0pt)[
              #set text(size: 12pt, weight: "regular")
              #set par(
                leading: word-single-leading,
                spacing: word-single-leading,
                justify: false,
                first-line-indent: 0pt,
              )
              #it.body
            ]
          ]
          #consecutive-subhead.update(true)
        ]
      }
    } else {
      it
    }
  }

  // ============================================================================
  // TABLES AND FIGURES — Chapter 2 (p. 7-8) & Chapter 3 (p. 13) & Exhibit F
  // Quadruple space (word-space-skip-3 = 44pt) above and below when on page with text
  // ============================================================================
  show figure.where(kind: table): it => {
    block(width: 100%, above: word-space-skip-3, below: word-space-skip-3)[
      #set align(left)
      #set par(leading: word-single-leading, spacing: word-single-leading, justify: false, first-line-indent: 0pt)
      #if it.has("caption") and it.caption != none [
        #block(width: 100%, above: 0pt, below: word-space-skip-1)[
          #context {
            let s = dmin-get-strings(au-dmin-lang.get())
            text(weight: "bold")[#s.table #it.counter.display(). #it.caption.body]
          }
        ]
      ]
      #it.body
      #consecutive-subhead.update(false)
    ]
  }

  show figure.where(kind: image): it => {
    block(width: 100%, above: word-space-skip-3, below: word-space-skip-3)[
      #set align(left)
      #set par(leading: word-single-leading, spacing: word-single-leading, justify: false, first-line-indent: 0pt)
      #align(center)[#it.body]
      #if it.has("caption") and it.caption != none [
        #block(width: 100%, above: word-space-skip-1, below: 0pt)[
          #context {
            let s = dmin-get-strings(au-dmin-lang.get())
            text(weight: "regular")[#s.figure #it.counter.display(). #it.caption.body]
          }
        ]
      ]
      #consecutive-subhead.update(false)
    ]
  }

  // ============================================================================
  // TABLE OF CONTENTS & LIST ENTRIES — Exhibits E & F (p. 35-37) & Ch. 3 (p. 13)
  // ============================================================================
  show outline.entry: it => {
    set text(size: 12pt)
    let loc = it.element.location()
    let p-num = counter(page).at(loc)
    let format = loc.page-numbering()
    let is-roman = format != none and (format == "i" or format == "I")
    let p = if format != none { numbering(format, ..p-num) } else { str(p-num.first()) }
    let fill-dots = box(width: 1fr, repeat[ . ])
    let p-box = box(width: 0.22in, align(right)[#link(loc)[#p]])

    if it.element.func() == figure and it.element.kind == table {
      // List of Tables entry per Exhibit F (p. 37) & p. 13 Rule 7 (double space between captions)
      let cap = it.element.caption.body
      context {
        let first = is-first-table-entry.get()
        if first { is-first-table-entry.update(false) }
        let abv = if first { 0pt } else { word-space-skip-1 }
        let num = it.element.counter.at(loc).first()
        block(width: 100%, above: abv, below: 0pt)[
          #grid(
            columns: (0.35in, 1fr),
            align: (top + left, top + left),
            [#num.],
            [
              #set par(
                leading: word-single-leading,
                spacing: word-single-leading,
                first-line-indent: 0pt,
                justify: false,
              )
              #show linebreak: it => [#it#h(0.30in)]
              #link(loc)[#cap]#fill-dots#h(3pt)#p-box
            ],
          )
        ]
      }
    } else if it.element.func() == figure and it.element.kind == image {
      // List of Illustrations entry per Exhibit F (p. 37) & p. 13 Rule 7 (double space between captions)
      let cap = it.element.caption.body
      context {
        let first = is-first-fig-entry.get()
        if first { is-first-fig-entry.update(false) }
        let abv = if first { 0pt } else { word-space-skip-1 }
        let num = it.element.counter.at(loc).first()
        block(width: 100%, above: abv, below: 0pt)[
          #grid(
            columns: (0.35in, 1fr),
            align: (top + left, top + left),
            [#num.],
            [
              #set par(
                leading: word-single-leading,
                spacing: word-single-leading,
                first-line-indent: 0pt,
                justify: false,
              )
              #show linebreak: it => [#it#h(0.30in)]
              #link(loc)[#cap]#fill-dots#h(3pt)#p-box
            ],
          )
        ]
      }
    } else if it.element.func() == heading {
      if it.level == 1 {
        is-first-subhead.update(true)
        if is-roman {
          // Preliminary pages in TOC (e.g. LIST OF TABLES, ACKNOWLEDGMENTS) — Flush left, double-spaced
          context {
            let first-toc = is-first-toc-entry.get()
            if first-toc { is-first-toc-entry.update(false) }
            let abv = if first-toc { 0pt } else { word-space-skip-1 }
            block(width: 100%, above: abv, below: 0pt)[
              #set par(
                leading: word-single-leading,
                spacing: word-single-leading,
                first-line-indent: 0pt,
                justify: false,
              )
              #link(loc)[#upper(it.element.body)]#fill-dots#h(3pt)#p-box
            ]
          }
        } else if (
          it.element.has("supplement")
            and (it.element.supplement == [Appendix] or it.element.supplement == [Appendix-cover])
        ) {
          // Appendix entry per Exhibit E (p. 35) — no blank line between "Appendix" and first appendix
          context {
            let s = dmin-get-strings(au-dmin-lang.get())
            let was-seen = seen-appendix.get()
            if not was-seen {
              seen-appendix.update(true)
              block(width: 100%, above: word-space-skip-1, below: word-single-leading)[
                #set par(first-line-indent: 0pt, leading: word-single-leading, spacing: word-single-leading)
                #s.appendix_word
              ]
            }
            let a-num = appendix-counter.at(loc)
            let letter = numbering("A.", ..a-num)
            let abv = if not was-seen { word-single-leading } else { word-space-skip-1 }
            block(width: 100%, above: abv, below: 0pt)[
              #pad(left: 0.3in)[
                #grid(
                  columns: (0.3in, 1fr),
                  align: (top + left, top + left),
                  [#letter],
                  [
                    #set par(
                      leading: word-single-leading,
                      spacing: word-single-leading,
                      first-line-indent: 0pt,
                      justify: false,
                    )
                    #link(loc)[#upper(it.element.body)]#fill-dots#h(3pt)#p-box
                  ],
                )
              ]
            ]
          }
        } else if it.element.numbering == none {
          // Unnumbered level 1 headings (REFERENCE LIST, VITA, etc.) — Flush left, double-spaced
          block(width: 100%, above: word-space-skip-1, below: 0pt)[
            #set par(
              leading: word-single-leading,
              spacing: word-single-leading,
              first-line-indent: 0pt,
              justify: false,
            )
            #link(loc)[#upper(it.element.body)]#fill-dots#h(3pt)#p-box
          ]
        } else {
          // Chapter entry per Exhibit E (p. 35) — no blank line between "Chapter" and "1. ..."
          context {
            let s = dmin-get-strings(au-dmin-lang.get())
            let was-seen = seen-chapter.get()
            if not was-seen {
              seen-chapter.update(true)
              block(width: 100%, above: word-space-skip-1, below: word-single-leading)[
                #set par(first-line-indent: 0pt, leading: word-single-leading, spacing: word-single-leading)
                #s.chapter_word
              ]
            }
            let c-num = counter(heading).at(loc)
            let num = numbering(it.element.numbering, ..c-num)
            let abv = if not was-seen { word-single-leading } else { word-space-skip-1 }
            block(width: 100%, above: abv, below: 0pt)[
              #pad(left: 0.3in)[
                #grid(
                  columns: (0.3in, 1fr),
                  align: (top + left, top + left),
                  [#num],
                  [
                    #set par(
                      leading: word-single-leading,
                      spacing: word-single-leading,
                      first-line-indent: 0pt,
                      justify: false,
                    )
                    #link(loc)[#upper(it.element.body)]#fill-dots#h(3pt)#p-box
                  ],
                )
              ]
            ]
          }
        }
      } else {
        // AU DMin Manual (p. 6, 9): TOC reflects first 3 levels of subheadings (Typst levels 2, 3, 4).
        if it.level > 4 {
          return none
        }

        // Subheadings (levels 2, 3, 4) — Double space after Chapter Title, Single-spaced between subheads (p. 13 & Exhibit E)
        let indent = if it.level == 2 {
          0.9in
        } else if it.level == 3 {
          1.2in
        } else {
          1.5in
        }

        context {
          let first = is-first-subhead.get()
          if first {
            is-first-subhead.update(false)
          }
          let abv = if first { word-space-skip-1 } else { word-single-leading }
          block(width: 100%, above: abv, below: 0pt)[
            #pad(left: indent)[
              #set par(
                leading: word-single-leading,
                spacing: word-single-leading,
                first-line-indent: 0pt,
                justify: false,
              )
              #show linebreak: it => [#it#h(0.30in)]
              #link(loc)[#it.element.body]#fill-dots#h(3pt)#p-box
            ]
          ]
        }
      }
    }
  }

  body
}
