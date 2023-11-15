#let style(body) = {
  set page(paper: "presentation-16-9", margin: 2em)
  set text(size: 25pt, font: "Pretendard", lang: "ko")
  set footnote(numbering: "1)")
  body
}

#let slide(title, body) = {
  set page(header: [= #title], margin: (top: 4em))
  body
}

#let problem(id, title) = link("https://www.acmicpc.net/problem/" + id)[#id #title]

#let link(body) = text(fill: blue)[#underline(stroke: blue)[#body]]

#let footnote(body) = text(size: 0.7em, body)

#let algorithm(caption, body) = text(size: 15pt)[
  #figure(body, caption: caption, kind: "algorithm", supplement: body => strong[알고리즘])
]