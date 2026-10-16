// ==============================================================================
// 📌 AU DMin Text & Structural Elements
// ==============================================================================

#import "state.typ": *
#import "i18n.typ": *
#import "layout.typ": (
  count-title-lines, format-title, get-title-leading, word-double-leading, word-single-leading, word-space-skip-1,
  word-space-skip-2, word-space-skip-3,
)

/// Chapter heading — Exhibit I
/// Generates: CHAPTER N [triple space] TITLE IN ALL CAPS
/// Spacing between lines of title (AU DMin Manual p. 13 & Exhibit I):
/// - 2 lines: double spacing (word-double-leading)
/// - 3+ lines: single spacing (word-single-leading)
#let dmin-chapter(title: "", lines: auto) = [
  #dmin-chapter-lines.update(lines)
  #let formatted = format-title(title)
  #heading(level: 1, numbering: "1.", outlined: true)[#formatted]
  #dmin-chapter-lines.update(auto)
]

/// Level 5 Subheading (AU Level 5): Run-in to paragraph
/// Indented 0.5", Bold, sentence style, ends with period (Ch. 2 p. 9-10)
/// Flows as a regular double-spaced paragraph without extra skipped lines above.
/// Usage: #subhead5[Students feel responsible][When the students...]
#let subhead5(title, body) = {
  let formatted-title = if type(title) == str {
    let t = title.trim()
    if t.ends-with(".") { t } else { t + "." }
  } else {
    let r = repr(title)
    if r.ends-with(".]") or r.ends-with(".\"") or r.ends-with(".") {
      title
    } else {
      [#title.]
    }
  }
  par(
    leading: word-double-leading,
    spacing: word-double-leading,
    first-line-indent: (amount: 0.5in, all: true),
    justify: false,
  )[#text(weight: "bold")[#formatted-title] #body]
}

/// Block Quote — Chapter 3 (p. 12-13) & Exhibit I
/// 5+ lines of quoted material; single-spaced; indented 0.25in (quarter inch)
/// Double space before and after (above: word-space-skip-1, below: word-space-skip-1)
#let blockquote(body) = [
  #block(width: 100%, above: word-space-skip-1, below: word-space-skip-1)[
    #pad(left: 0.25in)[
      #set par(leading: word-single-leading, spacing: word-single-leading, first-line-indent: 0pt, justify: false)
      #set text(size: 12pt)
      #body
    ]
    #consecutive-subhead.update(false)
  ]
]

/// DMin Table — Chapter 2 (p. 7-8) & Chapter 3 (p. 13) & Exhibit F
/// Quadruple space (skip 3 lines = 44pt) before/after when on page with text
#let dmin-table(number: auto, title: "", table-content, note: none, breakable: false) = context {
  let s = dmin-get-strings(au-dmin-lang.get())
  let formatted = format-title(title)
  let content = [
    #table-content
    #if note != none [
      #block(width: 100%, above: 6pt, below: 0pt)[
        #set text(size: 10pt)
        #set par(leading: word-single-leading, spacing: word-single-leading, first-line-indent: 0pt, justify: false)
        #note
      ]
    ]
  ]
  figure(
    content,
    caption: figure.caption(position: top)[#formatted],
    kind: table,
    supplement: s.table,
  )
}

/// DMin Isolated Table — Chapter 2 (p. 7, Rule 3) & Exhibit F
/// Placed on its own separate page (pagebreak before and after; no body text sharing the page)
#let dmin-table-isolated(number: auto, title: "", table-content, note: none, breakable: false) = [
  #pagebreak(weak: true)
  #dmin-table(number: number, title: title, table-content, note: note, breakable: breakable)
  #pagebreak()
]

