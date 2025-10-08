#import "@preview/physica:0.9.6": *
#import "@preview/great-theorems:0.1.2": *

#import "/src/lib.typ": mem, palette, student-info

#let theorem = mathblock(
  blocktitle: "Theorem",
  titlix: title => [(#title)#" "],
  bodyfmt: body => {
    // set text(style: "italic")
    body
  },
)

#let lemma = mathblock(
  blocktitle: "Lemma",
  titlix: title => [(#title)#" "],
  bodyfmt: body => {
    // set text(style: "italic")
    body
  },
)

#let corollary = mathblock(
  blocktitle: "Corollary",
  titlix: title => [(#title)#" "],
  bodyfmt: body => {
    // set text(style: "italic")
    body
  },
)


#let proposition = mathblock(
  blocktitle: "Proposition",
  titlix: title => [(#title)#" "],
  bodyfmt: body => {
    // set text(style: "italic")
    body
  },
)

#let definition = mathblock(
  blocktitle: "Definition",
  titlix: title => [(#title)#" "],
  bodyfmt: body => {
    // set text(style: "italic")
    body
  },
)


#let example = mathblock(
  blocktitle: "Example",
  titlix: title => [(#title)#" "],
)

#let exercise = mathblock(
  blocktitle: "Exercise",
  titlix: title => [(#title)#" "],
)

#let remark = mathblock(
  blocktitle: "Remark",
  titlix: title => [(#title)#" "],
)

#let proof = proofblock(
  prefix: text(weight: "bold", "Proof."),
  prefix_with_of: of => text(
    weight: "bold",
    [Proof of #of.],
  ),
)

// Util functions

#let def_list(..items) = grid(
  inset: ((left: 3em), 0em),
  columns: 2,
  align: (right, left),
  column-gutter: 1em,
  row-gutter: 0.6em,
  ..items
)

#let prop_list(..items) = {
  let ns = range(1, items.pos().len() + 1)
    .map(x => strong(numbering("(i)", x)))
    .zip(items.pos())
    .flatten()

  def_list(
    column-gutter: 1em,
    inset: ((left: 5.5em), 0em),
    ..items.named(),
    ..ns,
  )
}

// Document

#show: mem
#show: great-theorems-init
#show math.equation.where(block: true): it => {
  set block(spacing: 0.5em)
  set par(leading: 0.2em)
  it
}
#show math.equation.where(block: false): box

#block(
  inset: (left: 1mm, right: 3mm),
  student-info(
    Name: "John Doe",
    ID: "c1234567",
    Course: "MATH3250",
    Email: "John.Doe@uni.edu.au",
  ),
)

= Basic Definitions

#definition(title: "Inner Product")[
  An _inner product_ on $V$ is a function that takes each ordered pair $(x,y)$ of elements
  of $V$ to a number $innerproduct(x, y) in FF$ and, $forall x,y,z in V,lambda in FF$, has
  the following properties:
  #def_list(
    [*Positivity*],
    $innerproduct(y, y) >= 0$,
    [*Definiteness*],
    $innerproduct(y, y) = 0 <==> y = 0$,
    [*Additivity*],
    $innerproduct(x + y, z) = innerproduct(x, z) + innerproduct(y, z)$,
    [*Homogeneity*],
    $innerproduct(lambda x, y) = lambda innerproduct(x, y)$,
    [*Conjugate Symmetry*],
    $innerproduct(x, y) = overline(innerproduct(y, x)) = innerproduct(y, x)^*$,
  )
]

#definition(title: "Norm")[
  #set enum(indent: 0em, numbering: n => strong(numbering("(i)", n)))
  Given a vector space $V$ over $FF = RR$ or $CC$, a _norm_ is a mapping
  $norm(#h(0.5mm)dot#h(0.5mm))) : V -> [0, oo)$ for which
  #prop_list(
    [$norm(f) >= 0$ and $norm(f) = 0 <==> f = 0$],
    [$norm(lambda f) = abs(lambda) norm(f)$],
    [$norm(f + g) <= norm(f) + norm(g)$],
  )

  for all $f,g in V$, $lambda in FF$.
  If $V$ is an inner product space, there is a trivial norm:
  $ norm(f) = sqrt(innerproduct(f, f)) $
]

= Normed Spaces

#theorem(title: "Triangle Inequality")[
  $
    norm(x+a) <= norm(x) + norm(a)
  $
]

