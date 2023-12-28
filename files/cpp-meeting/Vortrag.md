# Typen und Value-Kategorien in C++

## Mash up of Meeting C++ 2018

Gabriel Nützi, 2018 at Cyfex AG, Zurich

[[Teil 1](#/10/0/-1)]
[[Teil 1 Bemerkungen](#/32/0/-1)]
[[Teil 2](#/44/0/-1)]

[[Git Repo](https://github.com/gabyx/tech-pr-cpp-value-catergories)]

---

### Über Statistik

#### 15-50 Fehler per 1000 Zeilen geliefertem Code

[unabh. der Sprache, *Steve McConnel, Code Complete*]

---

### Über constexpr

#### `if constexpr` must not introduce a scope

```cpp
if constexpr(1 < 3 + 4)
{
  /* compile this */
}
else
{
  /* compile this */
}
```

<div class="fragment" data-code-focus="2,4,6,8"></div>

*The next big Thing* [Andrei Alexandrescu, [Presentation](http://erdani.com/MeetingC++2018Keynote.pdf), [Video](https://www.youtube.com/watch?v=tcyb1lpEHm0)]

---

### Über Kommentare

<blockquote>
  <p class="size-h3">"A common fallacy is to assume authors of
  incomprehensible code will somehow be able to express themselves lucidly and clearly in comments."
  </p>
  <div class="source">
    <a href="https://twitter.com/KevlinHenney/status/381021802941906944">[Kevlin Henney]</a>
  </div>
</blockquote>

---

### Über Testing

<div class="center-me">
  <img src="files/cpp-meeting/ShittyUnitTests.png">
</div>

*How to write more reliable code*
[Egor Bredikhin, [Presentation](https://meetingcpp.com/mcpp/slides/2018/presentation.pdf), [Video](https://www.youtube.com/watch?v=KpdSFZOQCl8)]

---

### Über Neuerfindungen

<div class="container-outer">
  <div class="center-me">
    <img class="continer-inner" src="files/cpp-meeting/reinvent-the-wheel.jpg">
  </div>
  <div class="overlay emph"
        style="position:absolute; top:10%;left:18%;color:blue">
    <code>std::string</code>
  </div>
  <div class="overlay emph"
        style="position:absolute; bottom:10%;right:20%;">
    <code>my_custom_string</code>
  </div>
</div>

*How to write more reliable code*
[Egor Bredikhin, [Presentation](https://meetingcpp.com/mcpp/slides/2018/presentation.pdf), [Video](https://www.youtube.com/watch?v=KpdSFZOQCl8)]

---

### Über Neuerfindungen

Wieso

<pre><code class="language-cpp stretch" data-trim>
mySuperSort(v);
</code></pre>

anstatt

<div class="fragment">
<pre><code class="language-cpp stretch" data-trim>
std::sort(begin(v), end(v), std::greater<>());
</code></pre>
</div>
<blockquote class="fragment">
  <p>
    "Unless you are <bold>an expert</bold> in sorting algorithms and have plenty of time, this is more likely to be correct and to run faster than anything you write for a specific application.
    <bold>You need a reason not to use the standard library rather than a reason to use it.</bold>"
  </p>
  <div class="source">
    <a href="https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#p13-use-support-libraries-as-appropriate">[C++ Core Guidelines ©]</a>
  </div>
</blockquote>

*How to write more reliable code*
[Egor Bredikhin, [Presentation](https://meetingcpp.com/mcpp/slides/2018/presentation.pdf), [Video](https://www.youtube.com/watch?v=KpdSFZOQCl8)]

---

### Über Benamslungen

```cpp
class ConditionChecker
{
public:
    virtual bool CheckCondition() const = 0;
}
```

<span class="fragment" data-code-focus="1,4"></span>

<div class="fragment">
  <div class="center-me">
    <img class="no-border" src="files/cpp-meeting/arrow-down.svg">
  </div>
<pre><code class="language-cpp stretch" data-trim>
class Condition
{
public:
    virtual bool IsTrue() const = 0;
}</code></pre>
</div>

*Clean Coders Hate When You Use These Tricks* [Kevlin Henney, [Video](https://www.youtube.com/watch?v=brfqm9k6qzc&feature=youtu.be&t=546)]

---

### Über Benamslungen

- Generel: Expliziter is besser ⟶ aber am <strong>richtigen Ort</strong>:

```cpp
class SelectionManager
{
public:

    class TriangulationSceneObjectProxyWrapper {/* Stellvertr. */};

    TriangulationSceneObjectProxyWrapper&
    GetCurrentSelectedTriangulationObjectProxyWrapper();
};
```

<span class="fragment" data-fragment-index="0" data-code-focus="5,7,8"></span>
<span class="fragment" data-fragment-index="1" data-code-focus="5"></span>
<span class="fragment" data-fragment-index="2" data-code-focus="7,8"></span>

<div class="fragment" data-fragment-index="1">

<div class="fragment" data-fragment-index="1">

**Besser:**

<pre><code class="language-cpp stretch" data-trim>
public:
  class TriObjectProxy { ... };
  TriObjectProxy& GetSelectedTriangulation();
}</code></pre>
</div>
<span class="fragment" data-fragment-index="1" data-code-focus="2" data-code-block="2"></span>
<span class="fragment" data-fragment-index="2" data-code-focus="3" data-code-block="2"></span>

*Clean Coders Hate When You Use These Tricks* [Kevlin Henney, [Video](https://www.youtube.com/watch?v=brfqm9k6qzc&feature=youtu.be&t=546)]

---

### Über Reflection & Tooling

#### Runtime-Reflection

*Building a C++ Reflection System*
[Arvid Gerstman, [Presentation](https://meetingcpp.com/mcpp/slides/2018/Reflection2.pdf), [Video](https://www.youtube.com/watch?v=DUiUBt-fqEY)]

<pre><code class="language-cpp stretch size-h4" data-trim>
Type t = user.GetType();
</code></pre>
<ul>
  <li class="fragment">
    Suche im Abstract Syntax Tree (<a href="https://en.wikipedia.org/wiki/Abstract_syntax_tree">AST</a>) mit einem Clang Tool (LLVM).
    <ul>
      <li class="fragment">
        Annotierte Klassen:
        <pre><code class="language-cpp strech" data-trim>
        struct __attribute__((annotate("reflect"))) User {...}
        </code></pre>
      </li>
    </ul>
  </li>
  <li class="fragment">2-3 Tage Aufwand ⟶ Serialisierung </li>
</ul>
<p></p>

<div class="fragment">
  <h4 id="compile-time-reflection">Compile-Time Reflection</h4>
  <p><em>Compile-time programming and reflection in C++20...</em>
  [Louis Dionne, <a href="https://www.youtube.com/watch?v=CRDNPwXDVp0">Video</a>]
  </p>
</div>

---

# Teil 1

<div class="fragment center-me row">
  <div>
      <img  width="700px" src="files/cpp-meeting/rvalueOrLvalue-mod.gif">
  </div>
</div>

## Typen & Value-Kategorien

---

### Typen & Value-Kategorien

<div class="center-me row">
  <div class="column-half">
      <img src="files/cpp-meeting/rvalue-reference.jpg">
  </div>
  <div class="column-half fragment">
      <img style="width: 70%;" src="files/cpp-meeting/crazy.gif">
  </div>
</div>

---

### History

**Vor C++11:**
Binden eines temporären Objekts an eine `non-const` Referenz:

```cpp
int& a = 0;
```

⟶ Compile Error <i class="emoji">🚫</i>.

```python
non-const lvalue reference to type 'int' cannot bind
to a temporary of type 'int'
```

<div class="fragment">
  <p><strong>Ab C++11:</strong> Neue Syntax für Referenzen auf temporäre Objekte:</p>
  <pre><code class="language-cpp stretch" data-trim>
  int&& a = 0;  // rvalue-Referenz auf `int`.
  </code></pre>
</div>
<div class="fragment">⟶ Effiziente Copy-Konstruktoren &amp; Assignment-Operatoren etc. </div>

---

### Typ einer Variable

Jede Variabel besitzt ein Typ.

```cpp
int                    a;
enum class C {A, B, C} b;
std::vector<int>       c; // Variable `c`: `std::vector<int>`

int const * & const    d;

using FuncPointer  = int (*)(float); // Typ Def.: Funktions-Pointer.
FuncPointer pFunc;
```

<div class="fragment" data-code-focus="1"/>
<div class="fragment" data-code-focus="2"/>
<div class="fragment" data-code-focus="3"/>
<div class="fragment" data-code-focus="5"/>
<div class="fragment" data-code-focus="7"/>
<div class="fragment" data-code-focus="8"/>
<div class="fragment" data-code-focus="9"/>

<div class="fragment" data-code-focus="3">
<ul>
<li><code>decltype(a)</code> liefert den Typ der Variable <code>a</code></li>
<li><code class="language-cpp">template &lt;typename T,...&gt; std::vector</code> ist kein Typ! <br>⟶ Template (siehe Teil 2) </li>
</ul>
</div>

---

### Typ-Modifiers

- `const`, `volatile`
- `*`, `&`

gehören generell zum Typ und sind Modifikatoren.

Deshalb nicht zur Variabel:

```cpp
const int *&d;
```

<i class="emoji">😩</i>

Wichtig, vorallem bei Templates ⟶ Teil 2.

```cpp
int *e, f;     // Gilt nicht als Ausrede (eher eine C++ Exception)
```

---

### Typ einer Expression

Jede Expression `expr` besitzt zusätzlich zum **Typ** auch eine **Value-Kategorie**:

```cpp
const int& b = 3;
int c = b;
//      ^------ Expr. Typ `const int`
```

Der Typ einer Expression ist **nie** eine Referenz weil Referenzen entfernt werden für jede weitere Analyse.
**Siehe Regel [[7.2.2#1](https://timsong-cpp.github.io/cppwp/expr.type)]**

<pre class="fragment" data-code-focus="5" data-code-block="2"><code class="language-cpp stretch" data-trim>
struct A{ A& operator+(const A&); };

A a, b;
a = a+b;
//  ^^^------ Expr. Typ ??
</code></pre>

<span class="fragment" data-code-focus="5" data-code-block="2">
  <span style="color:blue"><strong>Beachte:</strong></span>
  <strong>Der Typ der Expression von <code>a+b</code> ist <code>A</code> !</strong>
</span>

---

### Value-Kategorien

Jede Expression `expr` besitzt zusätzlich zum Typ eine **Value-Kategory**:

```cpp
const int& b = 3;
int c = b;
//      ^------ Expr. Typ `const int`
```

<div style="position:relative" >

<div class="fragment fade-out" data-fragment-index="1" style="position:absolute; margin-left: auto; margin-right: auto; left: 0; right: 0;">
  <h5>Kategorien C++14</h5>
  <div class="center-me" style="flex:5em;">
      <img class="no-border" height=280px" src="files/cpp-meeting/ValueCategories.svg">
  </div>
  <ul>
    <li>Für C++17 reicht das als Faustregel.</li>
  </ul>
</div>
<div class="fragment fade-in" data-fragment-index="1" style="position:absolute; margin-left: auto; margin-right: auto; left: 0; right: 0;">
  <h5>Kategorien C++17</h5>
  <div class="center-me" style="flex:5em;">
      <img class="no-border" height=320px" src="files/cpp-meeting/ValueCategoriesC++17.svg">
  </div>
</div>
</div>

---

### Grundlegende Kategorien <small>[[basic.lval](https://timsong-cpp.github.io/cppwp/basic.lval)]</small>

<h3><em>lvalue</em>-Kategorie <span>
<img class="no-border" style="vertical-align:middle" height=50px" src="files/cpp-meeting/ValueCategories-LValues.svg">
</span></h3>

Klassifiziert ein Objekt wessen Ressource **nicht wiederverwendet** werden kann.
Alles von welchem man **die Adresse nehmen kann**.

```cpp
int y;           // Variabel-Typ: 'int'
int* p   = &y;   // Variabel-Typ: 'int*'
int& r   = y;    // Variabel-Typ: 'int&'

int&& rr = y;    // Variabel-Typ: 'int&&'
```

Expressions `y`, `p`, `r`, `rr` sind alles **lvalues**.

<div class="fragment" data-code-focus="1"></div>
<div class="fragment" data-code-focus="2"></div>
<div class="fragment" data-code-focus="3"></div>
<div class="fragment" data-code-focus="5"></div>

<ul class="fragment">
<li class="emph">Alle Variablen sind <strong>immer lvalue</strong>.</li>
</ul>

---

### Grundlegende Kategorien <small>[[basic.lval](https://timsong-cpp.github.io/cppwp/basic.lval)]</small>

<h3><em>rvalue</em>-Kategorie <span>
<img class="no-border" style="vertical-align:middle" height=50px" src="files/cpp-meeting/ValueCategories-RValues.svg">
</span></h3>

Klassifiziert ein Objekt wessen Ressource **wiederverwendet** werden darf. Meist weil am Ende seiner Laufzeit.
Das beinhaltet **temporäre erstellte** Objekte (Materialisierung).

<div class="fragment">
  <pre><code class="language-cpp stretch" data-trim>
  Banane make(){ return Banane{}; };
  </code></pre>
</div>

<ul>
<li class="fragment">Expression <code>Banane{}</code>  ⟶ Typ <code>Banane</code> und <strong>rvalue</strong> </li>
</ul>

<div class="fragment">
  <pre><code class="language-cpp stretch" data-trim>
  Banane& a = make();
  </code></pre>
</div>

<ul>
<li class="fragment">Expression: <code>make()</code> : Typ <code>Banane</code> und <strong>rvalue</strong> </li>
<li class="fragment">Variable <code>a</code> : Typ <code>Banane&</code></li>
<li class="fragment">Compile Error <i class="emoji">🚫</i> : <code>Banane&amp;</code> bindet nicht an temporäre <code>Banane</code>.</li>
</ul>

---

### Referenz-Typen

<table class="reference-table">
  <thead>
  <tr>
      <th>Syntax</th>
      <th>Namen</th>
      <th>Verhalten</th>
  </tr>
  </thead>
  <colgroup>
  <col span="1" style="width: 27%">
  <col span="1" style="width: 30%;">
  <col span="1" style="width: 35%;">
  </colgroup>
  <tbody>
  <tr class="fragment">
      <td><code>Banane&amp;</code></td>
      <td><strong>lvalue</strong>-Referenz</td>
      <td>Bindet <strong>lvalues</strong>.</td>
  </tr>
  <tr  class="fragment">
      <td class="seperator"><code>const Banane&amp;</code></td>
      <td class="seperator"><strong>const-lvalue</strong>-Referenz</td>
      <td class="seperator">Bindet <strong>lvalue</strong> und <strong>rvalue</strong> (weil const). [<a href="https://stackoverflow.com/questions/39718268/why-do-const-references-extend-the-lifetime-of-rvalues">Ext. Life-Time</a>]</td>
  </tr>
  <tr class="fragment">
      <td><code>Banane&amp;&amp;</code></td>
      <td><strong>rvalue</strong>-Referenz</td>
      <td>Bindet <strong>nur</strong> <strong>rvalues</strong>.</td>
  </tr>
  <tr class="fragment">
      <td><code>T&amp;&amp;</code> <small>[Template-Parameter <code>T</code>]</small> oder <code>auto&amp;&amp;</code></td>
      <td><strong>forwarding</strong>-Referenz</td>
      <td>Bindet an <strong>rvalue</strong>/<strong>lvalues</strong>.
      Um Value-Kategorie <strong>zu erhalten</strong></td>
  </tr>
  </tbody>
</table>

---

### Beispiel 1 <small>[[Live](https://wandbox.org/permlink/D4VFEXo7zuMRkMHG)]</small>

<pre><code class="language-cpp stretch" data-trim>
int&& a = 3; // 1. Value-Kategorie von `a`?
int& b  = a; // 2. Value-Kategorie von `b`?
             // 3. Kompiliert das?
</code></pre>

<ol>
<li class="fragment" data-code-focus="1">Variable <code>a</code> hat Typ <code>int&&</code> [<strong>rvalue</strong>-Referenz auf <code>int</code>]. <br> Expression <code>(a)</code> ist <strong>lvalue</strong> mit Typ: <code>int</code>. </li>
<li class="fragment" data-code-focus="2">Variable <code>b</code> hat Typ <code>int&</code> [<strong>lvalue</strong>-Referenz auf <code>int</code>]. <br> Expression <code>(b)</code> ist <strong>lvalue</strong> mit Typ: <code>int</code>. </li>
<li class="fragment" data-code-focus="3">Ja es kompiliert! <i class="emoji"><i class="emoji"><i class="emoji">👌</i> </i></i>.</li>
</ol>

---

### Value-Kategorie bei Rückgabewerten <small>[[expr.call](http://eel.is/c++draft/expr.call#14)]</small>

<h4><em>lvalue</em><span>
<img class="no-border" style="vertical-align:middle" height=50px" src="files/cpp-meeting/ValueCategories-LValues.svg">
</span></h3>
<pre class="fragment"><code class="language-cpp stretch" data-trim>
int& lvalue();  lvalue(); // Expression ist lvalue;
</code></pre>
<h4><em>rvalue</em><span>
<img class="no-border" style="vertical-align:middle" height=50px" src="files/cpp-meeting/ValueCategories-RValues.svg">
</span></h3>
<pre class="fragment"><code class="language-cpp stretch" data-trim>
int&& xvalue();  xvalue();  // Expression ist xvalue;
int   prvalue(); prvalue(); // Expression ist prvalue;
</code></pre>

<a href="#/23/0/1">Jump to std::move ...</a>

---

### Value-Kategorie bei Expression `f()` <small>[[expr.call](http://eel.is/c++draft/expr.call#14)]</small>

| Rückgabetyp von `f()` |     | Expression `f()` <br>[Typ, Value-Kategorie] |
| --------------------- | --- | ------------------------------------------- |
| `Banane`              | ⟶   | [`Banane`, **prvalue**]                     |
| `Banane&`             | ⟶   | [`Banane`, **lvalue**]                      |
| `Banane&&`            | ⟶   | [`Banane`, **xvalue**]                      |

<br>

<div class="fragment">
Inverses Mapping macht <a href="https://timsong-cpp.github.io/cppwp/dcl.type.decltype#:decltype"><code>decltype(expr)</code></a>:

| <code>decltype(expr)</code> |     | Expression <code>expr</code>                    |
| --------------------------- | --- | ----------------------------------------------- |
| <code>Banane</code>         | ⟵   | [<code>Banane</code>, <strong>prvalue</strong>] |
| <code>Banane&</code>        | ⟵   | [<code>Banane</code>, <strong>lvalue</strong>]  |
| <code>Banane&&</code>       | ⟵   | [<code>Banane</code>, <strong>xvalue</strong>]  |

</div>

---

### Bindungsverhalten

<pre><code class="language-cpp stretch" data-trim>
int& lvalue();       int&& xvalue();            int prvalue();
</code></pre>

##### **lvalue**-Referenz

<pre class="fragment"><code class="language-cpp stretch" data-trim>
int& r = lvalue();        // <i class="emoji">👌</i>: lvalue-Ref. bindet an lvalue.
int& r = prvalue();       // <i class="emoji">🚫</i>:             bindet nicht an prvalue.
int& r = xvalue();        // <i class="emoji">🚫</i>:             bindet nicht an xvalue.
</code></pre>

<pre class="fragment"><code class="language-cpp stretch" data-trim>
const int& r = prvalue(); // <i class="emoji">👌</i>:             bindet an prvalue.
const int& r = xvalue();  // <i class="emoji">👌</i>:             bindet an xvalue.
</code></pre>

##### **rvalue**-Referenz

<pre class="fragment"><code class="language-cpp stretch" data-trim>
int&& rr = lvalue();    // <i class="emoji">🚫</i>: rvalue-Ref. bindet nicht an lvalue.
int&& rr = prvalue();   // <i class="emoji">👌</i>:             bindet an prvalue.
int&& rr = xvalue();    // <i class="emoji">👌</i>:             bindet an xrvalue.
</code></pre>
<ul class="fragment">
<li>Bindet nur an <strong>rvalues</strong>!</li>
</ul>

[Live](https://wandbox.org/permlink/F0Vzt5BT8GLDqYiN)

---

### Wieso **rvalue**-Referenzen `&&` ?

<pre><code class="language-cpp stretch" data-trim>
class Banane
{
public:
    Banane(const Banane& rOther);            // Copy-Konstruktor
    Banane(Banane&& rrOther);                // Move-Konstruktor;

    Banane& operator=(const Banane& rOther); // Assign-Operator
    Banane& operator=(Banane&& rrOther);     // Move-Assign-Operator;
};</code></pre>

<div style="position:relative" >

  <div class="fragment fade-out" data-fragment-index="3"
  style="position:absolute; margin-left: auto; margin-right: auto; left: 0; right: 0;">
    <ul>
      <li class="fragment" data-code-focus="5" data-fragment-index="1">
      Effizienter "Copy"-Konstruktor möglich ⟶ <strong>Move-Konstruktor</strong>.
      </li>
      <li class="fragment" data-code-focus="8" data-fragment-index="2">
      Effizienter "Assign"-Operator möglich ⟶ <strong>Move-Assign-Operator</strong>.
      </li>
    </ul>
  </div>

  <div class="fragment fade-in" data-fragment-index="3"
  style="position:absolute; margin-left: auto; margin-right: auto; left: 0; right: 0;">
<pre><code class="language-cpp stretch" data-trim>
Banane create();
Banane a = create();
</code></pre>
    <ul>
      <li class="fragment" data-fragment-index="4" data-code-focus="2" data-code-block="2">
      <code>create()</code> liefert <strong>prvalue</strong> mit Expr. Typ <code>Banane</code>.
      </li>
      <li class="fragment" data-fragment-index="5" data-code-focus="2" data-code-block="2">
      Der Move-Konstruktor (falls es ihn gibt) wird dem Copy-Construktor bevorzugt,
      weil <code>Banane&&</code> besser matched.
      </li>
      <div class="fragment" data-fragment-index="5" data-code-focus="5" data-code-block="1"></div>
    </ul>
  </div>
</div>

---

### Debugging Value-Kategorien

Benutze `decltype((expr))` :

<ul>
<li class="fragment"><code>T</code> falls <code>expr</code> ein <strong>prvalue</strong> ist.</li>
<li class="fragment"><code>T&amp;</code> falls <code>expr</code> ein <strong>lvalue</strong> ist.</li>
<li class="fragment"><code>T&amp;&amp;</code> falls <code>expr</code> ein <strong>xvalue</strong> ist.</li>
</ul>

<span class="fragment">Wieso `(expr)`: <em>Weil explizit so beschrieben in [[dcl.type.decltype](https://timsong-cpp.github.io/cppwp/dcl.type.decltype#:decltype)]</em></span>

<pre class="fragment"><code class="language-cpp stretch" data-trim>
int a;
decltype((a))::GUGUS // Kompilierfehler <i class="emoji">🚫</i>
</code></pre>

<div class="fragment">
  <strong>Ausgabe:</strong>
  <pre><code class="language-bash stretch" data-trim>
  error: 'decltype((a))' (aka 'int &') is not a class,
  namespace, or enumeration
  </code></pre>
</div>

<ul class="fragment">
<li>⟶ <code>a</code> ist <strong>lvalue</strong>.</li>
</ul>

---

### Was macht `std::move(...)`

Transformiert die Value-Kategorie einer Expression von **lvalue** nach **xvalue**.

<pre><code class="language-cpp stretch" data-trim>
struct  A{}; A a; // 'a' ist lvalue.
std::move(a);     // ... eine xvalue-Expression.
</code></pre>

<div class="fragment" data-code-focus="2">Macht folgendes:
    <span class="fragment" data-code-focus="2">
    ⟶ siehe  <a href="#/20/0/1"><code>xvalue()</code></a>.</span>

<pre><code class="language-cpp stretch" data-trim>
A&& std::move(...) { return static_cast&lt;A&&&gt;(a) };
</code></pre>
<p>
Somit ist <code>std::move(a)</code> ein <strong>xvalue</strong> vom Expr. Typ:
<code>A</code>, <br> welches zu Aufruf
</p>
</div>

<div class="fragment" data-code-focus="2">
<pre><code class="language-cpp stretch" data-trim>
A(A&& a);            // Move-Konstruktor.
A& operator=(A&& a); // Move-Zuweisungsoperator.
</code></pre>

führen <strong>kann</strong>
<span class="fragment emph" data-code-focus="2">
was dann <strong>Move</strong> heisst:
</span>

<pre class="fragment" data-code-block="3" data-code-focus="1"><code class="language-cpp stretch" data-trim>
A b = std::move(a); // ⟶ Move-Konstruktor
</code></pre>
</div>

---

### Beispiel 2 - Return bei Referenz

```cpp
class MpAlgo
{
public:
    Triangulation& GetOutput() { return m_Tri; };
};

MpAlgo algo;
Triangulation r1 = algo.GetOutput();            // 1. Typ/Val.Kat?
Triangulation r2 = std::move(algo.GetOutput()); // 2. Typ/Val.Kat?
                                                 // 3. m_Tri?
```

<ol>
  <div class="fragment" data-code-focus="8" />
  <li class="fragment" data-code-focus="8">
  Expr. Typ <code>Triangulation</code> und <strong>lvalue</strong> ⟶ Copy-Konstruktor.
  </li>
  <div class="fragment" data-code-focus="9" />
  <li class="fragment" data-code-focus="9">
  Expr. Typ <code>Triangulation</code> und <strong>xvalue</strong> ⟶ Move-Konstruktor.
  <li class="fragment" data-code-focus="4,10"><code>m_Tri</code> ist in einem undefinierten Zustand (nach Standard)</li>
    <ul>
        <li class="fragment" data-code-focus="4,10">Aufpassen bei Wiederverwendung von <code>algo</code>.</li>
    </ul>
  </li>
</ol>

---

### Beispiel 3 - Return bei Value

<pre><code class="language-cpp stretch" data-trim>
Array&lt;int&gt; createIds() {
    Array&lt;int&gt; ids;
    for(int i=0; i&lt;42; ++i){
        ids.AddTail(i);
    }
    return ids;
};
Array&lt;int&gt; ids = createIds(); // 1) Typ / Value-Kategorie
</code></pre>

<ol>
  <div class="fragment" data-code-focus="6" />
  <li class="fragment" data-code-focus="8"><code>createIds()</code> : <code>Array&lt;int&gt;</code> und <strong>prvalue</strong> ⟶ Move-Konstruktor falls vorhanden sonst Copy-Konstruktor.
  <ul>
      <li class="fragment" data-code-focus="6">kein <code>std::move(ids)</code> ! ⟶ Compiler kann nicht optimieren.</li>
      <li class="fragment" data-code-focus="6"><strong>Named Return Value Optimization (NRVO)</strong> :
      <a href="https://timsong-cpp.github.io/cppwp/class.copy.elision">[11.9.5]</a>
      <a href="https://en.cppreference.com/w/cpp/language/copy_elision">[cppref]</a>
      <a href="https://www.ece.uvic.ca/~frodo/cppbook/downloads/lecture_slides_for_programming_in_c++-2019-02-04.pdf">[Slides]</a>
      </li>
      <ul>
          <li class="fragment" data-code-focus="6">NRVO: <strong>Named</strong> Objekt einer <strong>prvalue</strong> Return Expression.</li>
          <li class="fragment" data-code-focus="6">Für Compiler immer noch optional in C++17/20.</li>
      </ul>
  </ul>
</ol>

<strong class="fragment emph">Return Value Optimzation (RVO) ist verpflichtend seit C++17</strong>

---

### Beispiel 4 - Return bei Value & RVO

<pre><code class="language-cpp stretch" data-trim>
Array&lt;int&gt; createIds() {
    return {1, 2, 3, 4};
};
Array&lt;int&gt; ids = createIds(); // 1.
</code></pre>
<ol>
  <div class="fragment" data-code-focus="2,4" />
  <li><strong>Return Value Optimization (RVO)</strong> :
  <a href="https://timsong-cpp.github.io/cppwp/class.copy.elision">[11.9.5]</a>
  <a href="https://en.cppreference.com/w/cpp/language/copy_elision">[cppref]</a>
  <a href="https://www.ece.uvic.ca/~frodo/cppbook/downloads/lecture_slides_for_programming_in_c++-2019-02-04.pdf">[Slides]</a>
  </li>
  <ul>
      <li>RVO: <strong>Unnamed</strong> Objekt einer <strong>prvalue</strong> Return Expression</li>
      <li class="fragment"  data-code-focus="2,4">Für Compiler <strong>verpflichtend</strong> in C++17/20.</li>
  </ul>
</ol>

---

# Questions

<div class="center-me">
  <div  style="width:35%;height:auto;">
  <img class="no-border" src="files/cpp-meeting/Questions.png">
  </div>
</div>

#### To be continued

**Teil 2:** Template Refresher, Ref. Collapsing, `std::forward`, Template Argument Deduktion, C++17, Code Simplify
etc. (vielleicht auch Teil 3 ?)

---

# Referenzen

- <a href="https://timsong-cpp.github.io/cppwp">[C++2x Standard]</a>
- <a href="https://meetingcpp.com/mcpp/slides/">[C++ Meeting 2018 Slides]</a>
- <a href="https://medium.com/@barryrevzin/value-categories-in-c-17-f56ae54bccbe">[Value Categories in C++17]</a>
- <a href="https://www.amazon.de/Effective-Modern-Specific-Ways-Improve/dp/1491903996">[Effective Modern C++, 2015]</a>
  - Kapitel 6. Rvalue-Referenzen, Move-Semantik und Perfect-Forwarding.
- <a href="https://www.amazon.com/C-Templates-Complete-Guide-2nd/dp/0321714121">[C++ Templates: The Complete Guide]</a>
  - Appendix B: Value Categories. Empfehlenswert. IMO: Diese Slides fassen das aber besser zusammen.

---

## Bemerkungen zu Teil 1

<ul>
<li class="fragment"><p>Für die Anwendung reicht es aus zwischen <strong>rvalue</strong> und <strong>lvalue</strong> zu unterscheiden:</p>
<ul>
<li class="fragment"><code>std::move(banane)</code> ergibt eine Expression mit Value-Kategorie <strong>xvalue</strong>:<br>⟶ "<em>kann gemoved werden</em>"<br>d.h. bei Konstruktion oder Zuweisung matcht <strong>Move-Konstruktor/Move-Assigment</strong> besser. Fallback ist immer Copy-Konstruktor/Copy-Assigment.</li>
</ul>
</li>
<li class="fragment"><p>Typen von Expressions sind <strong>nie</strong> Referenzen: [<a href="#/13/0/-1">1</a>], [<a href="#/15/0/-1">2</a>], [<a href="#/22/0/-1">2</a>], [<a href="#/20/0/-1">3</a>]</p>
</li>
<li class="fragment"><p>Nur [<a href="#/16/0/-1">Venn-Diagram</a>] für C++17 wichtig! </p>
</li>
</ul>

---

#### Recap 1 : [Named]-Return-Value-Optimization <small>[[Live](https://wandbox.org/permlink/sKsOpnj2W9zgSTIj)]</small>

Es geht um `prvalue`s in einer Return-Expression:

```cpp
struct A {
  A(const A&)  = delete;
  A(const A&&) = delete;
};

A nrvo() { A a; return a; };
A rvo()  { return A{}; };
A rvo2() { return rvo(); };

A a = nrvo(); // NRVO optional    , kompiliert nicht, weil `=delete`.
A b = rvo();  // RVO verpflichtend, kompiliert auch ohne Move/Copy.
A c = rvo2(); // RVO verpflichtend, kompiliert auch ohne Move/Copy.
```

- C++17 guarantiert copy-elision für **RVO** Fälle wie `rvo()`, `rvo2()`.

<span class="fragment" data-code-focus="2,3"/>
<span class="fragment" data-code-focus="6"/>
<span class="fragment" data-code-focus="7"/>
<span class="fragment" data-code-focus="8"/>

<span class="fragment" data-code-focus="10"/>
<span class="fragment" data-code-focus="11"/>
<span class="fragment" data-code-focus="12"/>

---

### Wann `std::move(...)` ?

<ul>
  <li class="fragment" data-fragment-index="1"><p><strong>Moven</strong> heisst Move-Konstruktor/Assignment aufrufen.</p>
  </li>
  <li class="fragment" data-fragment-index="2"><p>Objekte die <strong>billig zu moven</strong> sind</p>
    <ul class="fragment" data-fragment-index="2">
      <li class="fragment"><strong>Value-Semantik:</strong> <em>Return/Call-By-Value</em></li>
      <li class="fragment"><strong>Generell nie</strong>
      <code>return std::move(ret)</code> benutzen:
      <pre><code class="language-cpp stretch" data-trim>
      A create() { A ret; ... return ret; }; // NRVO.
      </code></pre>
      </li>
    </ul>
  </li>
  <li class="fragment"><p>Objekte die <strong>teuer zu moven</strong> sind, z.B. <code>Triangulation</code>:</p>
  <ul class="fragment">
    <li><strong>Eher Referenz-Semantik:</strong> <em>Return/Call-By-Reference</em></li>
    </ul>
  </li>
</ul>

---

#### Recap 2 <small>[[Live](https://wandbox.org/permlink/hTPDT4fDVo0RICET)]</small>

```cpp
struct Banane{};
void shake(const Banane& rB);
void shake(Banane&& rrB);
Banane a;
a;                          // 1. Typ/Val.Kat von Expression `a` ?
Banane b = std::move(a);    // 2. Rückgabe-Typ von `std::move(a)` ?
                            // 3. Typ/Val.Kat von `std::move(a)`?
                            // 4. Was ist der Zustand von `a` ?
shake(b);                   // 5. Welche Funktion wird aufgerufen?
shake(std::move(b));        // 6. Welche Funktion wird aufgerufen?
```

<ol>
<li class="fragment" data-code-focus="5">
<span class="fragment" data-code-focus="5">
Expression <code>a</code> ist <strong>lvalue</strong> und Typ <code>Banane</code>.</span></li>
<li class="fragment" data-code-focus="6">
<span class="fragment" data-code-focus="6">
Rückgabetyp von <code>std::move(b)</code> ist <code>Banane&&</code>.</span></li>
<li class="fragment" data-code-focus="7">
<span class="fragment" data-code-focus="7">
Expression <code>std::move(b)</code> ist <strong>xvalue</strong> und Typ <code>Banane</code>.</span></li>
<li class="fragment" data-code-focus="8">
<span class="fragment" data-code-focus="8">
<code>a</code> ist gemoved, <code>a</code> ist in <strong>unspezifiziertem aber validen Zustand</strong>.
</span><br>
<span class="fragment" data-code-focus="6">
Man sollte nichts anderes annehmen, auch wenn kopiert wurde in 2.
</span></li>
<li class="fragment" data-code-focus="9">
<span class="fragment" data-code-focus="9">
<code>shake(const Banane&)</code>.</span></li>
<li class="fragment" data-code-focus="10">
<span class="fragment" data-code-focus="10">
<code>shake(Banane&&)</code> matcht das <strong>xvalue</strong> von <code>std::move(b)</code> besser.</span></li>
</ol>

---

#### Recap 3 <small>[[Live](https://wandbox.org/permlink/0WzFbayOBfwLH9SS)]</small>

```cpp
struct Banane{};
void foo(const Banane& rB);
void foo(Banane&& rrB);

Banane a;
Banane&& b = std::move(a);  // 1. Was ist der Zustand von `a` ?
foo(b);                     // 2. Welche Funktion wird aufgerufen?
foo(std::move(b));          // 3. Welche Funktion wird aufgerufen?
```

<ol>
<li class="fragment" data-code-focus="6">
<span class="fragment" data-code-focus="6">
Der Speicher von <code>a</code> hat sich nicht geändert!</span></li>
<li class="fragment" data-code-focus="7">
<span class="fragment" data-code-focus="2,7">
<code>foo(const Banane&)</code>. <span style="color:blue">Achtung: <code>b</code> is <strong>lvalue</strong>!!</span></span></li>
<li class="fragment" data-code-focus="8">
<span class="fragment" data-code-focus="3,8">
<code>foo(Banane&&)</code> matcht das <strong>xvalue</strong> von <code>std::move(b)</code> besser.</span></li>
</span></li>
</ol>

---

#### Recap 4 - Move-Semantik schreiben

<pre>
<code class="language-cpp stretch" data-trim>
struct A
{
    A(const A& rOther){
        m_v = rOther.m_v;
    }
    A(A&& rrOther){
        m_v = rrOther.m_v;  // 1. Wieso ist das hier suboptimal?
    }
    std::vector&lt;int&gt; m_v;
};
</code></pre>
<ol>
<li class="fragment" data-code-focus="7">
<span class="fragment" data-code-focus="7"/>Expression <code>rrOther</code> ist <strong>lvalue</strong>, d.h. hier wird kopiert. Die Variable <code>rrOther</code> ist aber eine Referenz auf ein temporäres <code>A</code> [<strong>rvalue</strong>-Reference].
<br>
<span class="fragment"  data-code-focus="7"><strong style="color:blue">Richtig wäre: </strong><code>std::move(rrOther.m_v)</code> damit das retournierte <strong>xvalue</strong> (<code>std::vector&lt;int&gt&&</code>) den <strong>Move-Assign-Operator</strong> matcht.
</span>
</li>
</ol>

---

#### Recap 5 - Referenzen zurück geben. <i class="emoji">💣</i>

<pre>
<code class="language-cpp stretch" data-trim>
struct A{};

A&       get() { return A{}; }               // No!!!
A&       get() { A a; return a; }            // No!!!
const A& get() { return A{}; }               // No!!!
A&&      get() { return A{}; }               // No!!!
A&&      get() { A a; return std::move(a); } // No!!!

auto& get() { return A{}; }                  // No!!!
auto&& get() { return A{}; }                 // No!!!
</code></pre>
<ul>
<li class="fragment" data-code-focus="7">
<strong style="color:blue">Wichtig:</strong> Referenzen zurückgeben auf <strong>lokale temporäre</strong> Objekte ist <strong>immer quatsch</strong>! Compiler sollte warnen!
</li>
</ul>
<br>
<div class="fragment">
<strong>Die einzigen richtigen Signaturen sind:</strong>
<pre>
<code class="language-cpp stretch" data-trim>
A get() { return A{}; }
A get() { return A{}; }
auto get() { return A{}; } // kein auto& oder auto&& !!
</code></pre>
</div>

---

#### Recap 6 - Aus Best Practice Chat <small>[[Live](http://coliru.stacked-crooked.com/a/47c4d166ce823457)]</small>

<pre>
<code class="language-cpp stretch" data-trim>
void SetData(A& a);
A a;
SetData(std::move(a)); // Darf nicht kompilileren! <i class="emoji">🚫</i>:
</code></pre>

- Eine **lvalue**-Referenz bindet nicht an `rvalues`.
- `MSVC` erlaubt das trotzdem [[Live](https://rextester.com/DOI21303)] obwohl **nicht-standard konform**.
  ⟶ <i class="emoji">💩</i>

---

### C++17 Features - Code Simplify

#### Init-If

<pre><code class="language-cpp stretch" data-trim>
if (auto val = GetValue(); condition(val))
{
  // ...
}</code></pre>

<div class="fragment">
Zum Beispiel:
<pre><code class="language-cpp stretch" data-trim>
if (const auto it = myString.find("Hello");
    it != std::string::npos)
{
    std::cout << it << " Hello\n";
}</code></pre>
</div>

<ul class="fragment">
<li>Scope verkleinern.</li>
</ul>

---

### C++17 Features - Code Simplify

#### Structured Bindings <small>[[Live](https://wandbox.org/permlink/WE1ZAKmPtr615Bmi)]</small>

<pre><code class="language-cpp stretch" data-trim>
std::unordered_map&lt;int,std::string&gt; map;

if (auto [it, bSuccess] = map.emplace(3, "Banane"); bSuccess)
{
    std::cout << it->second;  // dereferezieren
}
// `it` and `bSuccess` sind hier destruktiert.
</code></pre>

<span class="fragment" data-code-focus="1"/>
<span class="fragment" data-code-focus="3"/>
<span class="fragment" data-code-focus="5"/>
<span class="fragment" data-code-focus="7"/>

---

### C++17 Features - Code Simplify

#### Verschachteln von Namespace

```cpp
namespace A::B::C {
 //...
}
```

---

### C++17 Features - Code Simplify

#### `if constexpr`

Compile-Time Switches:

<pre><code class="language-cpp stretch" data-trim>
template&lt;typename ElementRef&gt;
void compute(ElementRef ref)
{
    if constexpr(std::is_same_v&lt;ElementRef, CVertexRef&gt;) {
        // kompiliere das, was speziell ist für CVertexRef
    }
    else if constexpr(std::is_same_v&lt;ElementRef, TriangleRef&gt;) {
        // kompiliere das, was speziell ist für TriangleRef
    }
    else {
        static_assert(false, "Not-implemented!");
    }
}
</code></pre>

<span class="fragment" data-code-focus="2"/>
<span class="fragment" data-code-focus="4"/>
<span class="fragment" data-code-focus="5"/>
<span class="fragment" data-code-focus="7"/>
<span class="fragment" data-code-focus="8"/>
<span class="fragment" data-code-focus="10"/>
<span class="fragment" data-code-focus="11"/>

---

# Teil 2

<div class="center-me row">
  <div class="column-half">
      <img class="no-border" src="files/cpp-meeting/template-brackets.jpg">
  </div>
  <div class="column-half fragment">
      <img class="no-border" style="width: 75%;" src="files/cpp-meeting/template-fence.gif">
  </div>
</div>

---

### C++ ⟶ 8a ?

<div class="center-me">
      <img class="no-border" src="files/cpp-meeting/climbing.jpg">
</div>

---

Es geht anscheinend noch schwieriger: <a href="https://de.wikipedia.org/wiki/MUMPS">MUMPS</a>

<pre><code class="language-cpp stretch" data-trim>
%DTC ; SF/XAK - DATE/TIME OPERATIONS ;1/16/92  11:36 AM
     ;;19.0;VA FileMan;;Jul 14, 1992
     D    I 'X1!'X2 S X="" Q
     S X=X1 D H S X1=%H,X=X2,X2=%Y+1 D H S X=X1-%H,%Y=%Y+1&X2
     K %H,X1,X2 Q
     ;
C    S X=X1 Q:'X  D H S %H=%H+X2 D YMD S:$P(X1,".",2)
S    S %=%#60/100+(%#3600\60)/100+(%\3600)/100 Q
     ;
H    I X<1410000 S %H=0,%Y=-1 Q
     S %Y=$E(X,1,3),%M=$E(X,4,5),%D=$E(X,6,7)
     S %T=$E(X_0,9,10)*60+$E(X_"000",11,12)*60+$E(X_"00000",13,14)
TOH  S %H=%M>2&'(%Y#4)+$P("^31^59^90^120^151^181^212^243","^",%M)
</pre></code>

---

### Motivation

Injektion der Werte eine Tuples

```cpp
std::tuple<int, double, ... , std::string> t(1, 4.0, ..., "kiwi");
```

in eine Funktion `f(...)`

```cpp
                                           f(1, 4.0, ..., "kiwi");
```

<h3 class="fragment" id="rezept">Rezept</h3>
<ul>
<li class="fragment">500gr <em>Variadische Templates</em>, </li>
<li class="fragment">1 EL <em>Perfect-Forwarding</em>, </li>
<li class="fragment">2 Stück <em>Template Lambdas</em>, </li>
<li class="fragment">1 x <em>Traits</em></li>
</ul>

<span class="fragment">Rühren und Kneten ⟶ Resultat 14-Zeilen am Schluss.</span>

---

### Perfect-Forwarding

Was kann man mit **forwarding**-Referenzen <code>T&amp;&amp;</code> <small>[Template-Parameter <code>T</code>]</small>
erreichen:

```cpp
Triangulation::Triangulation(const Vertices& v, const Triangles& t)
    : m_vertices(v), m_triangles(t)
{ /* initialisiere Zeugs... */ }

Vertices vertices = {1, 2, 3};
Triangulation tri(vertices,
                   Triangles{{1,2,3}})
```

<ul>
<li class="fragment" data-code-focus="6"><code>vertices</code> wird kopiert <i class="emoji">👌</i></li>
<li class="fragment" data-code-focus="7"><code>Triangles{{1,2,3}}</code> wird auch kopiert obwohl <strong>rvalue</strong> und könnte gemoved werden. <i class="emoji">😩</i></li>
<li class="fragment">Lets fix it ...</li>
</ul>

---

### Perfect-Forwarding

```cpp
Triangulation::Triangulation(const Vertices& v, const Triangles& t)
    : m_vertices(v), m_triangles(t)
{ /* initialisiere Zeugs... */ }

Triangulation::Triangulation(const Vertices& v, Triangles&& t)
    : m_vertices(v), m_triangles(std::move(t))
{ /* code duplikation + std::move(...) */ }

Vertices vertices = {1,2,3};
Triangulation tri(vertices,
                   Triangles{{1,2,3}})
```

<span class="fragment" data-code-focus="5-7"/>

<ul>
<li class="fragment" data-code-focus="6,10"><code>vertices</code> wird kopiert <i class="emoji">👌</i></li>
<li class="fragment" data-code-focus="6,11"><code>Triangles{{1,2,3}}</code> wird gemoved. <i class="emoji">👌</i></li>
<li  class="fragment">Code Duplikation <i class="emoji">💩</i>  ⟶ Kombinationshölle <i class="emoji">😨</i></li>
</ul>

---

### Perfect-Forwarding mit <code>T&&</code>

**forwarding**-Referenzen verwenden welche die **Value-Kategorie** erhalten:

```cpp
template<typename V, typename T>
Triangulation::Triangulation(V&& v, T&& t)
    : m_vertices(std::forward<V>(v))
    , m_triangles(std::forward<T>(t))
{ /* initialisiere Zeugs... */ }

Vertices vertices = {1,2,3};
Triangulation tri(vertices,
                   Triangles{{1,2,3}})
```

<span class="fragment" data-code-focus="1-5"/>
<ul>
<li class="fragment" data-code-focus="8">
  <code>vertices</code> ist <strong>lvalue</strong>
  <span class="fragment" data-code-focus="2,8">→ Compiler deduziert <code>V:= Vertices&</code><br>
  <span class="fragment" data-code-focus="3,8">→ <code>std::forward</code> retourniert <code>Vertices&</code> (<strong>lvalue</strong>) </span>
  <span class="fragment" data-code-focus="3,8">→ Kopie. <i class="emoji">👌</i></span>
</li>
<li class="fragment" data-code-focus="9">
  <code>Triangles{{1,2,3}}</code> ist <strong>rvalue</strong> </span>
  <span class="fragment" data-code-focus="2,9">→ Compiler deduziert <code>T:= Triangles</code> </span><br>
  <span class="fragment" data-code-focus="4,9">→ <code>std::forward</code> retourniert <code>Triangles&&</code> (<strong>xvalue</strong>)  </span>
  <span class="fragment" data-code-focus="4,9">→ Move. <i class="emoji">👌</i></span>
</li>
<li class="fragment" data-code-focus="5">Keine Code-Duplikation. <i class="emoji">👌</i></li>
</ul>

---

### Template Refresher

<ul>
    <li class="fragment"><strong>Klassen/Funktionen</strong>
        <pre><code class="language-cpp stretch" data-trim>
template&lt;typename Iterable&gt;
void findZero(const Iterable& it){ ... }
        </code></pre>
    </li>
    <li class="fragment"><strong>Lambdas</strong>
        <pre><code class="language-cpp stretch" data-trim>
[](auto v){ std::cout &lt;&lt; v;} // auto <=> typename T
        </code></pre>
    </li>
    <li class="fragment"><strong>Typedefinitionen:</strong> <emph>Alias-Templates</emph>:
        <pre><code class="language-cpp stretch" data-trim>
template&lt;typename T&gt;
using Map = std::map&lt;int, T*&gt;; // -> Map&lt;float&gt; a;
        </code></pre>
        <div class="fragment"><strong>Don't: </strong>Old-School über <code>typedef</code> und <code>struct</code> → unleserlich:
        <pre><code class="language-cpp stretch" data-trim>
template&lt;typename T&gt;
struct Trait { typedef std::map&lt;int, T*&gt type; };
Trait&lt;float&gt;::type; // std::map&lt;int, float*&gt;</code></pre>
        </div>
    </li>
</ul>

---

### Nomenklatur

<ul>
    <li class="fragment"><strong>Template Parameter</strong>
        <pre><code class="language-cpp stretch" data-trim>
//                vvvv-------- Template Parameter
template&lt;typename Type&gt;
void print(Type v);
        </code></pre>
    </li>
    <li class="fragment"><strong>Template Argument</strong>
        <pre><code class="language-cpp stretch" data-trim>
//    vvv--------------------- Template Argument
print&lt;int&gt;(3);
        </code></pre>
    </li>
    <li class="fragment"><code>std::vector&lt;int&gt;</code> ist ein <strong>Typ.</strong></li>
    <li class="fragment"><code>std::vector</code> ist kein Typ sondern ein <strong>Template</strong> mit 2 Template-Parameter. Im Beispiel: <code>Type</code> kann <strong>nie</strong> <code>std::vector</code> sein!</li>
    </li>
    <li class="fragment"><strong>Traits</strong> sind Klassentemplates mit <em>intern</em> definierten Typen: <small>[<a href="https://en.cppreference.com/w/cpp/header/type_traits">type_traits</a>]</small>
        <pre><code class="language-cpp stretch" data-trim>
template&lt;typename T&gt; struct std::add_pointer{ using type = T*; };</code></pre>
    </li>
</ul>

---

### Static Asserts

```cpp
#include <type_traits>
static_assert(std::is_same<DataType, CVertexRef>::value, "Wups!");
static_assert(std::is_same<DataType, CVertexRef>{},      "Wups!");
```

<ul class="fragment" data-fragment-index="3">
<li>C++14 : Variable Template <a href=""></a></li>

<pre><code class="language-cpp stretch" data-trim>
static_assert(std::is_same_v&lt;DataType, CVertexRef&gt;, "Wups!");
</code></pre>

<pre><code class="language-cpp stretch" data-trim>
template&lt;typename T, typename U&gt;
constexpr bool is_same_v = is_same&lt;T, U&gt;::value;
</code></pre>
</ul>

<div class="fragment" data-code-focus="2" data-code-block="1" data-fragment-index="1"/>
<div class="fragment" data-code-focus="3" data-code-block="1" data-fragment-index="2" />
<div class="fragment" data-code-focus="1"  data-code-block="2" data-fragment-index="4"/>
<div class="fragment" data-code-focus="2"  data-code-block="1" data-fragment-index="4"/>

---

### Template Parameter Arten

<ul>
    <li class="fragment" data-fragment-index="1"><strong>Type Template-Parameter</strong>
        <pre><code class="language-cpp stretch" data-trim>
template&lt;typename T&gt; struct A{}; // `class T` ⟶ das selbe (dont!)
        </code></pre></li>
    <li class="fragment" data-fragment-index="2"><strong>Non-Type Template-Parameter</strong>
        <pre class="fragment" data-fragment-index="2"><code class="language-cpp stretch" data-trim>
template&lt;std::size_t N&gt; struct A{};
template&lt;MyEnum EMode&gt;  struct B{};
template&lt;auto N&gt;        struct C{}; // C++20
        </code></pre>
    <span class="fragment" data-code-focus="1" data-code-block="2"/>
    <span class="fragment" data-code-focus="2" data-code-block="2"/>
    <span class="fragment" data-code-focus="3" data-code-block="2"/>
    <span class="fragment">
    <strong>Don't</strong>. Template Argument-Matching schwierig bis unmöglich!<br>
    Wrappe alles in Typen, z.B.:<br>
    <code>std::integral_constant&lt;int, 3&gt;</code> mit <code>typename Number</code></span>
    </li>
    <li class="fragment"><strong>Template-Template-Parameter</strong><br>
    <pre><code class="language-cpp stretch" data-trim>
template&lt;template&lt;typename&gt; class T&gt; struct A{};
    </code></pre>
    <strong>Don't</strong>. Das will man immer vermeiden! Es gibt bessere Konzepte (siehe Alias/Callables <a href="https://ericniebler.github.io/meta/index.html">[meta]</a>).
    </li>
</ul>

---

### Variadische Parameter <small>[[Live](https://wandbox.org/permlink/shzOn3OX0pLZx8IP)]</small>

```cpp
template<typename... Types>
class Converter{//   ^^^^^-------------------- Parameter-Pack
public:
    using Tuple = std::tuple<Types...>;
    //                            ^^^--------- Pack-Expansion

private:
    Tuple m_tuple;
    std::array<int, sizeof...(Types)> m_count;
    //              ^^^^^^^^^----------------- Anzahl Parameter
};

Converter<int, float, double> c; // 1. `Tuple` und `m_count`?
```

<ul>
    <li class="fragment" data-fragment-index="5" data-code-focus="4">
        <code>Tuple := std::tuple&lt;int, float, double&gt;</code>
    </li>
    <li class="fragment" data-fragment-index="6" data-code-focus="9">
        <code>m_count := std::array&lt;int, 3&gt;</code>
    </li>
</ul>
<span class="fragment" data-fragment-index="1" data-code-focus="13"/>
<span class="fragment" data-fragment-index="2" data-code-focus="1"/>
<span class="fragment" data-fragment-index="3" data-code-focus="4"/>
<span class="fragment" data-fragment-index="4" data-code-focus="9"/>

---

### Variadische Parameter <small>[[Live](https://wandbox.org/permlink/sxGZ9K0Vobez8I6M)]</small>

Meta-Programming: Rechnen mit Typen zu Kompilierzeit:

```cpp
using List    = meta::list<double, float, int>;
using ListNew = meta::transform<List,
                                meta::quote<std::add_pointer_t>>;
ListNew::DJBobo;
```

```bash
error: 'DJBobo' is not a member of
'ListNew' {aka 'meta::list<double*, float*, int*>'}
```

---

### Reference-Collapsing Regeln

<pre>
<code class="language-cpp stretch" data-trim>
foo&lt;int&&gt;();

template&lt;typename T&gt;
void foo()
{
    const T& temp = 3;  // 'T' ist 'int&'
                        // 'temp' ist 'const (int&) &' ⟶ <i class="emoji">😵</i> <i class="emoji">😵</i>
}
</code></pre>

<span class="fragment" data-code-focus="1,3,4"/>
<span class="fragment" data-code-focus="6"/>

<div class="fragment">
Deshalb:
<ul>
<li><code>(T&)  &</code> ⟶ kollabiert zu <code>T&</code></li>
<li><code>(T&)  &&</code> ⟶ kollabiert zu <code>T&</code></li>
<li><code>(T&&) &</code> ⟶ kollabiert zu <code>T&</code></li>
<li><code>(T&&) &&</code> ⟶ kollabiert zu <code>T&&</code></li>
</ul>
</div>
<div class="fragment">

<strong>Eselsbrücke</strong>:
<span style="color:blue"><strong>Einfache Referenz <code>&</code> gewinnt immer.</strong></span>

---

### Quiz

```cpp
template<typename T>
void foo(T& v);

int main()
{
    int&& a = 3;
    foo<int&&>(a); // 1. Typ von `v`.
}
```

<span class="fragment" data-code-focus="7"/>
<ol>
<li class="fragment" data-code-focus="7"><code>T& := (int&&) & := int&</code></li>
</ol>

---

### Template Argument Deduction <small>[[temp.deduct.call](https://timsong-cpp.github.io/cppwp/temp.deduct.call)]</small>

```cpp
Banane c;
add(c);
//  ^----------------- Argument Typ  ⟶ trafo ⟶ definiert Typ `A`

template<typename T>
void add(const T& val);
//       ^^^^^^^^----- Parameter Typ ⟶ trafo ⟶ definiert Typ `P`
```

<span class="fragment" data-code-focus="3,7">Template Parameter <code>T</code>
wird vom Compiler automatisch <strong>deduziert</strong>.
Der Kompiler arbeitet mit 2 Typen <code>A</code> und <code>P</code>.</span>

<ul>
<li class="fragment" data-code-focus="2"><code>A := Banane</code></li>
<li class="fragment" data-code-focus="6"><code>P := T</code></li>
</ul>

<span class="fragment">Matche <code>A</code> mit <code>P</code>:
⟶ <strong>Resultat:</strong> <code>T := Banane</code></span>

<strong class="fragment" style="color:blue">Was sind die Regeln und wie wird gematched?</strong>

---

### Template Argument Deduction <small>[[temp.deduct.call](https://timsong-cpp.github.io/cppwp/temp.deduct.call)]</small>

Es gibt genau drei Unterscheidungs-Fälle:

<ul>
  <li class="fragment">Deklaration <code>T</code> :
    <pre><code class="language-cpp stretch" data-trim>
template&lt;typename T&gt; void add(T val);         // T   <=> auto</code></pre>
  </li>
  <li class="fragment">Deklaration <code>T&amp;</code> (<strong>lvalue</strong>-Referenz):
    <pre><code class="language-cpp stretch" data-trim>
template&lt;typename T&gt; void add(      T& val); // T&  <=> auto&
template&lt;typename T&gt; void add(const T& val); // T&  <=> const auto&</code></pre>
  </li>
  <li class="fragment">Deklaration <code>T&amp;&amp;</code> (<strong>forwarding</strong>-Referenz):
    <pre><code class="language-cpp stretch" data-trim>
template&lt;typename T&gt; void add(T&& val);     // T&& <=> auto&&</code></pre>
  </li>
</ul>

---

#### Deduktion bei `T` oder `auto`<small>[[temp.deduct.call](https://timsong-cpp.github.io/cppwp/temp.deduct.call)]</small>

```cpp
const Banane& c = ...;
add(c);
//  ^-------------- [entferne const, etc...] -> A := Banane

template<typename T>
void add(T val);
//       ^---------------------------------- -> P := T
```

<ul>
<li class="fragment" data-code-focus="2,3"><strong>Argument-Typ <code>A</code>:</strong>
  <br>
  <em>Expr. <code>c</code> : <code>const Banane</code> <small><a href="https://timsong-cpp.github.io/cppwp/expr.type">[7.2.2#1]</a></small>
  <br>
  <em>Trafos:</em>
  <ul>
  <li>Entferne <code>const</code> von <code>A</code>. <small>[<a href="https://timsong-cpp.github.io/cppwp/temp.deduct.call#2.3">13.9.2.1#2.3</a>]</small></li>
  <li>und noch andere unwichtige Traforegeln auf <code>A</code>.</li>
  </ul>
</li>

<li class="fragment" data-code-focus="6,7"><strong>Parameter-Typ <code>P</code>:</strong>
<br>
<em>Trafos:</em> keine. <code>P</code> wird zu <code>T</code>. <small>[<a href="https://timsong-cpp.github.io/cppwp/temp.deduct.call#2">13.9.2.1#2 impli.</a>]</small>
</li>

<li class="fragment" data-code-focus="3,7"><strong>Pattern-Match:</strong>  <code>P</code> mit <code>A</code> ergibt <code>T :=  Banane</code></li>
</ul>
<span style="color:blue"><strong>Wichtig:</strong> <code>T</code> wird nie automatisch zu einer Referenz. <code>add&lt;int&&gt;(3)</code> ist keine <strong>automatische</strong> Deduktion!<strong></span>

---

#### Deduktion bei `T&` oder `auto&` <small>[[temp.deduct.call](https://timsong-cpp.github.io/cppwp/temp.deduct.call)]</small>

```cpp
const Banane& c = ...;
add(c);
//  ^--------------------------------------- -> A := const Banane

template<typename T>
void add(T& val);         // (oder const T&)
//       ^^--------- [entferne const und &]  -> P := T
```

<ul>
<li class="fragment" data-code-focus="2,3"><strong>Argument-Typ <code>A</code>:</strong>
  <br>
  <em>Expr. <code>c</code> : <code>const Banane</code> <small><a href="https://timsong-cpp.github.io/cppwp/expr.type">[7.2.2#1]</a></small>
  <br>
  <em>Trafos:</em> keine. (<code>const</code> darf z.B. nicht entfernt werden!)
</li>

<li class="fragment" data-code-focus="6,7"><strong>Parameter-Typ <code>P</code>:</strong>
  <br>
  <em>Trafos:</em> Entferne <code>const</code> und Referenz <code>&amp;</code> <small>[<a href="https://timsong-cpp.github.io/cppwp/temp.deduct.call#3">13.9.2.1#3</a>]</small>
</li>

<div class="fragment" data-code-focus="3,7"><strong>Pattern-Match:</strong>  <code>P</code> mit <code>A</code>.  (ergibt <code>T := const Banane</code>)</div>
</ul>

---

#### Deduktion bei `T&&` oder `auto&&` <small>[[temp.deduct.call](https://timsong-cpp.github.io/cppwp/temp.deduct.call)]</small>

- `T&&`<small>[Template-Parameter <code>T</code>]</small>
- `auto&&`

sind **forwarding**-Referenzen.

Bei der automatischen Deduktion können diese zu einer **lvalue**-Referenz (&) oder einer **rvalue**-Referenz (&&) werden!

---

#### Deduktion bei `T&&` oder `auto&&` <small>[[temp.deduct.call](https://timsong-cpp.github.io/cppwp/temp.deduct.call)]</small>

```cpp
const Banane& c;
add(c);
//  ^-------------- [lvalue -> füge & hinzu] -> A := const Banane&
add(4);
//  ^-------------- [rvalue -> nichts]       -> A := int

template<typename T>
void add(T&& val);
//       ^^^------- [entferne const und &]   -> P := T
```

<ul>
<li class="fragment" data-code-focus="2,4"><strong>Argument-Typ <code>A</code>:</strong>
  <br>
  <em>Trafos:</em> <small>[<a href="https://timsong-cpp.github.io/cppwp/temp.deduct.call#3">13.9.2.1#3</a>]</small>
  <ul>
    <li class="fragment" data-code-focus="2,3">Expr. <code>c</code> ist [<code>const Banane</code>, <strong>lvalue</strong>] ⟶ Add <code>&</code> ⟶ <code>A := const Banane&</code> </li>
    <li class="fragment" data-code-focus="4,5">Expr. <code>4</code> ist [<code>int</code>, <strong>prvalue</strong>] ⟶ <code>A := int</code></li>
  </ul>
</li>

<li class="fragment" data-code-focus="8,9"><strong>Parameter-Typ <code>P</code>:</strong>
<br>
<em>Trafos:</em> Siehe <a href="#/57/0/2">Deklaration T&</a>. <code>P := T</code>.
</li>

<li class="fragment" data-code-focus="3,5,9"><strong>Pattern-Match: </strong><code>T := const Banane&</code> , <code>T := int</code> ⟶ <strong>Ref. Collapse!</strong></li>
</ul>

---

#### Deklaration `T&&` <small>[[temp.deduct.call](https://timsong-cpp.github.io/cppwp/temp.deduct.call)]</small>

```cpp
const Banane& a;
add(a);
//  ^------------- 1. -> val := (const Banane&) &&  := const Banane&
add(4);
//  ^------------- 2. -> val := (int) &&            := int&&

template<typename T>
void add(T&& val);
```

<ol>
<li class="fragment" data-code-focus="3"><strong>lvalue</strong> wird weitergegeben als <strong>lvalue</strong>-Reference ⟶ <i class="emoji">👌</i></li>
<li class="fragment" data-code-focus="5"><strong>rvalue</strong> wird weitergegeben als <strong>rvalue</strong>-Reference  ⟶ <i class="emoji">👌</i></li>
</ol>

---

#### Deklaration `T&&` <small>[[temp.deduct.call](https://timsong-cpp.github.io/cppwp/temp.deduct.call)]</small>

```cpp
template<typename T>
void add(T&& val)
{
  add(val); // Ungut: `val` wird immer als lvalue weitergegeben
}
```

- `val` ist **lvalue** und zweideutiger Typ: **rvalue/lvalue**-Reference.

<br>
<div class="fragment">
<strong>Merke:</strong>
<span style="color:blue;"><strong>Um die Zweideutigkeit von <code>T&amp;&amp;</code> zu erhalten, brauchts immer</strong></span>
<code>std::forward&lt;T&gt</code> <span style="color:blue;"><strong>:</strong><span>

<pre><code class="language-cpp stretch" data-trim>
template&lt;typename T&gt
void add(T&& val)
{
  add(std::forward&lt;T&gt;(val)); // Richtig!
}
</pre></code>
</div>

---

### Quiz <small>[[Live](http://coliru.stacked-crooked.com/a/5948ecede1557195)]</small>

Was ist der Typ von `t` ?

```cpp
Banane&& a = 4;
foo(a);
//  ^--------------------------- A := ???

template<typename T>
void foo(T&& t);
//       ??? ------------------- P := ???
```

<ul>
<li class="fragment" data-code-focus="2,3">Für <code>A</code> : Expression <code>a</code> ist [<code>Banane</code>, <strong>lvalue</strong>] ⟶ add <code>&amp;</code> ⟶ <code>A := Banane&amp;</code> </li>
<li class="fragment" data-code-focus="5,6">Für <code>P</code> : ⟶ entferne <code>const/&amp;</code> ⟶ <code>P := T</code>.</li>
<li class="fragment" data-code-focus="2,6">Pattern-Match: ⟶ <code>T := Banane&amp;</code> ⟶ Ref. Coll. ⟶ <code>T&amp;&amp; := Banane&amp;</code></li>
</ul>

---

### Wie funktioniert `std::forward<T>`

Zwei Overloads:

1. Um **lvalues** als **lvalues/rvalues** zu forwarden (abh. von `T`)

```cpp
template<typename T>
T&& forward(lvalue-Reference v){
    return static_cast<T&&>(v);
};
```

2. Um **rvalues** nur als **rvalues** zu forwarden (Esotherische Cases)

```cpp
template<typename T>
T&& forward(rvalue-Reference v){
    // static-assert: T keine lvalue-Reference
    return static_cast<T&&>(v);
};
```

[[Live](http://coliru.stacked-crooked.com/a/616e7652791e2005)]
Good Read: [N2951](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2009/n2951.html)

---

### Benutzen von `std::forward`

<strong>Merke:</strong> <strong style="color:blue"><code>std::forward</code> geht immer zusammen mit einer **forwarding**-Referenz `T&&` !</strong>

```cpp
template<typename T>;
struct Shake {
    void doIt(T&& fruit);
    //        ^^^ -------- keine forwarding-Referenz,
    //                     da `T` hier nicht mehr deduziert wird!
}
```

<pre class="fragment" data-code-focus="3-4" data-code-block="2">
<code class="language-cpp stretch" data-trim>
template&lt;typename T&gt;
struct Shake {
    template&lt;typename F&gt;
    void doIt(F&& fruit);
    //        ^^^ --------  forwarding-Referenz, da deduziert!
    //                      ('const F&&' wäre keine)
}
</code></pre>

---

### Zusammenfassung `std::move`

- `std::move(expr)` wandelt die Expression `expr` zu einer **rvalue** um (retourniert ein *xvalue*). Man macht diesen Cast um anzugeben, dass man sich nicht länger um den Wert von `expr` kümmert **nach der Auswertung der Expression** in welchem dieser Wert gebraucht wurde. Zum Beispiel:

```cpp
y = std::move(x);
// `y` hat den Wert von `x` und `x` interessiert uns nicht mehr
x = getNewValue(); // weil wir (optional) einen neuen Wert zuweisen.
```

<strong>Merke:</strong>
<span style="color:blue;">Wann immer man eine **rvalue**-Referenz hat (e.g. `Banane&& rB`, d.h. es geht um temporäre Objekte), kommt `std::move` zur Anwendung.<span>

---

### Zusammenfassung `std::forward`

- `std::forward<T>(expr)` is ähnlich zu `std::move(expr)` und **kann** zu einem **rvalue** umwandeln. Es hat jedoch zwei Eingaben: `expr` und `T`. `T` wird benutzt um zu entscheiden ob ein **lvalue** oder ein **rvalue** retourniert wird. Wenn `T` eine **lvalue**-Referenz ist, dann wird eine **lvalue**-Referenz (&) auf `expr` retourniert ansonsten eine **rvalue**-Referenz (&&).

```cpp
struct A{} x,y,z;
y = std::forward<A&>(x);  // `x` wird nach `y` kopiert
z = std::forward<A>(x);   // `x` wird nach `z` gemoved.
```

<strong>Merke:</strong>
<span style="color:blue;">Wann immer man eine <strong>forwarding</strong>-Referenz hat</span>:

```cpp
template<typename T> foo(T&& rB)
```

<span style="color:blue;">kommt `std::forward<T>(rB)` zur Anwendung.</span>

---

### Beispiel 6: `std::make_unique`

```cpp
Kiwi k;
auto spShake = std::make_unique<Shake>(Banane{"mushy"}, k);

template<typename T, typename... Args>
auto make_unique(Args&&... args)
{
    return std::unique_ptr<T>(new T(std::forward<Args>(args)...));
}
```

<span class="fragment" data-code-focus="1,2"/>
<span class="fragment" data-code-focus="7"/>
Alle variadischen Argumente <code>args</code> werden per <strong>Perfect-Forwarding</strong>
an den Konstruktor von <code>T</code> übergeben:
<ul>
<li class="fragment" data-code-focus="7"><code>Banane{"mushy"}</code> wird gemoved.</li>
<li class="fragment"data-code-focus="7" ><code>Kiwi k</code> wird kopiert.</li>
</ul>

---

### Beispiel 7: Funktor applizieren

```cpp
struct Functor{ void operator()(int a, int b){/*...*/} };
Functor func;

template<typename F>
void apply(int a, F&& f)
{
  f(a, 10);
}

apply(5, func);                         // 1. `F&&` -> `Functor&`
apply(5, createFunctor())               // 2. `F&&` -> `Functor&&`
apply(5, [](int& a, int b){ a += b; }); // 3. `F&&` -> `XXXX&&`

```

<span  class="fragment" data-code-focus="1,2"/>
<span  class="fragment" data-code-focus="4-8"/>
<span  class="fragment" data-code-focus="10"/>
<span  class="fragment" data-code-focus="11"/>
<span  class="fragment" data-code-focus="12"/>

<ul>
<li class="fragment"><strong>forwarding</strong>-Reference: Vermeidet Codeduplikationen und erweitert die Anwendbarkeit!</li>
<li class="fragment">Benutze <code>static_assert(...)</code> für gewisse Typen-Checks.</li>
</ul>

---

### Fettnäpfchen bei `T&&`

```cpp
struct Banane
{
  template<typename T>
  Banane(T&& value);

  Banane(const Banane& rBanane); // wird verdeckt!
};
```

Wird Probleme geben, da `T&&` so möglichst alles matched was man sich vorstellen kann:

- Der Copy-CTOR wird nie matchen können, weil `T&&` stärker!
- `T&&` irgendwie entfernen und Overloading verwenden oder falls alles nicht hilft
- [SFINAE](https://en.cppreference.com/w/cpp/language/sfinae)</small> verwenden (später)

---

### Expandiere Tuple in Funktion <br><small>C++17/20</small>

Wir möchten folgendes:

<pre><code class="language-cpp stretch" data-trim>
auto tuple = std::make_tuple(1, 2.0, "Banane");

invoke(tuple,
       [](int a, double b, const std::string& c)
       {
           std::cout << a << ", " << b << ", " << c << std::endl;
       });
</code></pre>

<strong>Output:</strong>

```bash
1, 2.0, Banane
```

<span class="fragment" data-code-focus="1"/>
<span class="fragment" data-code-focus="3-7"/>

---

### Expandiere Tuple in Funktion <br><small>C++17/20</small>

Wir möchten folgendes:

```cpp
invoke(std::make_tuple(1, 2.0, "Banane"),
       [](int a, double b, const std::string& c){});
```

Wie erreichen wir das:

<ul>
<li class="fragment">Template Funktion <code>invoke</code>.</li>
<li class="fragment"><strong>forwarding</strong>-Referenzen brauchen, damit <code>invoke(std::make_tuple(...))</code> möglich.</li>
<li class="fragment">Meta-Programming möglichst <strong>einfach und lesbar</strong>! ⟶ Template Lambdas und Variadische Parameter <code>Args...</code> wegen Tuple.</li>
<li class="fragment"><code>std::get&lt;I&gt;(tuple)</code> um den <code>I</code>-ten Wert des Tuples zurückzugeben.</li>
</ul>

---

### Expandiere Tuple in Funktion <br><small>C++17/20, [[Live](https://wandbox.org/permlink/xQS9fqvTlWBYAg8E)]</small>

```cpp
template<typename T, typename F>
void invoke(T&& tuple, F&& func)
{
    auto makeRange = []<typename... Args> (std::tuple<Args...>)
    {   //     std::index_sequence<0,1,2,3,..., N-1>
        return std::make_index_sequence<sizeof...(Args)>{};
    };

    auto call = [&]<std::size_t... I> (std::index_sequence<I...>){
        func(std::get<I>(tuple)...);
    };

    call(makeRange(tuple));
}
```

- C++17: Lambdas sind implizit <code>constexpr</code> falls möglich.

<span class="fragment" data-code-focus="4-7,13"/>
<span class="fragment" data-code-focus="9-11,13"/>

---

# Questions

<div class="center-me">
  <div  style="width:35%;height:auto;">
  <img class="no-border" src="files/cpp-meeting/Questions.png">
  </div>
</div>

Maybe Teil 3: Spezialisierung, Sfinae, etc... ?
