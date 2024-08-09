#import "@preview/polylux:0.3.1": *
#import "@preview/fontawesome:0.1.0": *

#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  // footer: [Optional Footnote]
)

#set text(font: "Fira Sans", weight: 350, size: 20pt)
#show math.equation: set text(font: "New Computer Modern Math")
#set strong(delta: 200)
#set par(justify: true)
#set list(spacing: 1.9em)

#set quote(block: true)
#show quote: set align(left)
#show quote: set pad(x: 2em, y: -0.8em)

#set raw(tab-size: 4)
#show raw: set text(size: 0.7em)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1em, y: 1em),
  radius: 0.7em,
  width: 100%,
)

#show bibliography: set text(size: 0.75em)
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

#slide(title: "Aggregate Computing")[
  #underline[_Aggregate computing_] #fcite("DBLP:journals/computer/BealPV15") enables the definition of *collective* applications leveraging:

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
  #quote[Shift from a #underline[device-centric] to a #alert[collective-centric] view of the system.]
]

// #slide(title: "Field Calculus")[
//   The #underline[field] as a unifying abstraction for the #alert[field calculus] #fcite("DBLP:conf/forte/DamianiVPB15") is inspired by physical concepts.

//   A *Field* is a mapping from each #underline[device] to some #underline[local value] $("dev" #math.arrow #math.bb("V"))$.

//   Fields are built and manipulated using four *program constructs:*

//   #v(1em)

//   #side-by-side(columns: (auto, auto, auto, auto))[
//     === Function
//     ```
     
//     b(e1,...,en)
     
//     ```
//   ][
//     === State evolution
//     ```
//     rep(x <- v) {
//       s1;...;sn
//     }
//     ```
//   ][
//     === Value propagation
//     ```
     
//     nbr(s)
     
//     ```
//   ][
//     === Restriction
//     ```
//     if(e) {s1;...;sn}
//     else {s1';...;sn'}
     
//     ```
//   ]
// ]

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
    4. Sleep until next #alert[round]...
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
    #figure(image("images/edge-cloud-continuum.svg", height: 80%))
  ]

  // #align(center)[
  //   The #alert[opportunistic] use of the _continuum_ offers new possibilities, \
  //   but requires fexible #alert[deployment] strategies.
  // ]
]

#new-section-slide("Motivation")

#slide(title: "Motivation")[
  Traditionally, *AC* programs are deployed on #alert[each physical device] of the application.
  #side-by-side(columns: (2fr, auto), gutter: 1.5em)[
    Two main #underline[limitations]:
    1. *resource-constrained* devices cannot satisfy all the components' requirements
    2. available *infrastructure* is not exploited to its full potential (performance vs cost)

    Previous work #fcite("FARABEGOLI2024") tried to partition the AC execution model but did not consider the *modularity* at the macro-program level.
  ][
    #figure(image("images/ac-monolithic-motivation.svg", height: 68%))
  ]
]

#slide(title: "Different Service Requirements")[
  #figure((image("images/macro-program-requirements.svg", width: 70%)))
]

#new-section-slide("Macro-components") // Qui, se troviamo un nome per l'approccio, lo mettiamo

#slide(title: "System model: physical system")[
  / Physical system: network of #alert[physical devices] $#math.delta #math.in upright(bold("D"))_italic(P)$, exchanging messages according to #alert[physical neighbourhood] relation $cal(N)_P$.

  #figure(image("images/physical-system.svg", width: 73%))
]

#slide(title: "System model: macro-program and application devices")[
  / Application logic: it is captured by a #alert[macro-program] $mono("MP")$.
  / Application devices: subset of the physical devices $upright(bold("D"))$ that execute the $mono("MP")$.

  #only(1)[#figure(image("images/application-devices.svg", width: 73%))]
  #only(2)[
    #figure(image("images/application-devices-neighbourhood.svg", width: 73%))

    #align(center)[The neighbouring relation of #alert[application devices] is a a #underline[subset] of $cal(N)_P$.]
  ]
]