#theorem(title: "Reverse Triangle Inequality")[
  $
    abs(size: #1.4em, norm(x) - norm(a)) <= norm(x - a)
  $
]

#example(title: "Example Normed Spaces")[
  $
           V = RR^n, & quad norm(x)_2 = inline(sqrt(sum_(j = 1)^n x_j^2)) \
            V =RR^2, & quad norm(x)_1 = abs(x_1) + abs(x_2) \
            V =RR^2, & quad norm(x)_(oo) = max {abs(x_1), abs(x_2)} \
    V = C([0,1],RR), & quad norm(f)_p = inline((integral_0^1 abs(f)^p)^(1/p))
  $
]

#definition(title: "Open and Closed Balls")[
  With $(X, norm(#h(0.5mm)dot#h(0.5mm)))$ a normed linear space, with $x_0 in X$,
  and $r > 0$:
  #def_list(
    [*Open Ball*],
    [With centre $x_0$ and radius $r$ as
      $ cal(B)(x_0, r) = {x in X : norm(x - x_0) < r} $],
    [*Closed Ball*],
    [With centre $x_0$ and radius $r$ as
      $ cal(B)[x_0, r] = {x in X : norm(x - x_0) <= r} $],
    [*Sphere*],
    [With centre $x_0$ and radius $r$ as
      $ cal(S)(x_0, r) = {x in X : norm(x - x_0) = r} $],
  )
]

= Inner Product Spaces

#example(title: "Inner-Product Space Examples")[
  - $ell^p$ space:
    $ ell^2 = ell^2(NN, CC) = {{c_k}_(k=1)^oo : sum_(k=1)^oo abs(c_k)^2 < oo} $

    And hence for $ell^2$ (the only $ell^p$ space that is a Hilbert space)
    $ innerproduct(x, y)_(ell^2) = sum_n x_n overline(y_n) $

  - $L^2(RR)$ space:
    $ innerproduct(x, y)_(L^2) = integral_(-oo)^oo f(x) overline(g(x)) dif x $
]

#theorem(title: "Cauchy-Schwarz Inequality")[
  Given that $V$ is an inner-product space over $FF$, then for all $f,g in V$:
  $ abs(innerproduct(f, g)) <= norm(f) norm(g) $
  When ${f, g}$ is a linearly dependent set, we have equality.
]

#colbreak(weak: true)

= Sequences and Convergence

#definition(title: "Cauchy Sequence")[
  A sequence ${a_n}$ of real numbers is a _Cauchy Sequence_ if
  $ forall epsilon > 0, exists N>0 : m,n>N ==> norm(a_m - a_n) < epsilon $
  Given that $n>N ==> norm(x_n - x) < epsilon$, then $lim_(n->oo) x_n = x$.
]

#definition(title: "Geometric Series")[
  A geometric series (aka "geometric progression") has sequence elements of the form
  $a_n = a r^n$, where $r$ is the "_common ratio_". The partial sum is given by:
  $ s_k = a((1 - r^k)/(1 - r)) $
  and so, given that $abs(r) < 1$, the partial sum limits to:
  $ lim_(n -> oo) sum_(k=1)^n a r^k = a/(1 - r) $
]

= Operator Theory

#proposition(title: "Operator Continuity")[
  Let $X$ and $Y$ be normed linear spaces and $T:X->Y$ be a linear mapping. Then, the
  following are equivalent:
  #prop_list(
    [$T$ is continuous at every point in $X$],
    [$T$ is continuous at $0$],
    [$T$ is bounded],
  )
]

= Hilbert Spaces

#theorem(title: "Riesz Representation Theorem")[
  Given a Hilbert space $cal(H)$ over $CC$ and a linear functional $F:cal(H)->CC$, there
  exists a unique $y=y_f$, for $y_f in cal(H)$ such that
  $ f(x) = innerproduct(x, y_f), quad forall x in cal(H) $
]

