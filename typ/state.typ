// ==============================================================================
// 📌 AU DMin Template Global States & Counters
// ==============================================================================

#let seen-chapter = state("au-dmin-seen-chapter", false)
#let seen-appendix = state("au-dmin-seen-appendix", false)
#let is-first-subhead = state("au-dmin-is-first-subhead", true)
#let appendix-counter = counter("au-dmin-appendix")
#let au-dmin-lang = state("au-dmin-lang", "en")

#let au-dmin-meta = state("au-dmin-meta", (
  title: "PROJECT DISSERTATION TITLE IN ALL CAPS",
  author: "Author Full Name",
  degree: "Doctor of Ministry",
  advisor: "Advisor Name, Ph.D.",
  second-reader: "Second Reader Name, D.Min.",
  third-reader: none,
  program-director: "Stanley E. Patterson, Ph.D.",
  dean: "Jiří Moskala, Th.D., Ph.D.",
  date: "Month Year",
  university: "Andrews University",
  school: "Seventh-day Adventist Theological Seminary",
  date-approved: "Month Day, Year",
  lang: "en",
))