#slide(title: "System model: infrastructural devices")[
  / Infrastructural devices: subset of the _physical devices_ $upright(bold("D"))_I #math.subset.eq upright(bold("D"))_P$ that #alert[can support execution] of some computation on behalf of some _application device_.

  #only(1)[#figure(image("images/infrastructural-devices.svg", width: 73%))]
  #only(2)[
    #figure(image("images/infrastructural-devices-hybrid.svg", width: 73%))

    #align(center)[A _physical deivce_ can be both an #alert[application device] and an #alert[infrastructural device].]
  ]
]

#slide(title: "System model: sensors and actuators")[
  / Sensors and actuators: a device is assumed to have #alert[sensors] and #alert[actuators] to interact with the local environment.

  #figure(image("images/sensors-actuators.svg", width: 73%))
]

#slide(title: "Macro-programming Model")[
  #side-by-side(columns: (2fr, 1fr), gutter: 1.5em)[
    / Macro-program: _direct acyclic graph_ (DAG) of #alert[components] --- $mono("MP")\(overline(mono("C")), overline(mono("B"))\)$
    / Component: atomic functional macro-program taking a list of #alert[inputs] and producing an #alert[output] --- $mono("C")$
    / Port: property of each _component_ through which the #alert[values] are received and produced (inputs and output of a function) --- $mono("p")$
    / Binding: indicates that the #alert[output port] of a component is connected to the #alert[input port] of other components --- $italic("component")\(mono("p"), mono("C"), overline(mono("p")))$
  ][
    #figure(image("images/partitioned-macro-program.svg", width: 95%))
  ]
]

#slide(title: "Macro-programming Model: Local vs Collective Components")[
  #side-by-side(columns: (2fr, auto), gutter: 1.5em)[
    / Local component: just a transformation of #alert[local inputs] to #alert[local outputs].
    / Collective component: requires the interaction with _instances_ of the #alert[same component] in *neighbours*.
  ][
    #figure(image("images/collective-local-components.svg", height: 80%))
  ] 
]

#slide(title: "Application and deployment model")[
  #side-by-side(columns: (2fr, auto), gutter: 1.5em)[
    // The macro-program $#math.mono("MP")$ is executed  by a $#math.bold("D")$ set of #alert[application devices].

    // Typically the $#math.mono("C")^j_i$ component is executed on the $#math.delta _j$ device (called #alert[owner]).

    // There may be conditions *preventing the execution* of the $#math.mono("C")^j_i$ component on the owner device (e.g., _lack sensor/actuators_, _computational capabilities_, ...).

    Not all the $#math.mono("C")^j_i$ components *can be executed* by the $#math.delta _j$ device (e.g., _lack sensor/actuators_, _computational capabilities_, _non-functional requirements_, ...).

    In such cases, the $#math.mono("C")^j_i$ is offloaded to an *infrastructural device* (#alert[surrogate]).
  ][
    #figure(image("images/offloading-surrogate.svg", height: 75%))
  ]

  #align(center)[
    The offloading can be *iterative* determining a #alert[forward chain] involving multiple devices.
  ]
]

#slide(title: "Execution model: asyncronous round")[
  #only(1)[
    Each #underline[component] is #alert[independently executable].
    
    Its behaviour is organised in #alert[rounds].

    #underline[Outputs] of rounds at each component generate #alert[message] to be shipped.

    #figure(image("images/message-propagation.svg", height: 52%))
  ]
    // The #alert[main goals] of this execution model are (#underline[formalised in the paper]):
    // - #alert[deployment independent] macro-program specification
    // - #alert[self-stabilising] #fcite("DBLP:journals/tomacs/ViroliABDP18") property is preserved w.r.t. the "monolithic" deployment

]