#definition(title: "Adjoint Operator")[
  Let $T:cal(H)_1 -> cal(H)_2$ be a bounded linear mapping between Hilbert spaces. The
  mapping $T^* : cal(H)_2 -> cal(H)_1$ is called the _adjoint_ of the operator $T$ and,
  for all $x in cal(H)_1$, $y in cal(H)_2$, is defined:
  $ innerproduct(T x, y)_2 = innerproduct(x, T^* y)_1 $
  $T$ is said to be _self-adjoint_ if $T=T^*$.
]

#definition(title: "Unitary Operator")[
  Let $cal(H)$ be a Hilbert space and $U in cal(B)(cal(H))$. We say that $U$ is _unitary_
  if $U$ is invertible and $U^(-1) = U^*$. Equivalently, $U U^* = U^* U = I$.
]

#definition(title: "Bounded Linear Operator")[
  Let $T:X->Y$ be a bounded linear operator between normed linear spaces. The _norm_ of
  $T$ is defined to be:
  $ norm(T) = inf{M > 0 : forall x in X, norm(T x) <= M norm(x)} $
  Note that $norm(T x) <= norm(T) norm(x)$ and $norm(T)$ is the smallest $M$ such that
  this is valid.
]

#proposition[
  Let $T:X->Y$ be a bounded linear operator between normed linear spaces. Then
  $ norm(T) = sup{norm(T x) : norm(x) = 1} $
]

#definition(title: "Normal Operator")[
  $T in cal(L)(V)$ is _normal_ if $T T^* = T^* T$. Furthermore, $T$ is normal if and only
  if $norm(T v)=norm(T^* v)$.
]

#example(title: "Orthogonal Sets")[
  $
    cal(H) = CC^N &
    #text("with", fill: black) {f_j (k) = 1/sqrt(N) e^(2 pi i j k slash N)}_(j=0)^(N-1) \
    //
    cal(H) = L^2 ([-1/2, 1/2]) &
    #text("with", fill: black) {f_j (x) = e^(2 pi i j x)}_(j=-oo)^oo \
    //
    cal(H) = L^2 (RR) &
    #text("with", fill: black) {f_j (x) = chi_([j, j+1]) (x)}_(j=-oo)^oo \
    //
    cal(H) = ell^2 (NN) &
    #text("with", fill: black) {e_j (k) = delta_(i j)}_(j=1)^oo
  $
]

#proposition[
  For ${x_n}$ an orthonormal set in $cal(H)$:
  $ sum_(n=1)^oo abs(innerproduct(x, x_n))^2 <= norm(x)^2 $
]


#colbreak(weak: true)

= Spectral Theory

#theorem(title: "Normal Operator Eigenvectors")[
  Suppose $T in cal(L)(V)$ is normal. Then, eigenvectors of $T$ corresponding to distinct
  eigenvalues are orthogonal.
]

#theorem(title: "Real Spectral Theorem")[
  Suppose $FF=RR$ and $T in cal(L)(V)$. Then, the following are equivalent:
  #prop_list(
    [$T$ is self-adjoint.],
    [$V$ has an orthonormal basis consisting of eigenvectors of $T$.],
    [$T$ has a diagonal matrix with respect to some orthonormal basis of $V$.],
  )
]

#theorem(title: "Complex Spectral Theorem")[
  Suppose $FF=CC$ and $T in cal(L)(V)$. Then, the following are equivalent:
  #prop_list(
    [$T$ is normal.],
    [$V$ has an orthonormal basis consisting of eigenvectors of $T$.],
    [$T$ has a diagonal matrix with respect to some orthonormal basis of $V$.],
  )
]

#theorem(title: "Diagonalisation")[
  A square $n times n$ matrix, $A$, with entries in a field $FF$ is called diagonalisable
  or non-defective if there exists an $n times n$ invertible matrix (i.e. an element of
  the general linear group $"GL"_n (FF)$), $P$, such that $P^(-1) A P$ is a diagonal
  matrix.

  Given that $Lambda$ is diagonal matrix with eigenvalue entries of $A$ on the main
  diagonal, then $A P = P Lambda$ implies that $P = V$, the matrix whose columns are
  eigenvectors to $A$, corresponding to the eigenvalue in the same column of $Lambda$. In
  this case: $ A = V Lambda V^(-1) $

  Note that one of the _spectral theorems_ may guarantee the existence of $Lambda$.
]

