// ==============================================================================
// 📐 AU DMin Layout, Typography, Spacing & Show Rules
// Conforms to: Doctor of Ministry Project Writing Manual (4th Edition, Aug 2019)
// ==============================================================================

#import "state.typ": *
#import "i18n.typ": *

#let apply-dmin-layout(lang: "en", body) = {
  // ============================================================================
  // PAGE GEOMETRY — Chapter 3 (p. 12)
  // Left margin: 1.5" (for binding); Right/Top/Bottom: 1.0"
  // ============================================================================
  set page(
    paper: "us-letter",
    margin: (
      left: 1.5in,
      right: 1.0in,
      top: 1.0in,
      bottom: 1.0in,
    ),
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
  )

  // ============================================================================
  // SPACING — Chapter 3 (p. 12-13)
  // All text: double-spaced (24pt baseline = 12pt font + 12pt leading)
  // Ragged right margin (NOT justified)
  // Paragraph indent: 0.5 inches
  // ============================================================================
  set par(
    leading: 12pt,
    spacing: 12pt,
    first-line-indent: (amount: 0.5in, all: true),
    justify: false,
  )

  // ============================================================================
  // FOOTNOTES — Chapter 5 (p. 21)
  // 10pt font, single-spaced within, double space between, 0.5in indent
  // ============================================================================
  show footnote.entry: it => {
    set text(size: 10pt)
    set par(leading: 5pt, spacing: 10pt, first-line-indent: 0.5in, justify: false)
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
        v(24pt)
        block(width: 100%, below: 18pt)[
          #align(center)[
            #set text(size: 12pt, weight: "regular")
            #set par(leading: 12pt, justify: false, first-line-indent: 0pt)
            #upper(it.body)
          ]
        ]
      } else {
        // Major Section / Chapter: 2" from top edge of paper (1.0in margin + 1.0in v)
        pagebreak(weak: true)
        v(1.0in)
        if it.numbering != none {
          if it.has("supplement") and it.supplement == [Appendix] {
            block(width: 100%, below: 24pt)[
              #align(center)[
                #set text(size: 12pt, weight: "regular")
                #set par(leading: 12pt, justify: false, first-line-indent: 0pt)
                #context {
                  let s = dmin-get-strings(au-dmin-lang.get())
                  [#s.appendix #appendix-counter.display("A") \ ]
                }
                #v(12pt)
                #upper(it.body)
              ]
            ]
          } else {
            block(width: 100%, below: 24pt)[
              #align(center)[
                #set text(size: 12pt, weight: "regular")
                #set par(leading: 12pt, justify: false, first-line-indent: 0pt)
                #context {
                  let s = dmin-get-strings(au-dmin-lang.get())
                  [#s.chapter #counter(heading).display("1") \ ]
                }
                #v(24pt)
                #upper(it.body)
              ]
            ]
          }
        } else {
          block(width: 100%, below: 24pt)[
            #align(center)[
              #set text(size: 12pt, weight: "regular")
              #set par(leading: 12pt, justify: false, first-line-indent: 0pt)
              #upper(it.body)
            ]
          ]
        }
      }
    } else if it.level == 2 {
      // AU Level 1 Subheading: Centered, Bold, Title Case
      // Triple space before (24pt); Double space after (12pt)
      block(width: 100%, above: 24pt, below: 12pt, sticky: true)[
        #align(center)[
          #block(width: 4.75in)[
            #set text(size: 12pt, weight: "bold")
            #set par(leading: 6pt, justify: false, first-line-indent: 0pt)
            #it.body
          ]
        ]
      ]
    } else if it.level == 3 {
      // AU Level 2 Subheading: Centered, Regular (not bold), Title Case
      block(width: 100%, above: 24pt, below: 12pt, sticky: true)[
        #align(center)[
          #block(width: 4.75in)[
            #set text(size: 12pt, weight: "regular")
            #set par(leading: 6pt, justify: false, first-line-indent: 0pt)
            #it.body
          ]
        ]
      ]
    } else if it.level == 4 {
      // AU Level 3 Subheading: Left margin, Bold, Title Case
      block(width: 100%, above: 24pt, below: 12pt, sticky: true)[
        #align(left)[
          #block(width: 3.0in)[
            #set text(size: 12pt, weight: "bold")
            #set par(leading: 6pt, justify: false, first-line-indent: 0pt)
            #it.body
          ]
        ]
      ]
    } else if it.level == 5 {
      // AU Level 4 Subheading: Left margin, Regular (not bold), Sentence style
      block(width: 100%, above: 24pt, below: 12pt, sticky: true)[
        #align(left)[
          #block(width: 3.0in)[
            #set text(size: 12pt, weight: "regular")
            #set par(leading: 6pt, justify: false, first-line-indent: 0pt)
            #it.body
          ]
        ]
      ]
    } else {
      it
    }
  }

  // ============================================================================
  // TABLES AND FIGURES — Chapter 2 (p. 7-8) & Chapter 3 (p. 13) & Exhibit F
  // ============================================================================
  show figure.where(kind: table): it => block(width: 100%, above: 36pt, below: 36pt)[
    #set align(left)
    #set par(leading: 6pt, justify: false, first-line-indent: 0pt)
    #if it.has("caption") and it.caption != none [
      #context {
        let s = dmin-get-strings(au-dmin-lang.get())
        text(weight: "bold")[#s.table #it.counter.display(). #it.caption.body]
      }
      #v(6pt, weak: true)
    ]
    #it.body
  ]

  show figure.where(kind: image): it => block(width: 100%, above: 36pt, below: 36pt)[
    #set align(left)
    #set par(leading: 6pt, justify: false, first-line-indent: 0pt)
    #align(center)[#it.body]
    #if it.has("caption") and it.caption != none [
      #v(6pt, weak: true)
      #context {
        let s = dmin-get-strings(au-dmin-lang.get())
        text(weight: "regular")[#s.figure #it.counter.display(). #it.caption.body]
      }
    ]
  ]

  // ============================================================================
  // TABLE OF CONTENTS & LIST ENTRIES — Exhibits E & F (p. 38-40)
  // ============================================================================
  show outline.entry: it => {
    set text(size: 12pt)
    let loc = it.element.location()
    let p-num = counter(page).at(loc)
    let format = loc.page-numbering()
    let is-roman = format != none and (format == "i" or format == "I")
    let p = if format != none { numbering(format, ..p-num) } else { str(p-num.first()) }
    let fill-dots = box(width: 1fr, repeat[ . ])
    let p-box = box(width: 0.35in, align(right)[#link(loc)[#p]])

    if it.element.func() == figure and it.element.kind == table {
      // List of Tables entry per Exhibit F (p. 40)
      v(12pt, weak: true)
      let cap = it.element.caption.body
      context {
        let num = it.element.counter.at(loc).first()
        grid(
          columns: (0.35in, 1fr),
          align: (top + left, top + left),
          [#num.],
          [
            #set par(
              leading: 6pt,
              first-line-indent: 0pt,
              justify: false,
            )
            #show linebreak: it => [#it#h(0.30in)]
            #link(loc)[#cap]#fill-dots#h(12pt)#p-box
          ],
        )
      }
    } else if it.element.func() == figure and it.element.kind == image {
      // List of Illustrations entry per Exhibit F (p. 40)
      v(12pt, weak: true)
      let cap = it.element.caption.body
      context {
        let num = it.element.counter.at(loc).first()
        grid(
          columns: (0.35in, 1fr),
          align: (top + left, top + left),
          [#num.],
          [
            #set par(
              leading: 6pt,
              first-line-indent: 0pt,
              justify: false,
            )
            #show linebreak: it => [#it#h(0.30in)]
            #link(loc)[#cap]#fill-dots#h(12pt)#p-box
          ],
        )
      }
    } else if it.element.func() == heading {
      if it.level == 1 {
        is-first-subhead.update(true)
        if is-roman {
          // Preliminary pages in TOC (e.g. LIST OF TABLES, ACKNOWLEDGMENTS) — Flush left
          v(12pt, weak: true)
          block(above: 12pt, below: 0pt)[
            #set par(
              leading: 6pt,
              first-line-indent: 0pt,
              justify: false,
            )
            #link(loc)[#upper(it.element.body)]#fill-dots#h(12pt)#p-box
          ]
        } else if it.element.has("supplement") and (it.element.supplement == [Appendix] or it.element.supplement == [Appendix-cover]) {
          // Appendix entry per Exhibit E (p. 38-39)
          context {
            let s = dmin-get-strings(au-dmin-lang.get())
            let was-seen = seen-appendix.get()
            if not was-seen {
              seen-appendix.update(true)
              v(12pt, weak: true)
              block(width: 100%, above: 12pt, below: 6pt)[
                #set par(first-line-indent: 0pt, leading: 6pt)
                #s.appendix_word
              ]
            } else {
              v(12pt, weak: true)
            }
            let a-num = appendix-counter.at(loc)
            let letter = numbering("A.", ..a-num)
            block(above: 2pt, below: 0pt)[
              #pad(left: 0.3in)[
                #grid(
                  columns: (0.3in, 1fr),
                  align: (top + left, top + left),
                  [#letter],
                  [
                    #set par(
                      leading: 6pt,
                      first-line-indent: 0pt,
                      justify: false,
                    )
                    #link(loc)[#upper(it.element.body)]#fill-dots#h(12pt)#p-box
                  ],
                )
              ]
            ]
          }
        } else if it.element.numbering == none {
          // Unnumbered level 1 headings (REFERENCE LIST, VITA, etc.) — Flush left
          v(12pt, weak: true)
          block(above: 12pt, below: 0pt)[
            #set par(
              leading: 6pt,
              first-line-indent: 0pt,
              justify: false,
            )
            #link(loc)[#upper(it.element.body)]#fill-dots#h(12pt)#p-box
          ]
        } else {
          // Chapter entry per Exhibit E (p. 38-39)
          context {
            let s = dmin-get-strings(au-dmin-lang.get())
            let was-seen = seen-chapter.get()
            if not was-seen {
              seen-chapter.update(true)
              v(12pt, weak: true)
              block(width: 100%, above: 12pt, below: 6pt)[
                #set par(first-line-indent: 0pt, leading: 6pt)
                #s.chapter_word
              ]
            } else {
              v(12pt, weak: true)
            }
            let c-num = counter(heading).at(loc)
            let num = numbering(it.element.numbering, ..c-num)
            block(above: 2pt, below: 0pt)[
              #pad(left: 0.3in)[
                #grid(
                  columns: (0.3in, 1fr),
                  align: (top + left, top + left),
                  [#num],
                  [
                    #set par(
                      leading: 6pt,
                      first-line-indent: 0pt,
                      justify: false,
                    )
                    #link(loc)[#upper(it.element.body)]#fill-dots#h(12pt)#p-box
                  ],
                )
              ]
            ]
          }
        }
      } else {
        // Subheadings (levels 2, 3, 4, 5) — Single-spaced per Exhibit E (p. 38-39)
        // With hanging indent on runover lines and manual line breaks (\).
        let indent = if it.level == 2 {
          0.9in
        } else if it.level == 3 {
          1.2in
        } else if it.level == 4 {
          1.5in
        } else {
          1.8in
        }

        context {
          let first = is-first-subhead.get()
          if first {
            is-first-subhead.update(false)
            v(12pt, weak: true)
          }
          block(above: 6pt, below: 6pt)[
            #pad(left: indent)[
              #set par(
                leading: 6pt,
                first-line-indent: 0pt,
                justify: false,
              )
              #show linebreak: it => [#it#h(0.30in)]
              #link(loc)[#it.element.body]#fill-dots#h(12pt)#p-box
            ]
          ]
        }
      }
    }
  }

  body
}
