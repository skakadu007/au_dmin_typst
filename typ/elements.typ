// ==============================================================================
// 📌 AU DMin Text & Structural Elements
// ==============================================================================

#import "state.typ": *
#import "i18n.typ": *

/// Helper to handle string/content line breaks with \ or \n
#let format-title(t) = {
  if type(t) == str {
    if t.contains("\\") {
      let parts = t.split("\\")
      parts.map(p => p.trim()).join(linebreak())
    } else if t.contains("\n") {
      let parts = t.split("\n")
      parts.map(p => p.trim()).join(linebreak())
    } else {
      t
    }
  } else {
    t
  }
}

/// Chapter heading — Exhibit I
/// Generates: CHAPTER N [triple space] TITLE IN ALL CAPS
#let dmin-chapter(title: "") = [
  #let formatted = format-title(title)
  #heading(level: 1, numbering: "1.", outlined: true)[#formatted]
]

/// Level 5 Subheading (AU Level 5): Run-in to paragraph
/// Indented 0.5", Bold, sentence style, ends with period (Ch.2 p.10)
/// Preceded by triple space (above: 24pt). Followed by double space (built into paragraph).
/// Usage: #subhead5[Students feel responsible][When the students...]
#let subhead5(title, body) = {
  block(width: 100%, above: 24pt)[
    #par(first-line-indent: 0.5in)[
      #text(weight: "bold")[#title.]
      #h(0.3em)
      #body
    ]
  ]
}

/// Block Quote — Chapter 3 (p. 12)
/// 5+ lines of quoted material; single-spaced; indented 0.25in (quarter inch)
/// Double space before and after (above: 12pt, below: 12pt)
#let blockquote(body) = [
  #block(width: 100%, above: 12pt, below: 12pt)[
    #pad(left: 0.25in)[
      #set par(leading: 6pt, spacing: 6pt, first-line-indent: 0pt, justify: false)
      #set text(size: 12pt)
      #body
    ]
  ]
]

/// DMin Table — Chapter 2 (p. 7-8) & Chapter 3 (p. 13) & Exhibit F
/// Quadruple space (skip 3 lines = 36pt) before/after when on page with text
#let dmin-table(number: auto, title: "", table-content, note: none) = context {
  let s = dmin-get-strings(au-dmin-lang.get())
  let formatted = format-title(title)
  figure(
    table-content,
    caption: figure.caption(position: top)[#formatted],
    kind: table,
    supplement: s.table,
  )
  if note != none [
    #v(4pt, weak: true)
    #set text(size: 10pt)
    #set par(leading: 4pt, first-line-indent: 0pt)
    #note
  ]
}

/// DMin Figure — Chapter 2 (p. 7-8) & Chapter 3 (p. 13) & Exhibit F
/// Quadruple space (skip 3 lines = 36pt) before/after when on page with text
#let dmin-figure(number: auto, caption: "", figure-content, source: none) = context {
  let s = dmin-get-strings(au-dmin-lang.get())
  let formatted = format-title(caption)
  figure(
    figure-content,
    caption: figure.caption(position: bottom)[#formatted],
    kind: image,
    supplement: s.figure,
  )
  if source != none [
    #v(4pt, weak: true)
    #set text(size: 10pt, weight: "regular")
    #set par(leading: 4pt, first-line-indent: 0pt)
    #source
  ]
}

/// Appendix Section — Chapter 2 (p. 11)
/// If cover-sheet: true, creates a centered divider sheet (APPENDIX A + TITLE) and puts body on next page without repeating heading.
/// If cover-sheet: false (default), starts page with APPENDIX A + TITLE at top (2" margin) and body below.
#let appendix-section(title: "", cover-sheet: false, body) = [
  #let formatted = format-title(title)
  #appendix-counter.step()
  #if cover-sheet [
    #pagebreak(weak: true)
    #set page(footer: none)
    #v(2.5in)
    #align(center)[
      #set text(size: 12pt)
      #set par(leading: 12pt, first-line-indent: 0pt)
      #context {
        let s = dmin-get-strings(au-dmin-lang.get())
        [#s.appendix #appendix-counter.display("A") \ ]
      }
      #v(12pt)
      #upper(formatted)
    ]
    #heading(level: 1, numbering: "A.", supplement: [Appendix-cover], outlined: true)[#formatted]
    #pagebreak()
    #set par(leading: 12pt, first-line-indent: 0.5in, justify: false)
    #body
  ] else [
    #heading(level: 1, numbering: "A.", supplement: [Appendix], outlined: true)[#formatted]
    #set par(leading: 12pt, first-line-indent: 0.5in, justify: false)
    #body
  ]
]

/// Reference List — Chapter 5 & Appendix A
#let dmin-bibliography(bib-file, style: "../csl/andrews-university-dmin-author-date.csl", title: auto) = context {
  let s = dmin-get-strings(au-dmin-lang.get())
  let display-title = if title == auto { s.ref_list } else { upper(title) }
  heading(level: 1, numbering: none, outlined: true)[#display-title]
  set par(
    leading: 6pt,
    spacing: 12pt,
    hanging-indent: 0.5in,
    first-line-indent: 0pt,
    justify: false,
  )
  bibliography(bib-file, style: style, title: none)
}