= Function Spaces

#definition(title: "Lebesgue Spaces")[
  Given two measurable functions $f$ and $g$, we say that $f tilde g$ if $f = g$ _almost
    everywhere_.

  For $1 <= p < oo$:
  $
    L^p (RR) = {f : RR -> CC : norm(f)_p = (integral abs(f)^p)^(1/p) < oo} slash tilde
  $
  For $p = oo$:
  $
    L^oo (RR) = {f : RR -> CC : norm(f)_oo = "ess sup" abs(f(x)) < oo} slash tilde
  $
  where
  $ "ess sup" abs(f) = inf{alpha in RR | mu{x in RR : abs(f(x)) > alpha} = 0} $
]

= Inequalities

#theorem(title: "Arithmetic-Geometric Mean Inequality")[
  For positive $x$ and $y$:
  $ 4x y <= (x + y)^2 $
  Notice that by expanding the RHS:
  $ 2x y <= x^2 + y^2 $
]

#colbreak(weak: true)

= Trigonometry

#definition[
  $
     sin z & = (e^(i z) - e^(-i z))/(2i) \
     cos z & = (e^(i z) + e^(-i z))/2 \
    sinh z & = (e^z - e^(-z))/2 \
    cosh z & = (e^z + e^(-z))/2
  $
]

#definition(title: "Double Angle Formulae")[
  $
    sin 2 theta & = 2 sin theta cos theta \
    cos 2 theta & = cos^2 theta - sin^2 theta \
                & = 2 cos^2 theta - 1 \
                & = 1 - 2 sin^2 theta \
    tan 2 theta & = (2 tan theta)/(1 - tan^2 theta)
  $
]

#definition(title: "Half Angle Formulae")[
  $
      sin^2 theta & = (1 - cos 2 theta)/2 \
    sin (theta/2) & = plus.minus sqrt((1 - cos theta)/2) \
      cos^2 theta & = (1 + cos 2 theta)/2 \
    cos (theta/2) & = plus.minus sqrt((1 + cos theta)/2) \
    tan (theta/2) & = plus.minus sqrt((1 - cos theta)/(1 + cos theta))
  $
]

#definition(title: "Ptolemy's Identities (Difference Formulas)")[
  $
    sin(alpha plus.minus beta) & = sin alpha cos beta plus.minus cos alpha sin beta \
    cos(alpha plus.minus beta) & = cos alpha cos beta minus.plus sin alpha sin beta
  $
]

#definition(title: "Trigonometric Integrals")[
  $
    &integral 1/(sin a x) dif x &&= -1/a ln abs(csc a x + cot a x) + C \
    &integral 1/(cos a x) dif x &&= -1/a ln abs(tan(1/2 a x + 1/4 pi)) + C \
    &integral tan a x dif x &&= -1/a ln abs(cos a x) + C = 1/a ln abs(sec a x) + C \
    &integral tan^2 a x dif x &&= tan x - x + C \
    &integral sec a x dif x &&= 1/a ln abs(sec a x + tan a x) + C \
    &&&= 1/a ln abs(tan(1/2 a x + 1/4 pi)) + C \
    &&&= 1/a arctan(sin a x) + C \
    &integral 1/(x^2 + a^2) dif x &&= 1/a arctan(x/a) + C
  $
]

#pagebreak()

= Fourier Series

#definition(title: "Fourier Series")[
  For $f in cal(H)$ and let ${e_n}_(n=-oo)^oo$ be an orthonormal basis in $cal(H)$, the
  *Fourier series* of $f$ is
  $ f(x) = sum_(n=1)^oo innerproduct(x, e_n) e_n $
]

#theorem(title: "Parseval Equality")[
  With $f in cal(H)$ and ${e_n}_(n=1)^oo$ an orthonormal basis for $cal(H)$, then for
  $cal(F):cal(H)->ell^2 (NN)$:
  $ (cal(F) f)_n = innerproduct(f, e_n) $
  is unitary. Furthermore, we have
  $ innerproduct(f, g)_(cal(H)) = innerproduct(cal(F) f, cal(F) g)_(ell^2) $
]

