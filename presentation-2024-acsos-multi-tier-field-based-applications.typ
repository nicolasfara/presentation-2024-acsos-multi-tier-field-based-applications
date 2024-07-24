#import "@preview/polylux:0.3.1": *
#import "@preview/fontawesome:0.1.0": *

#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  // footer: [Optional Footnote]
)

#set text(font: "Fira Sans", weight: 350, size: 20pt)
#show math.equation: set text(font: "Fira Math")
#set strong(delta: 200)
#set par(justify: true)

#set quote(block: true)
#show quote: set align(left)
#show quote: set pad(x: 2em, y: -0.8em)

#set raw(tab-size: 4)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1.5em, y: 1em),
  radius: 0.7em,
  // width: 100%,
)

#show bibliography: set text(size: 0.8em)
#show footnote.entry: it => {
  block(inset: (x: 2em, y: 0.1em))[#text(size: 0.75em)[#it.note.body]]
}

#let fcite(clabel) = {
  footnote(cite(form: "full", label(clabel)))
}

#let authors = block(inset: 0.1em)[
  #table(inset: 0.5em, stroke: none, columns: (auto, 4fr),  align: (left, left),
    [#alert[*Nicolas Farabegoli*]], [`nicolas.farabegoli@unibo.it`],
    [Mirko Viroli], [`mirko.viroli@unibo.it`],
    [Roberto Casadei], [`roby.casadei@unibo.it`],
  )
  #place(right, dy:-1em)[
    #figure(image("images/disi.svg", width:40%))
  ]
]

#title-slide(
  title: [
    Flexible Self-organisation for the Cloud-Edge Continuum: \
    a Macro-programming Approach
  ],
  // subtitle: "Subtitle",
  author: authors,
  // date: datetime.today().display("[day] [month repr:long] [year]"),
)

#new-section-slide("Background")

#slide(title: "Aggregate Computing")[
  #place(right, dx: -17em)[
    #line(start: (19.5em, 0em), end: (19.5em, 88%), stroke: 0.05em + rgb("#23373b"))
  ]
  #side-by-side(gutter: 1em, columns: (1fr, auto))[
    === Self-org Computational Model

    #text(size: 0.85em)[#alert[Interaction:] _repeated_ *neighbours* msg exchange] \
    #text(size: 0.85em)[#alert[Behaviour:] _repeated_ execution with #underline[async rounds]]

    === Collective Abstractions

    #text(size: 0.85em)[#alert[Abstraction:] *computational fields*] $("dev" #math.arrow #math.bb("V"))$

    #side-by-side(columns: (auto, auto))[
      #figure(image("images/scr-result.png", width: 88%))
    ][
      #figure(image("images/channel-sim.png", width: 76%))
    ]

  ][
    === Programming Model

    #text(size: 0.85em)[#alert[Formal Language:] Field Calculus] \
    #text(size: 0.85em)[#alert[Paradigm:] Functional, Macro-programming]
    #v(0.4em)
    #figure(image("images/channel.svg", height: 50%))
  ]

  #quote[
    #align(center)[
      #text(size: 1em)[Typical deployments on #alert[_flat_] and #alert[_homogeneous_] device networks.]
    ]
  ]  
]

#slide(title: "Aggregate Computing - Repeating")[
  #side-by-side(gutter: 1em, columns: (1fr, auto))[
    === State Evolution
    ```scala
    rep(0) { case prev =>
      prev + 1
    }
    ```
  ][
    #only(1)[#figure(image("images/ac-rep-1.svg"))]
    #only(2)[#figure(image("images/ac-rep-2.svg"))]
    #only(3)[#figure(image("images/ac-rep-3.svg"))]
    #only(4)[#figure(image("images/ac-rep-4.svg"))]
  ]
]

#slide(title: "Edge-Cloud Continuum")[
  #side-by-side(gutter: 2.5em, columns: (auto, 1fr))[
    #figure(image("images/edge-cloud-continuum.svg", height: 100%))
  ][
    TODO
  ]
]

#new-section-slide("Motivation")

#new-section-slide("Macro-components") // Qui, se troviamo un nome per l'approccio, lo mettiamo

#slide(title: "System Model")[

]

#slide(title: "Macro-programming Model")[

]

#slide(title: "Execution Model (semantics)")[

]

#new-section-slide("Evaluation")

#slide(title: "Experimental Setup")[

]

#slide(title: "Results")[

]

#new-section-slide("Conclusions")

#slide(title: "Conclusions and Future Work")[

]

#focus-slide("Thank you for your attention!")

#slide[
  #bibliography("bibliography.bib")
]