#slide(title: "Deployment independence of self-stabilising computations")[
  #only(1)[
    === Theorem 1 (Self-stabilisation)

    #quote[
      Given a $mono("MP")$ defining the components $mono(C)_1, #math.dots, mono(C)_n$ and a #underline[correct deployment],
      then, if _(i)_ all components implement #alert[self-stabilising] computation,
      and _(ii)_ sensor state is #alert[uniform] across all the #underline[forward chains],
      then the behaviour observed at the #underline[global output ports] is #alert[self-stabilising],
      independently from the #alert[deployment].
    ]
  ]
  #only(2)[
    === Proof based on operational semantics
    - No forwarding $#math.arrow$ same as #underline[monolithic] $#math.arrow$ #alert[true] as per #fcite("DBLP:journals/tomacs/ViroliABDP18")
    - If only #underline[1] component $#math.arrow$ #alert[true] by #underline[hypotesis] (self-stabilising components)
    - If #underline[multiple] components, #alert[true] as per #underline[functional composition]#super[4] of components
    - If #underline[forward chain] > 1, and each device fairily #alert[fires], it is guaranteed that the message travel from #underline[source] to #underline[destination] and back $#math.arrow$ #alert[true] since the input messages are eventually the same
  ]
]

#slide(title: "Rescue scenario: partitioned macro-program")[
  #figure(image("images/rescue-scenario.svg"))
]

#slide(title: "Rescue scenario: deployment example")[
  #figure(image("images/rescue-scenario-deployment.svg"))
]

#new-section-slide("Evaluation")

// #slide(title: "Evaluation goals")[
//   The evaluation aims at:
//   1. Validating the provided implementation toolchain and the proposed approach to test and #alert[simulate heterogeneous deployments]
//   2. Validating the ability of the system to converge to a stable state #alert[equal] to the one obtained in a monolithic deployment
//   3. Showcase the benefits of the proposal w.r.t. #alert[non-functional aspects] like low energy consumption
// ]

#slide(title: "Experimental setup")[
  We setup #underline[three] incremental complex self-organising behaviours:

  1. *Gradient*: computation of the distances from a source to all the other devices #fcite("DBLP:journals/computer/BealPV15")
  2. *SCR*: an implementation of the #alert[_self-organising coordination regions_] #fcite("DBLP:journals/fgcs/PianiniCVN21") pattern for splitting the network into sub-regions for handling problems in sub-spaces
  3. *Rescue scenario*: a city event scenario where people participate in the event and when an emergency occurs, a rescue team intervenes to help the people
]

#slide(title: "Results: gradient convergence")[
  #figure(image("images/gradient_convergence.svg"))
  #figure(image("images/gradient_convergence_error.svg"))
]

#slide(title: "Results: SCR convergence")[
  #figure(image("images/scr_convergence.svg"))
  #figure(image("images/scr_convergence_error.svg"))
]

#slide(title: "Results: rescue scenario")[
  #figure(image("images/power_consumption_modularisation.svg"))

  #align(center)[
    The #alert[modularisation] of the macro-program allows to #alert[reduce] the #alert[energy consumption] of the devices, but more messages are exchanged.
  ]
]

#new-section-slide("Conclusions")

#slide(title: "Conclusions and Future Work")[
  We addressed the problem of #underline[multi-component] macro-program #alert[execution] and #alert[deployment] in the *ECC*, improving operational flexibility.

  We proved both #underline[formally] and #underline[empirically] that the proposed approach preserves the same #alert[functional] behaviour of the monolithic counterpart, showing #alert[non-functional] benefits.

  *Future work*:

   - Support #alert[dynamic] deployments and #alert[reconfiguration]
   - Introduce #alert[capabilities] to constrain the components' execution
   - Integrates the approach with tools like #alert[kubernetes] to achieve *real deployments*
   - Exploit the *FaaS* paradigm for components offloading and execution
]

#focus-slide("Thank you for your attention!")

#slide[
  #bibliography("bibliography.bib")
]