#theorem(title: "Plancherel Equality")[
  With $f in cal(H)$ and ${e_n}_(n=1)^oo$ an orthonormal basis for $cal(H)$:
  $
    norm(f)^2_(cal(H)) = sum_(n=1)^oo abs(innerproduct(f, e_n))^2
    = norm(cal(F) f)^2_(ell^2)
  $
]

#[
  #show math.equation: set text(fill: white)
  = $L^1$ Fourier Transform
]

#definition(title: [$L^1$ Fourier Transform])[
  For $f in L^1 (RR)$, the *Fourier Transform* $hat(f)$ of $f$ is defined:
  $
    cal(F) f(xi) = hat(f)(xi)
    = integral_(-oo)^oo f(t) e^(-2 pi i xi t) dif t quad (xi in RR)
  $
]

#proposition(title: "Properties")[
  - $norm(hat(f))_oo <= norm(f)_1$
  - $hat(f) in C(RR)$
  - $lim_(abs(xi) -> oo) abs(hat(f)(xi)) = 0$
  - $hat(f) equiv 0 <==> f = 0$ almost everywhere
]

#theorem(title: "In the Schwarz Space")[
  For $f in cal(S)(RR)$:
  - $cal(F):cal(S)->cal(S)$
  - If $f in cal(S)$ then, for all $t in RR$:
    $ f(t) = integral_(-oo)^oo hat(f)(xi) e^(2 pi i xi t) dif xi $
  - If $f,g in cal(S)$ then $innerproduct(f, g) = innerproduct(hat(f), hat(g))$
]

#remark(title: "Differentiation")[
  $
    cal(F) upright(D) f(xi) & = 2 pi i xi cal(F) f(xi) \
        cal(F)(-2 pi i t f) & = upright(D) cal(F) f
  $
]

#example[
  With $B(t) = chi_([-1/2, 1/2]) (t)$:
  $ hat(B)(xi) = sinc(xi) = (sin(pi xi))/(pi xi) $
  And for $k in ZZ$, $hat(B)(k) = delta_(k 0)$.
]

#[
  #show math.equation: set text(fill: white)
  = $L^2$ Fourier Transform
]

#proposition(title: "Properties")[
  With $cal(F)$ and $cal(F)^(-1)$ defined on $L^2 (RR)$, then:
  - $cal(F)$ and $cal(F)^(-1)$ are linear operators.
  - $cal(F)$ and $cal(F)^(-1)$ are unitary operator on $L^2 (RR)$,
    and so for all $f, g in L^2 (RR)$
    $ innerproduct(hat(f), hat(g)) = innerproduct(f, g) $
    Equivalently, $cal(F)^* = cal(F)^(-1)$.
]

= Convolution

#definition(title: "Convolution")[
  For $f,g in L^1 (RR)$, we define the *convolution*:
  $ f * g(t) = integral_(-oo)^oo f(s) g(t - s) dif s $

  #theorem[
    If $f,g in L^1 (RR)$ then
    - $f * g in L^1 (RR)$ and $norm(f * g)_1 <= norm(f)_1 norm(g)_1$.
    - $hat((f * g))(xi) = hat(f)(xi) hat(g)(xi)$.
  ]
]

#example[
  Let $f = chi_([-1/2, 1/2])$. Then,
  $
      f * f(x) & = g(x) = max{1 - abs(x), 0} \
    hat(g)(xi) & = hat(f)(xi)^2 = (sin^2 (pi xi))/(pi^2 xi^2)
  $
]

#colbreak()

= Covariance

#definition[
  Given $t_0, xi_0 in RR$ we define the following operators on $L^2 (RR)$:
  $
    tau_(t_0) f(t) & = f(t - t_0) \
     M_(xi_0) f(t) & = e^(-2 pi i xi_0 t) f(t) \
          D_a f(t) & = 1/sqrt(a) f(t/a)
  $
]

