#import "@preview/physica:0.9.6": *
#import "/src/lib.typ": mem, palette, student-info

#show: mem

#let eqs = (
  $
    x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a)
  $,
  $
    laplace u(r, theta) = 1/r^2 pdv(u, theta, 2) + 1/r pdv(u, r) + pdv(u, r, 2)
  $,
  $
    // Fourier Operator
    cal(F)(f)(xi) = integral_(-oo)^(oo) f(t) e^(-2 pi i t xi) dd(t)
  $,
)

#block(
  inset: (left: 1mm, right: 3mm),
  student-info(
    Name: "John Doe",
    ID: "c1234567",
    Course: "MATH3800",
    Email: "John.Doe@uni.edu.au",
  ),
)

#for _ in range(10) [
  = #lorem(3)
  #for i in range(eqs.len()) [
    == #lorem(5)

    #lorem(15)

    #eqs.at(calc.rem-euclid(i, eqs.len()))

    #for j in (3, 6, 5) [
      === #lorem(j)
      #lorem(25)
      #linebreak()
    ]
  ]
]
