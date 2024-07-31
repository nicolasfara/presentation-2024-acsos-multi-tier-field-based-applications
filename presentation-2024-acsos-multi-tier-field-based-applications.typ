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
#set list(spacing: 1.9em)

#set quote(block: true)
#show quote: set align(left)
#show quote: set pad(x: 2em, y: -0.8em)

#set raw(tab-size: 4)
#show raw: set text(size: 0.8em)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1em, y: 1em),
  radius: 0.7em,
  width: 100%,
)

#show bibliography: set text(size: 0.8em)
#show footnote.entry: it => {
  block(inset: (x: 2em, y: 0.1em))[#text(size: 0.75em)[#it.note.body]]
}

#let fcite(clabel) = {
  footnote(cite(form: "full", label(clabel)))
}

#let mail(email) = {
  text(size: 1.3em)[#raw(email)]
}

#let authors = block(inset: 0.1em)[
  #table(inset: 0.5em, stroke: none, columns: (auto, 4fr),  align: (left, left),
    [#alert[*Nicolas Farabegoli*]], [#mail("nicolas.farabegoli@unibo.it")],
    [Mirko Viroli], [#mail("mirko.viroli@unibo.it")],
    [Roberto Casadei], [#mail("roby.casadei@unibo.it")],
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

// #slide(title: "Aggregate Computing")[
//   #place(right, dx: -17em)[
//     #line(start: (19.5em, 0em), end: (19.5em, 88%), stroke: 0.05em + rgb("#23373b"))
//   ]
//   #side-by-side(gutter: 1em, columns: (1fr, auto))[
//     === Self-org Computational Model

//     #text(size: 0.85em)[#alert[Interaction:] _repeated_ *neighbours* msg exchange] \
//     #text(size: 0.85em)[#alert[Behaviour:] _repeated_ execution with #underline[async rounds]]

//     === Collective Abstractions

//     #text(size: 0.85em)[#alert[Abstraction:] *computational fields*] $("dev" #math.arrow #math.bb("V"))$

//     #side-by-side(columns: (auto, auto))[
//       #figure(image("images/scr-result.png", width: 88%))
//     ][
//       #figure(image("images/channel-sim.png", width: 76%))
//     ]
//   ][
//     === Programming Model

//     #text(size: 0.85em)[#alert[Formal Language:] Field Calculus] \
//     #text(size: 0.85em)[#alert[Paradigm:] Functional, Macro-programming]
//     #v(0.4em)
//     #figure(image("images/channel.svg", height: 50%))
//   ]

//   #quote[
//     #align(center)[
//       #text(size: 1em)[Typical deployments on #alert[_flat_] and #alert[_homogeneous_] device networks.]
//     ]
//   ]  
// ]

#slide(title: "Aggregate Computing")[
  #underline[_Aggregate computing_] #fcite("DBLP:journals/computer/BealPV15") enables the definition *collective* applications leveraging:

  #side-by-side(columns: (2fr, auto))[
      - *spatial* and *temporal* operators
      - *macroprogramming* abstractions
      - resilient *coordination* mechanisms
      - *proximity-based* interaction (neighbours)
  ][
    #align(right)[
      #figure(image("images/scr-result.png", height: 55%))
    ]
    // #figure(image("images/channel-sim.png", width: 42%))
  ]
  #quote[Shfit from a #underline[device-centric] to a #alert[collective-centric] view of the system.]
]

#slide(title: "Field Calculus")[
  The #underline[field] as a unifying abstraction for the #alert[field calculus] #fcite("DBLP:conf/forte/DamianiVPB15") inspired by physical concepts.

  A *Field* is a mapping from each #underline[device] to some #underline[local value] $("dev" #math.arrow #math.bb("V"))$.

  Fields are built and manipulated using four *program constructs:*

  #v(1em)

  #side-by-side(columns: (auto, auto, auto, auto))[
    === Function
    ```
     
    b(e1,...,en)
     
    ```
  ][
    === State evolution
    ```
    rep(x <- v) {
      s1;...;sn
    }
    ```
  ][
    === Value propagation
    ```
     
    nbr(s)
     
    ```
  ][
    === Restriction
    ```
    if(e) {s1;...;sn}
    else {s1';...;sn'}
     
    ```
  ]
]

#slide(title: "Self-org Computational Model")[
  #alert[Behaviour:] _repeated_ execution with #underline[async rounds] \
  #alert[Interaction:] _repeated_ *neighbours* #underline[messages exchange]

  #line(length: 100%, stroke: 0.05em + rgb("#23373b"))

  #only(1)[
    1. Receiving #alert[messages] from neighbours
    #figure(image("images/ac-messages-perception.svg"))
  ]
  #only(2)[
    2. Computation of the #alert[macro-program] against the received messages
    #figure(image("images/ac-computation.svg"))
  ]
  #only(3)[
    3. Sending to neighbours the #alert[computed messages]
    #figure(image("images/ac-messages-propagation.svg"))
  ]
  #only(4)[
    4. Sleep until next #alert[round...]
    #figure(image("images/ac.svg"))
  ]
]

#slide(title: "Aggregate Programming")[

  #side-by-side(columns: (2fr, auto))[
    == Field Composition
    ```scala
    def channel(source: Boolean, destination: Boolean): Boolean {
      val toSource = gradient(source) // Field[Double]
      val toDestination = gradient(destination) // Field[Double]
      val distance = distanceTo(source, destination)
      (toSource + toDestination - distance) <= 10
    }
    ```

    (_collective_) functions take *fields* as #alert[input] and return *field* as #alert[output].
  ][
    #figure(image("images/channel.svg", height: 50%))
  ]

  #v(1em)

  #align(center)[
    The entire (_macro_-)program is executed by #alert[all the devices] in the network, \
    assuming that each device *can* execute the program.
  ]
]

#slide(title: "Edge-Cloud Continuum")[
  #side-by-side(gutter: 2em, columns: (2fr, auto))[
    #quote[Aggregation of #alert[computational resources] along the data path from the *edge* to the *cloud* #fcite("DBLP:journals/access/MoreschiniPLNHT22")]

    #v(1em)

    We must deal with different #alert[capabilities] and #alert[constraints]:
    - edge devices for #underline[sense/acting], but *resources-constrained*
    - cloud instances for #underline[scalability], but *latency/privacy* issues
  ][
    #figure(image("images/edge-cloud-continuum.svg", height: 65%))
  ]

  // #align(center)[
  //   The #alert[opportunistic] use of the _continuum_ offers new possibilities, \
  //   but requires fexible #alert[deployment] strategies.
  // ]
]

#new-section-slide("Motivation")

#slide(title: "Motivation")[
  Traditionally, *AC* programs are deployed on #alert[each physical device] of the application.

  Two main #underline[limitations]:
  1. *resource-constrained* devices cannot satisfy all the requirements
  2. available *infrastructure* is not exploited to its full potential (performance vs cost)

  Previous work #fcite("FARABEGOLI2024") tried to partition the AC execution model,
  but do not consider the the *modularity* at the macro-program level.
]

#slide(title: "Different Service Requirements")[
  #figure((image("images/macro-program-requirements.svg", width: 70%)))
]

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