#proposition(title: "Properties")[
  - Each operator has an inverse, as follows:
    $
      tau_(t_0)^(-1) = tau_(-t_0) quad M_(xi_0)^(-1)
      = M_(-xi_0) quad D_a^(-1) = D_(a^(-1))
    $

  - Each operator is unitary.
  - Each operator has a relationship with the Fourier transform:
    $
      cal(F) tau_(t_0) & = M_(t_0) cal(F) \
       cal(F) M_(xi_0) & = tau_(-xi_0) cal(F) \
            cal(F) D_a & = D_(a^(-1)) cal(F)
    $
]

= Sampling

#definition(title: "Bandlimit")[
  Given $Omega > 0$, let
  $ B_Omega = {f in L^2 (RR) : hat(f)(xi) = 0 "for" xi > Omega/2} $
  Functions in $B_Omega$ are said to be *bandlimited* with *bandwidth* $Omega$.
]

#theorem(title: "Shannon Sampling Theorem")[
  If $f in B_Omega$, then
  $ f(t) = sum_(n=-oo)^oo f(n/Omega) sinc(Omega t - n) $
  where $sinc(x) = sin(pi x)/(pi x)$.
]

#theorem(title: "Poisson Summation Formula")[
  If $f, hat(f) in L^1 (RR)$ and
  $ sum_(n=-oo)^oo f(t + n) quad "and" quad sum_(n=-oo)^oo hat(f)(xi + n) $
  are absolutely convergent for all $t, xi in RR$, then
  $ sum_(n=-oo)^oo f(t + n) = sum_(m=-oo)^oo hat(f)(m) e^(2 pi i m t) $
]

#remark[
  This can be used to show that certain infinite sums have some particular value.
]

= Uncertainty

#theorem(title: "Heisenberg Uncertainty Inequality")[
  $
    integral_(-oo)^oo (t - t_0)^2 abs(f(t))^2 dif t
    dot integral_(-oo)^oo (xi - xi_0)^2 abs(hat(f)(xi))^2 dif xi
    >= (norm(f)^4_2)/(16 pi^2)
  $
]

#colbreak()

= Time-Frequency Analysis

#definition(title: "Short-Time Fourier Transform")[
  Let $phi in L^2 (RR)$. Given $b, xi in RR$, let
  $ phi_(b, xi) (t) = M_(-xi) tau_b phi(t) = e^(2 pi i xi t) phi(t - b) $
  Then the short-time Fourier transform $S_phi f$ of $f$ with respect to $phi$ is defined
  by
  $ S_phi f(b, xi) = innerproduct(f, phi_(b, xi)) $
]

#remark[
  The short-time Fourier transform is also known as the sliding window Fourier transform,
  the windowed Fourier transform and the Gabor transform (especially in the case where the
  window $phi$ is a Gaussian). Note that
  $
    S_phi f(b, xi) = integral_(-oo)^oo f(t) e^(-2 pi i xi t) overline(phi(t - b)) dif t
    = (cal(F) f overline(phi(dot - b)))(xi)
  $ $phi_(b, xi)$
  is obtained from $phi$ by a translation in time by $b$ and in frequency by $xi$,
  i.e., a translation in "phase space" (the time-frequency plane) by $(b, xi)$.

  Also, if $phi equiv 1$, $S_phi f(b, xi) = hat(f)(xi)$, but in fact since $phi$ is
  assumed to have decay properties, $S_phi f$ represents a windowed version of the Fourier
  transform around $t = b$. By the Plancherel formula we may write the integral as $ S_phi
  f(b, xi) = integral_(-oo)^oo hat(f)(s) e^(2 pi i b(s - xi)) overline(hat(phi)(s - xi))
  dif s $ $S_phi f(b, xi)$ represents time-frequency localised information about $f$,
  i.e., the information about $f$ near the time $b$ and the frequency $xi$.
]

#theorem[
  If $f in L^2 (RR)$, then $S_phi : L^2 (RR) -> L^2 (RR^2)$ is a _multiple of an isometry_
  $
    integral_(-oo)^oo integral_(-oo)^oo abs(S_phi f(b, xi))^2 dif b dif xi
    = norm(phi)_2^2 integral_(-oo)^oo abs(f(t))^2 dif t = norm(phi)_2^2 norm(f)_2^2
  $
]