/// DMin Figure — Chapter 2 (p. 7-8) & Chapter 3 (p. 13) & Exhibit F
/// Quadruple space (skip 3 lines = 44pt) before/after when on page with text
#let dmin-figure(number: auto, caption: "", figure-content, source: none, breakable: false) = context {
  let s = dmin-get-strings(au-dmin-lang.get())
  let formatted = format-title(caption)
  let content = [
    #figure-content
    #if source != none [
      #block(width: 100%, above: 6pt, below: 0pt)[
        #set text(size: 10pt, weight: "regular")
        #set par(leading: word-single-leading, spacing: word-single-leading, first-line-indent: 0pt, justify: false)
        #source
      ]
    ]
  ]
  figure(
    content,
    caption: figure.caption(position: bottom)[#formatted],
    kind: image,
    supplement: s.figure,
  )
}

/// DMin Isolated Figure — Chapter 2 (p. 7, Rule 3) & Exhibit F
/// Placed on its own separate page (pagebreak before and after; no body text sharing the page)
#let dmin-figure-isolated(number: auto, caption: "", figure-content, source: none) = [
  #pagebreak(weak: true)
  #dmin-figure(number: number, caption: caption, figure-content, source: source)
  #pagebreak()
]

/// Appendix Section — Chapter 2 (p. 4, 11)
/// If cover-sheet: true, creates a half-title divider sheet (centered horizontally, 2" from top edge per p. 11,
/// counted but unnumbered per p. 4) and places body on the next page with normal page numbering restored.
/// If cover-sheet: false (default), starts page with APPENDIX A + TITLE at top (2" margin) and body below.
#let appendix-section(title: "", cover-sheet: false, body) = [
  #let formatted = format-title(title)
  #appendix-counter.step()
  #if cover-sheet [
    #[
      #set page(footer: none)
      #v(1.0in) // 2 inches from top edge of half-title page per Chapter 2 (p. 11)
      #align(center)[
        #set text(size: 12pt)
        #context {
          let s = dmin-get-strings(au-dmin-lang.get())
          block(width: 100%, above: 0pt, below: word-space-skip-2)[
            #set par(leading: word-single-leading, first-line-indent: 0pt)
            #s.appendix #appendix-counter.display("A")
          ]
        }
        #context {
          let title-leading = get-title-leading(formatted, auto, width: 6.0in)
          block(width: 100%, above: 0pt, below: 0pt)[
            #set par(leading: title-leading, spacing: title-leading, first-line-indent: 0pt, justify: false)
            #upper(formatted)
          ]
        }
      ]
      #heading(level: 1, numbering: "A.", supplement: [Appendix-cover], outlined: true)[#formatted]
    ]
    #set par(
      leading: word-double-leading,
      spacing: word-double-leading,
      first-line-indent: (amount: 0.5in, all: true),
      justify: false,
    )
    #body
  ] else [
    #heading(level: 1, numbering: "A.", supplement: [Appendix], outlined: true)[#formatted]
    #set par(
      leading: word-double-leading,
      spacing: word-double-leading,
      first-line-indent: (amount: 0.5in, all: true),
      justify: false,
    )
    #body
  ]
]

/// Reference List — Chapter 5 & Appendix A (p. 13 & p. 27)
/// Single-spaced within entries, double-spaced between entries (word-space-skip-1 = 16pt)
#let dmin-bibliography(bib-file, style: "../csl/andrews-university-dmin-author-date.csl", title: auto, full: false) = [
  #context {
    let s = dmin-get-strings(au-dmin-lang.get())
    let display-title = if title == auto { s.ref_list } else { upper(title) }
    heading(level: 1, numbering: none, outlined: true)[#display-title]
  }

  // Забороняє розривати будь-яке окреме джерело навпіл між сторінками
  #show bibliography: set grid.cell(breakable: false)
  #show bibliography: set block(spacing: word-space-skip-1)

  #set par(
    leading: word-single-leading,
    spacing: word-space-skip-1,
    hanging-indent: 0.5in,
    first-line-indent: 0pt,
    justify: false,
  )
  #bibliography(bib-file, style: style, title: none, full: full)
]
