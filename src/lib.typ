#let palette = (
  heading-block-fill: rgb("#0f2752"),
  math-blue: rgb("#244e98"),
)

#let template-config = (
  page: (flipped: true, columns: 4, margin: (x: 3mm, y: 1mm)),
  columns: (gutter: 6mm),
  palette: palette,
  settings: (
    math: (
      math-color: palette.math-blue,
      color-math-block: true,
      color-math-inline: true,
    ),
  ),
  styles: (
    document-text: (font: "New Computer Modern", size: 6pt),
    line: (stroke: (paint: palette.heading-block-fill)),
    heading-block: (
      fill: palette.heading-block-fill,
      above: 1em,
      inset: (left: 0em, right: 0.5em, y: 0.5em),
      outset: (left: 0.5em),
      width: 100%,
    ),
    heading-text: (
      lv1: (
        font: "Libertinus Serif",
        size: 8pt,
        fill: white,
        weight: "bold",
      ),
      lv2: (
        font: "Libertinus Serif",
        size: 7pt,
        fill: palette.heading-block-fill,
        weight: "bold",
      ),
      lv3: (
        font: "Libertinus Serif",
        size: 6pt,
        fill: palette.heading-block-fill,
        weight: "bold",
        style: "italic",
      ),
    ),
  ),
)

#let block-heading(..args, it) = {
  block(..args.named(), it)
}

#let styalise-math(..args, it) = {
  let (math-color, color-math-block, color-math-inline) = args.named()

  show math.equation.where(block: true): set text(
    fill: math-color,
  ) if color-math-block

  show math.equation.where(block: false): set text(
    fill: math-color,
  ) if color-math-inline

  it
}

#let styalise-headings(..args, it) = {
  let args = args.named()

  show heading.where(level: 1): it => {
    set text(..args.heading-text.lv1)
    block-heading(..args.heading-block, it)
  }

  show heading.where(level: 2): it => {
    set text(..args.heading-text.lv2)
    set block(above: 0.5em, below: 0.5em)

    it
  }

  show heading.where(level: 3): it => {
    set text(..args.heading-text.lv3)
    set block(above: 0.5em, below: 0.5em)

    box(it)
  }

  it
}

#let mem(..args, it) = {
  let cfg = template-config + args.named()

  set columns(..cfg.columns)
  set page(..cfg.page)
  set text(..cfg.styles.document-text)
  set line(..cfg.styles.line)

  show strong: set text(fill: palette.heading-block-fill)
  show: styalise-math.with(..cfg.settings.math)
  show: styalise-headings.with(..cfg.styles)

  it
}

#let student-info(..args) = {
  set list(marker: [])

  let info = block(
    width: 99%,
    inset: (y: 1mm, right: 1mm),
    radius: 3pt,
    fill: white,
    for (k, v) in args.named().pairs() {
      [- #text(k, weight: "bold"): #text(v)]
    },
  )

  block(
    radius: 3pt,
    stroke: (
      left: 0pt,
      rest: 1pt + palette.heading-block-fill,
    ),
    fill: palette.heading-block-fill,
    inset: 1mm,
    grid(
      columns: 2,
      align(
        center + horizon,
        rotate(-90deg, reflow: true, block(
          fill: palette.heading-block-fill,
          inset: (top: 0.5mm, bottom: 1.5mm),
          text(
            fill: white,
            weight: "bold",
            [#(datetime.today().year())],
          ),
        )),
      ),
      info,
    ),
  )
}
